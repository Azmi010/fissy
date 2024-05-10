import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class RadialGaugeWidget extends StatefulWidget {
  const RadialGaugeWidget({super.key});

  @override
  State<RadialGaugeWidget> createState() => _RadialGaugeWidgetState();
}

class _RadialGaugeWidgetState extends State<RadialGaugeWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('turbidity_data')
          .doc('data')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('Data tidak ditemukan');
        }

        double turbidityValue =
            snapshot.data!.get('turbidity_value').toDouble();

        return AnimatedRadialGauge(
          duration: const Duration(seconds: 1),
          curve: Curves.elasticOut,
          radius: 100,
          value: turbidityValue,
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
                to: 5,
                color: Colors.blue.shade600,
                cornerRadius: Radius.circular(8),
              ),
              GaugeSegment(
                border: GaugeBorder(color: Colors.white),
                from: 5,
                to: 50,
                color: Colors.yellow.shade600,
                cornerRadius: Radius.circular(8),
              ),
              GaugeSegment(
                border: GaugeBorder(color: Colors.white),
                from: 50,
                to: 100,
                color: Colors.red.shade500,
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
        );
      },
    );
  }
}