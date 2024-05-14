import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: CobaApp(),
  ));
}

class CobaApp extends StatefulWidget {
  const CobaApp({super.key});

  @override
  State<CobaApp> createState() => _CobaAppState();
}

class _CobaAppState extends State<CobaApp> {
  late final FirebaseDatabase fb;
  String _data = 'Memuat...';
  final String idPengecekan = 'id_pengecekan'; // Ubah ini dengan ID yang sesuai

  @override
  void initState() {
    super.initState();
    fb = FirebaseDatabase(
      databaseURL: 'https://iot-24-b9060-default-rtdb.asia-southeast1.firebasedatabase.app',
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
    print('Listener dipasang pada ref: ${ref.child('kejernihanAirInformasiPengecekan').path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(_data),
      ),
    );
  }
}
