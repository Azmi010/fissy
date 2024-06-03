import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fissy/riwayat_pengecekan.dart';
import 'package:fissy/utils/radial_gauge.dart';
import 'package:flutter/material.dart';

class HomePagePetani extends StatefulWidget {
  const HomePagePetani({super.key});

  @override
  State<HomePagePetani> createState() => _HomePagePetaniState();
}

class _HomePagePetaniState extends State<HomePagePetani> {
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
          "Fissy Petani Tambak",
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
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('petanis')
                  .doc(_currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.hasData && snapshot.data != null) {
                  var userData = snapshot.data!.data() as Map<String, dynamic>?;
                  var username = userData?['username'];
                  return Text(
                    'Halo, Selamat Datang di Fissy, $username!',
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                    ),
                  );
                }
                return const Text('Data pengguna tidak ditemukan');
              },
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Tingkat Kejernihan \n   Air Kolam Anda:",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const RadialGaugeWidget(),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 340,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(255, 255, 255, 0.8)),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Center(
                  child: Text(
                'Stok Pupuk: 88.88 ml',
                style: TextStyle(fontSize: 24, fontFamily: 'Poppins'),
              )),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RiwayatPengecekan(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(230, 33),
                backgroundColor: const Color.fromRGBO(17, 35, 90, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                "Cek Riwayat Penyiraman",
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
