import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fissy/providers/firebase_auth_services.dart';

class RegisterViewModel extends ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();

  Future<void> registerUser({
    required String namaLengkap,
    required String alamatEmail,
    required String username,
    required String noTelepon,
    required String alamat,
    required String password,
    required Function(User) onRegisterSuccess,
    required Function(String) onRegisterError,
  }) async {
    try {
      User? user = await _authService.daftar(alamatEmail, password);
      if (user != null) {
        // Assuming you have Firebase Firestore or any other database service.
        // Replace the below line with your database operation.
        await FirebaseFirestore.instance.collection('petanis').doc(user.uid).set({
          'namaLengkap': namaLengkap,
          'alamatEmail': alamatEmail,
          'username': username,
          'nomorTelepon': noTelepon,
          'alamat': alamat,
        });
        onRegisterSuccess(user);
      }
    } catch (error) {
      String errorMessage = 'Gagal membuat akun';
      if (error is FirebaseAuthException) {
        if (error.code == 'email-already-in-use') {
          errorMessage = 'Email sudah terdaftar';
        } else {
          errorMessage = 'Terjadi kesalahan: ${error.message}';
        }
      }
      onRegisterError(errorMessage);
    }
  }
}
