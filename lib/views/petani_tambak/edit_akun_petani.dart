import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fissy/utils/util.dart';
import 'package:fissy/views/petani_tambak/detail_profile_petani.dart';
import 'package:flutter/material.dart';

class EditAkunPetani extends StatefulWidget {
  const EditAkunPetani({super.key});

  @override
  State<EditAkunPetani> createState() => _EditAkunPetaniState();
}

class _EditAkunPetaniState extends State<EditAkunPetani> {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController noTeleponController = TextEditingController();

  late User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    oldPasswordController.dispose();
    alamatController.dispose();
    noTeleponController.dispose();
    super.dispose();
  }

  void simpanData() {
    try {
      FirebaseFirestore.instance
          .collection('petanis')
          .doc(_currentUser?.uid)
          .update({
        'namaLengkap': namaController.text,
        'alamatEmail': emailController.text,
        'username': usernameController.text,
        'alamat': alamatController.text,
        'nomorTelepon': noTeleponController.text,
      });

      if (passwordController.text.isNotEmpty) {
        FirebaseAuth.instance.signInWithEmailAndPassword(
            email: FirebaseAuth.instance.currentUser!.email!,
            password: oldPasswordController.text);
        FirebaseAuth.instance.currentUser!
            .updatePassword(passwordController.text);
      }

      showCustomDialog(context,
          icon: Icons.check_circle_outline,
          title: 'Berhasil',
          message: 'Data Berhasil diubah', onPressed: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const DetailProfilePetani()));
      });
    } catch (error) {
      // print('Error saat menyimpan data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Fissy Petani',
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
        child: SingleChildScrollView(
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('petanis')
                .doc(_currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {}
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              if (snapshot.hasData && snapshot.data != null) {
                var userData = snapshot.data!.data() as Map<String, dynamic>?;
                namaController.text = userData?['namaLengkap'] ?? '';
                emailController.text = userData?['alamatEmail'] ?? '';
                usernameController.text = userData?['username'] ?? '';
                alamatController.text = userData?['alamat'] ?? '';
                noTeleponController.text = userData?['nomorTelepon'] ?? '';
                var namaLengkap = userData?['namaLengkap'] ?? '';
                var alamatEmail = userData?['alamatEmail'] ?? '';
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
                      margin:
                          const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
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
                          Expanded(
                            child: TextFormField(
                              controller: namaController,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'apa',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
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
                          Expanded(
                            child: TextFormField(
                              controller: usernameController,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'apa',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Password Lama',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: oldPasswordController,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Masukkan Password Lama',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Password Baru',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: passwordController,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Masukkan Password Baru',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
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
                          Expanded(
                            child: TextFormField(
                              controller: alamatController,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'apa',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
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
                          Expanded(
                            child: TextFormField(
                              controller: noTeleponController,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'apa',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: simpanData,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(13, 110, 253, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fixedSize: const Size(160, 38),
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailProfilePetani()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(220, 53, 69, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fixedSize: const Size(160, 38),
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
