import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fissy/views/admin/notifikasi.dart';
import 'package:flutter/material.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
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
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Notifikasi()),
              );
            },
          ),
        ],
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
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('admins')
                      .doc('6ZAbAeqMfPX5U2ko0FLn0f8gnRC2')
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {}
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    if (snapshot.hasData && snapshot.data != null) {
                      var data = snapshot.data!.data() as Map<String, dynamic>?;
                      var username = data?['username'] ?? '';
          
                      return Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Halo, Selamat Datang di Fissy, $username!",
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                          ),
                        ),
                      );
                    }
                    return const Center(
                        child: Text('Data admin tidak ditemukan'));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Cek Kualitas Air Kolam Anda dengan Mudah dan Cepat!",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Mudahkan pekerjaanmu bersama Kami, tak ada lagi kata susah untuk melakukan pengecekan kejernihan air secara akurat - TUNGGU APA LAGI? PAKAI FISSY SEKARANG JUGA!",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Image(
                  image: AssetImage("assets/images/admin.png"),
                  width: 343,
                )
              ],
            ),
          ),
        ),
    );
  }
}
