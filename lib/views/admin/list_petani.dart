import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fissy/riwayat_pengecekan.dart';

class PetaniTambak extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fissy Admin",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color.fromRGBO(167, 217, 255, 1),
      ),
      body: Container(
        width: 400,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('petanis').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(child: Text('Data tidak ditemukan'));
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];
                Map<String, dynamic> farmer =
                    doc.data() as Map<String, dynamic>;
                return _buildFarmerCard(context, farmer);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildFarmerCard(BuildContext context, Map<String, dynamic> farmer) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: InkWell(
        onTap: () {
          _navigateToRiwayatPengecekan(context);
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                farmer['namaLengkap'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Email: ${farmer['alamatEmail']}'),
              Text('Username: ${farmer['username']}'),
              Text('Telepon: ${farmer['nomorTelepon']}'),
              Text('Alamat: ${farmer['alamat']}'),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _navigateToRiwayatPengecekan(context);
                    },
                    child: Text('Cek Riwayat Pengecekan'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToRiwayatPengecekan(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => riwayat_pengecekan(
          collectionPath: 'riwayat_pengecekan',
          firestore: FirebaseFirestore.instance,
        ),
      ),
    );
  }
}
