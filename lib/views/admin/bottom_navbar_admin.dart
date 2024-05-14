import 'package:fissy/views/admin/homepage_admin.dart';
import 'package:fissy/views/admin/list_petani.dart';
import 'package:fissy/views/admin/profil_admin.dart';
import 'package:flutter/material.dart';

class NavbarAdmin extends StatefulWidget {
  final int initialIndex;
  const NavbarAdmin({super.key, required this.initialIndex});

  @override
  State<NavbarAdmin> createState() => _NavbarAdminState();
}

class _NavbarAdminState extends State<NavbarAdmin> {
  late int currentPageIndex;

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPageIndex,
        children: <Widget>[
          const HomePageAdmin(),
          PetaniTambak(),
          const ProfilAdminPage(),
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
            icon: Icon(Icons.people),
            label: 'Petani Tambak',
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
