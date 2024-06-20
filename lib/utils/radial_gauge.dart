// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class RadialGaugeWidget extends StatefulWidget {
  const RadialGaugeWidget({super.key});

  @override
  State<RadialGaugeWidget> createState() => _RadialGaugeWidgetState();
}

class _RadialGaugeWidgetState extends State<RadialGaugeWidget> {
  late final FirebaseDatabase fb;
  String _data = 'Memuat...';
  final String idPengecekan = 'id_pengecekan'; // Ubah ini dengan ID yang sesuai

  @override
  void initState() {
    super.initState();
    fb = FirebaseDatabase(
      databaseURL:
          'https://iot-24-b9060-default-rtdb.asia-southeast1.firebasedatabase.app',
    );

    final ref = fb.ref().child('informasi_pengecekans').child(idPengecekan);
    ref.child('kejernihanAirInformasiPengecekan').onValue.listen((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.exists) {
        setState(() {
          _data = dataSnapshot.value.toString();
        });
        print('Data berhasil diambil: ${dataSnapshot.value}');
      } else {
        setState(() {
          _data = 'Data tidak ditemukan';
        });
        print('Data tidak ditemukan di jalur ini.');
      }
    }, onError: (error) {
      setState(() {
        _data = 'Error mengambil data';
      });
      print('Error: $error');
    });
    print(
        'Listener dipasang pada ref: ${ref.child('kejernihanAirInformasiPengecekan').path}');
  }

  @override
  Widget build(BuildContext context) {
    double value = 0.0; // Default value jika parsing gagal

    if (_data != 'Memuat...') {
      try {
        value = double.parse(_data);
      } catch (e) {
        print('Error parsing double: $e');
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromRGBO(255, 255, 255, 0.8),
      ),
      width: 340,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: AnimatedRadialGauge(
        duration: const Duration(seconds: 1),
        curve: Curves.elasticOut,
        radius: 100,
        value: value,
        axis: GaugeAxis(
          min: 0,
          max: 100,
          degrees: 250,
          style: const GaugeAxisStyle(
            thickness: 20,
            background: Color.fromARGB(0, 223, 226, 236),
            segmentSpacing: 4,
          ),
          progressBar: const GaugeProgressBar.rounded(
            color: Color.fromARGB(0, 180, 194, 248),
            placement: GaugeProgressPlacement.over,
          ),
          segments: [
            GaugeSegment(
              border: GaugeBorder(color: Colors.white),
              from: 0,
              to: 50,
              color: Colors.red.shade500,
              cornerRadius: Radius.circular(8),
            ),
            GaugeSegment(
              border: GaugeBorder(color: Colors.white),
              from: 50,
              to: 80,
              color: Colors.yellow.shade600,
              cornerRadius: Radius.circular(8),
            ),
            GaugeSegment(
              border: GaugeBorder(color: Colors.white),
              from: 80,
              to: 100,
              color: Colors.blue.shade600,
              cornerRadius: Radius.circular(8),
            ),
          ],
        ),
        builder: (context, child, value) => RadialGaugeLabel(
          value: value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 46,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
