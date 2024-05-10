import 'package:firebase_auth/firebase_auth.dart';
import 'package:fissy/views/auth/login_page.dart';
import 'package:flutter/material.dart';

class EditAkunPage extends StatefulWidget {
  const EditAkunPage({super.key});

  @override
  State<EditAkunPage> createState() => _EditAkunPageState();
}

class _EditAkunPageState extends State<EditAkunPage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  bool isEditing = false;

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;

      if (isEditing) {
        namaController.text = 'Ulul Ganteng - Admin 1';
        emailController.text = 'ululgantengjr@yahoo.com';
        usernameController.text = 'ulultambak123';
      } else {
        namaController.clear();
        emailController.clear();
        usernameController.clear();
      }
    });
  }

  void simpanData() {
    
    setState(() {
      // Lakukan pembaruan data di sini
      // Contoh:
      // nama = namaController.text
      // email = emailController.text
      // username = usernameController.text
    });
    toggleEdit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fissy Admin',
          style: TextStyle(
              fontFamily: 'poppins', fontWeight: FontWeight.w500, fontSize: 18),
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
        child: Column(
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
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Nama'),
                  isEditing
                      ? Expanded(
                          child: TextField(
                            controller: namaController,
                            textAlign: TextAlign.end,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      : const Text('Ulul Ganteng - Admin 1'),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Email'),
                  isEditing
                      ? Expanded(
                          child: TextField(
                            controller: emailController,
                            textAlign: TextAlign.end,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      : const Text('ululgantengjr@yahoo.com'),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Username'),
                  isEditing
                      ? Expanded(
                          child: TextField(
                            controller: usernameController,
                            textAlign: TextAlign.end,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      : const Text('ulultambak123'),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 8, top: 35),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(13, 110, 253, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  fixedSize: const Size(162, 38),
                ),
                child: const Text(
                  'Ubah Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'poppins',
                    fontSize: 14,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
            Visibility(
              visible: !isEditing,
              child: ElevatedButton(
                onPressed: toggleEdit,
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
            ),
            if (!isEditing)
              Container(
                margin: const EdgeInsets.only(top: 200),
                child: ElevatedButton(
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
              ),
            if (isEditing)
              Container(
                margin: const EdgeInsets.only(top: 200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: simpanData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(13, 110, 253, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        fixedSize: const Size(162, 38),
                      ),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'poppins',
                          fontSize: 14,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: toggleEdit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(220, 53, 69, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        fixedSize: const Size(162, 38),
                      ),
                      child: const Text(
                        'Batal',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'poppins',
                          fontSize: 14,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
