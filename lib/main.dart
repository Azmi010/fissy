import 'package:fissy/providers/user_provider.dart';
// import 'package:fissy/utils/coba.dart';
import 'package:fissy/views/auth/login_page.dart';
// import 'package:fissy/views/petani_tambak/homepage_petani.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:gauge_indicator/gauge_indicator.dart';
// import 'package:fissy/profil.dart';
// import 'package:fissy/riwayat_pengecekan.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MaterialApp(
        title: 'Fissy App',
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
