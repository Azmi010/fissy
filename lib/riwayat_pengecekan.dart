import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class RiwayatPengecekan extends StatefulWidget {
  final String? collectionPath;

  const RiwayatPengecekan({Key? key, this.collectionPath}) : super(key: key);

  @override
  _RiwayatPengecekanState createState() => _RiwayatPengecekanState();
}

class _RiwayatPengecekanState extends State<RiwayatPengecekan> {
  late final FirebaseDatabase database;

  @override
  void initState() {
    super.initState();
    database = FirebaseDatabase(
      databaseURL:
          'https://iot-24-b9060-default-rtdb.asia-southeast1.firebasedatabase.app',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Riwayat Penyiraman'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: 400,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<DatabaseEvent>(
          stream: database.ref('informasi_pengecekans').onValue,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
              return Center(child: Text('No data available'));
            }

            final data = snapshot.data!.snapshot.value;
            if (data is! Map<dynamic, dynamic>) {
              return Center(child: Text('Unexpected data format'));
            }

            final documents = data.values.toList();

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final item = documents[index];

                if (item is! Map<dynamic, dynamic>) {
                  return ListTile(
                    title: Text('Invalid item format'),
                  );
                }

                final kejernihanAirInformasiPengecekan =
                    item['kejernihanAirInformasiPengecekan'];
                final kejernihanAirKlasifikasi =
                    item['kejernihanAirKlasifikasi'];
                final timestamp = item['timestamp'];

                if (kejernihanAirInformasiPengecekan == null ||
                    kejernihanAirKlasifikasi == null ||
                    timestamp == null) {
                  return ListTile(
                    title: Text('Invalid item format'),
                  );
                }

                DateTime dateTime;
                try {
                  dateTime = DateTime.parse(timestamp);
                } catch (e) {
                  return ListTile(
                    title: Text('Invalid date format'),
                  );
                }

                String formattedDate =
                    DateFormat('dd/MM/yyyy').format(dateTime);

                final description =
                    'Kejernihan: $kejernihanAirInformasiPengecekan\nKlasifikasi: $kejernihanAirKlasifikasi';

                return HistoryItem(
                  date: formattedDate,
                  description: description,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String date;
  final String description;

  const HistoryItem({Key? key, required this.date, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(description),
        ],
      ),
    );
  }
}
