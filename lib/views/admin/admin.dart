import 'package:fissy/profil.dart';
import 'package:fissy/views/admin/list_petani.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FissyPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FissyPage extends StatefulWidget {
  @override
  _FissyPageState createState() => _FissyPageState();
}

class _FissyPageState extends State<FissyPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    BerandaPage(),
    PetaniTambak(),
    profil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: Text('Fissy Admin'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Petani Tambak',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
      backgroundColor: Colors.transparent,
      selectedItemColor: Color.fromARGB(255, 255, 255, 255),
      elevation: 0,
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}

class BerandaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeaderText('Halo, Selamat Datang di Fissy, Ulul!', 13),
          _buildDescription(
              'Cek Kualitas Air\nKolam Anda dengan\nMudah dan Cepat!', 25),
          _buildDescriptionText(
              'Mudahkan pekerjaanmu bersama Kami, tak ada lagi kata susah untuk melakukan pengecekan kejernihan air secara akurat - TUNGGU APA LAGI? PAKAI FISSY SEKARANG JUGA!'),
          _buildCenteredAndAlignedImage(),
        ],
      ),
    );
  }

  Widget _buildHeaderText(String text, double fontSize,
      [FontWeight fontWeight = FontWeight.normal]) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 80, 16, 0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  Widget _buildDescription(String text, double fontSize,
      [FontWeight fontWeight = FontWeight.normal]) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDescriptionText(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildCenteredAndAlignedImage() {
    return Center(
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Image.asset('assets/image/admin.png'),
        ),
      ),
    );
  }
}
