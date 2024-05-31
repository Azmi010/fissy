import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fissy/providers/firebase_auth_services.dart';
import 'package:fissy/utils/util.dart';
import 'package:fissy/utils/util_textfield.dart';
import 'package:fissy/views/admin/bottom_navbar_admin.dart';
import 'package:fissy/views/auth/register_page.dart';
import 'package:fissy/views/petani_tambak/bottom_navbar_petani.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController alamatEmailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    alamatEmailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    alamatEmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 851,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 100),
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: const Image(
                        image: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Alamat Email',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: alamatEmailController,
                    hintText: 'Masukkan email anda',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Data harus diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Masukkan password anda',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Data harus diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Lupa Password?',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(39, 79, 245, 1)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String email = alamatEmailController.text;
                        String password = passwordController.text;

                        _login(
                          email,
                          password,
                          (user) {
                            if (user.uid == 'l2yJomqWjrQsJ6DwusHw123QM3n1') {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NavbarAdmin(initialIndex: 0,)),
                                (route) => false,
                              );
                            } else {
                              _checkNotificationStatus(
                                user.uid,
                                () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NavbarPetani(initialIndex: 0,)),
                                    (route) => false,
                                  );
                                },
                                (error) {
                                  showCustomDialog(
                                    context,
                                    icon: Icons.error_outline,
                                    title: 'Gagal',
                                    message: error,
                                    onPressed: () {},
                                  );
                                },
                              );
                            }
                          },
                          (error) {
                            showCustomDialog(
                              context,
                              icon: Icons.error_outline,
                              title: 'Gagal',
                              message: error,
                              onPressed: () {},
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(343, 48),
                      backgroundColor: const Color.fromRGBO(17, 35, 90, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: 'Belum punya akun? ',
                        style: const TextStyle(
                            fontFamily: 'Poppins', color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Daftar',
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 1000),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = const Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;
                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const RegisterPage(),
                                  ),
                                );
                              },
                          ),
                          const TextSpan(
                            text: ' sekarang juga',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login(
    String email,
    String password,
    Function(User) onLoginSuccess,
    Function(String) onError,
  ) async {
    try {
      User? user = await _auth.login(email, password);
      if (user != null) {
        onLoginSuccess(user);
      } else {
        onError('Gagal');
      }
    } catch (error) {
      onError('Gagal');
    }
  }

  void _checkNotificationStatus(
    String uid,
    Function onSuccess,
    Function(String) onError,
  ) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('notifikasis')
          .doc(uid)
          .get();

      if (snapshot.exists) {
        bool status = snapshot['status'];
        if (status) {
          onSuccess();
        } else {
          onError('Akun Anda belum diverifikasi.');
        }
      } else {
        onError('Data notifikasi tidak ditemukan.');
      }
    } catch (error) {
      onError('Gagal memeriksa status notifikasi.');
    }
  }
}
