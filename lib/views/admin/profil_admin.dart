import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fissy/views/admin/detail_profile_admin.dart';
import 'package:flutter/material.dart';

class ProfilAdminPage extends StatefulWidget {
  const ProfilAdminPage({super.key});

  @override
  State<ProfilAdminPage> createState() => _ProfilAdminPageState();
}

class _ProfilAdminPageState extends State<ProfilAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fissy Admin',
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
              .collection('admins')
              .doc('6ZAbAeqMfPX5U2ko0FLn0f8gnRC2')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {}
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (snapshot.hasData && snapshot.data != null) {
              var data = snapshot.data!.data() as Map<String, dynamic>?;
              var namaLengkap = data?['namaLengkap'] ?? '';
              var alamatEmail = data?['alamatEmail'] ?? '';
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
                                    const DetailProfileAdmin(),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$namaLengkap - Admin',
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
            return const Center(child: Text('Data admin tidak ditemukan'));
          },
        ),
      ),
    );
  }
}