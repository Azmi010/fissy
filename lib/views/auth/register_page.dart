import 'package:fissy/utils/util.dart';
import 'package:fissy/utils/util_textfield.dart';
import 'package:fissy/viewmodels/register_viewmodel.dart';
import 'package:fissy/views/auth/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController namaLengkapController;
  late TextEditingController alamatEmailController;
  late TextEditingController usernameController;
  late TextEditingController noTeleponController;
  late TextEditingController alamatController;
  late TextEditingController passwordController;
  late TextEditingController konfirmasiPasswordController;

  @override
  void initState() {
    super.initState();
    namaLengkapController = TextEditingController();
    alamatEmailController = TextEditingController();
    usernameController = TextEditingController();
    noTeleponController = TextEditingController();
    alamatController = TextEditingController();
    passwordController = TextEditingController();
    konfirmasiPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    namaLengkapController.dispose();
    alamatEmailController.dispose();
    usernameController.dispose();
    noTeleponController.dispose();
    alamatController.dispose();
    passwordController.dispose();
    konfirmasiPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerViewModel = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                    margin: const EdgeInsets.only(top: 50),
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
                      'Nama Lengkap',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: namaLengkapController,
                    hintText: 'cth: Ulul Ganteng Jr.',
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
                      'Alamat Email',
                      style: TextStyle(
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
                    hintText: 'cth: ulultambak@mail.unej.ac.id',
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
                      'Username',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: usernameController,
                    hintText: 'cth: ulultambak123',
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
                      'Nomor Telepon',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: noTeleponController,
                    hintText: 'cth: +628900000000',
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
                      'Alamat',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: alamatController,
                    hintText: 'cth: Jember, Jawa Timur',
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
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Konfirmasi Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: konfirmasiPasswordController,
                    hintText: 'Masukkan ulang password anda',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Data harus diisi';
                      }
                      if (value != passwordController.text) {
                        return 'Password tidak sesuai';
                      }
                      return null;
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: 'Sudah punya akun? ',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'Masuk',
                            style: const TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                          ),
                          const TextSpan(
                            text: ' sekarang juga',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 40),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          registerViewModel.registerUser(
                            namaLengkap: namaLengkapController.text,
                            alamatEmail: alamatEmailController.text,
                            username: usernameController.text,
                            noTelepon: noTeleponController.text,
                            alamat: alamatController.text,
                            password: passwordController.text,
                            onRegisterSuccess: (user) {
                              showCustomDialog(
                                context,
                                icon: Icons.check_circle,
                                title: 'Berhasil',
                                message: 'Berhasil membuat akun',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                              );
                            },
                            onRegisterError: (error) {
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
                        'Daftar',
                        style: TextStyle(
                          color: Colors.white,
                        ),
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
}
