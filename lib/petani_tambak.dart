import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fissy/riwayat_pengecekan.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PetaniTambak(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PetaniTambak extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('petanis').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(child: Text('Data tidak ditemukan'));
          }
          List<DocumentSnapshot> docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> farmer =
                  docs[index].data() as Map<String, dynamic>;
              return _buildFarmerCard(
                context,
                farmer['namaPetani'].toString(),
                farmer['emailPetani'].toString(),
                farmer['usernamePetani'].toString(),
                farmer['nomorTeleponPetani'].toString(),
                farmer['AlamatPetani'].toString(),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildFarmerCard(
    BuildContext context,
    String namaPetani,
    String emailPetani,
    String usernamePetani,
    String nomorTeleponPetani,
    String AlamatPetani,
  ) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => riwayat_pengecekan(
                collectionPath: 'riwayat_pengecekan',
                firestore: FirebaseFirestore.instance,
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                namaPetani,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Email: $emailPetani'),
              Text('Username: $usernamePetani'),
              Text('Telepon: $nomorTeleponPetani'),
              Text('Alamat: $AlamatPetani'),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => riwayat_pengecekan(
                            collectionPath: 'riwayat_pengecekan',
                            firestore: FirebaseFirestore.instance,
                          ),
                        ),
                      );
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
}
