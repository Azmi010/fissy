import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fissy/views/petani_tambak/detail_profile_petani.dart';
import 'package:flutter/material.dart';

class ProfilPetaniPage extends StatefulWidget {
  const ProfilPetaniPage({super.key});

  @override
  State<ProfilPetaniPage> createState() => _ProfilPetaniPageState();
}

class _ProfilPetaniPageState extends State<ProfilPetaniPage> {
  late User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fissy Petani',
          style: TextStyle(
              fontFamily: 'poppins', fontWeight: FontWeight.w500, fontSize: 18),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(167, 217, 255, 1),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('petanis')
              .doc(_currentUser?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {}
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.hasData && snapshot.data != null) {
              var userData = snapshot.data!.data() as Map<String, dynamic>?;
              var namaLengkap = userData?['namaLengkap'];
              var alamatEmail = userData?['alamatEmail'];
              return Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(bottom: 20, left: 20),
                    child: const Text(
                      'Profil',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, bottom: 40),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: const Image(
                            image: AssetImage('assets/images/logo.png'),
                            width: 64,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DetailProfilePetani(),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$namaLengkap - Petani',
                                  style: const TextStyle(
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  '$alamatEmail',
                                  style: const TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 13,
                                      color: Color.fromRGBO(171, 171, 171, 1)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Text('Data pengguna tidak ditemukan');
          },
        ),
      ),
    );
  }
}
