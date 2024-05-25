import 'package:firebase_auth/firebase_auth.dart';
import 'package:fissy/providers/firebase_auth_services.dart';
import 'package:fissy/utils/util.dart';
import 'package:fissy/views/admin/bottom_navbar_admin.dart';
import 'package:fissy/views/petani_tambak/bottom_navbar_petani.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuthService _auth = FirebaseAuthService();

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      User? user = await _auth.login(email, password);
      if (user != null) {
        if (user.uid == 'l2yJomqWjrQsJ6DwusHw123QM3n1') {
          showCustomDialog(
            context,
            icon: Icons.check_circle,
            title: 'Berhasil',
            message: 'Login berhasil',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NavbarAdmin(initialIndex: 0),
                  ),
                  (route) => false);
            },
          );
        } else {
          showCustomDialog(
            context,
            icon: Icons.check_circle,
            title: 'Berhasil',
            message: 'Login berhasil',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NavbarPetani(initialIndex: 0),
                  ),
                  (route) => false);
            },
          );
        }
      } else {
        showCustomDialog(
          context,
          icon: Icons.error_outline,
          title: 'Gagal',
          message: 'Login gagal',
          onPressed: () {},
        );
      }
    } catch (error) {
      showCustomDialog(
        context,
        icon: Icons.error_outline,
        title: 'Gagal',
        message: error.toString(),
        onPressed: () {},
      );
    }
  }
}
