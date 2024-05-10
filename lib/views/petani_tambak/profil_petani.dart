import 'package:fissy/views/admin/edit_akun_admin.dart';
import 'package:flutter/material.dart';

class ProfilPetaniPage extends StatefulWidget {
  const ProfilPetaniPage({super.key});

  @override
  State<ProfilPetaniPage> createState() => _ProfilPetaniPageState();
}

class _ProfilPetaniPageState extends State<ProfilPetaniPage> {
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
        child: Column(
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
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ulul Ganteng - Admin 1',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Text(
                          'ululgantengjr@yahoo.com',
                          style: TextStyle(
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
              margin: const EdgeInsets.only(left: 20, bottom: 25, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Akun Saya'),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EditAkunPage()),
                      );
                    },
                    child: const Icon(Icons.keyboard_arrow_right),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, bottom: 25, right: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pengaturan'),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Bantuan & Dukungan'),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
