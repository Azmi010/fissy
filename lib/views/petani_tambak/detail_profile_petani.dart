import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fissy/views/auth/login_page.dart';
import 'package:fissy/views/petani_tambak/bottom_navbar_petani.dart';
import 'package:fissy/views/petani_tambak/edit_akun_petani.dart';
import 'package:flutter/material.dart';

class DetailProfilePetani extends StatefulWidget {
  const DetailProfilePetani({super.key});

  @override
  State<DetailProfilePetani> createState() => _DetailProfilePetaniState();
}

class _DetailProfilePetaniState extends State<DetailProfilePetani> {
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
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NavbarPetani(
                      initialIndex: 1,
                    ),
                  ),
                );
              },
            ),
            const Text(
              'Fissy Petani',
              style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(167, 217, 255, 1),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
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
                var namaLengkap = userData?['namaLengkap'] ?? '';
                var alamatEmail = userData?['alamatEmail'] ?? '';
                var username = userData?['username'] ?? '';
                var alamat = userData?['alamat'] ?? '';
                var nomorTelepon = userData?['nomorTelepon'] ?? '';
                return Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(bottom: 20, left: 20),
                      child: const Text(
                        'Akun Saya',
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
                          Container(
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
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Nama',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '$namaLengkap',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Email',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '$alamatEmail',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Username',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '$username',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Password',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '******',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Alamat',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '$alamat',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Nomor Telepon',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '$nomorTelepon',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditAkunPetani()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(17, 35, 90, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        fixedSize: const Size(162, 38),
                      ),
                      child: const Text(
                        'Edit Data Akun',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'poppins',
                          fontSize: 14,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(220, 53, 69, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        fixedSize: const Size(162, 38),
                      ),
                      child: const Text(
                        'Keluar',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'poppins',
                          fontSize: 14,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: Text('Data admin tidak ditemukan'));
            },
          ),
        ),
      ),
    );
  }
}
