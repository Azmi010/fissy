import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class riwayat_pengecekan extends StatefulWidget {
  final String collectionPath;
  final FirebaseFirestore firestore;

  const riwayat_pengecekan(
      {Key? key, required this.collectionPath, required this.firestore})
      : super(key: key);

  @override
  _RiwayatPengecekanState createState() => _RiwayatPengecekanState();
}

class _RiwayatPengecekanState extends State<riwayat_pengecekan> {
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
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream:
                widget.firestore.collection(widget.collectionPath).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Not Found'));
              }
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              var documents = snapshot.data!.docs;

              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  var item = documents[index];

                  // Konversi Timestamp ke DateTime
                  DateTime dateTime = (item['date'] as Timestamp).toDate();

                  // Ubah format tanggal ke "day/month/year"
                  String formattedDate =
                      DateFormat('dd/MM/yyyy').format(dateTime);

                  var description = item['description'].toString();

                  return HistoryItem(
                    date: formattedDate,
                    description: description,
                  );
                },
              );
            },
          ),
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
