import 'package:fissy/views/petani_tambak/homepage_petani.dart';
import 'package:fissy/views/petani_tambak/profil_petani.dart';
import 'package:flutter/material.dart';

class NavbarPetani extends StatefulWidget {
  const NavbarPetani({super.key});

  @override
  State<NavbarPetani> createState() => _NavbarPetaniState();
}

class _NavbarPetaniState extends State<NavbarPetani> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPageIndex,
        children: const <Widget>[
          HomePagePetani(),
          ProfilPetaniPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(190, 218, 250, 1),
        selectedItemColor: Colors.white,
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
