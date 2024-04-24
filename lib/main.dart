import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:fissy/profil.dart';
import 'package:fissy/riwayat_pengecekan.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gauge Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RadialGaugeWidget extends StatefulWidget {
  @override
  _RadialGaugeWidgetState createState() => _RadialGaugeWidgetState();
}

class _RadialGaugeWidgetState extends State<RadialGaugeWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('turbidity_data')
          .doc('data')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('Data tidak ditemukan');
        }

        double turbidityValue =
            snapshot.data!.get('turbidity_value').toDouble();

        return AnimatedRadialGauge(
          duration: const Duration(seconds: 1),
          curve: Curves.elasticOut,
          radius: 100,
          value: turbidityValue,
          axis: GaugeAxis(
            min: 0,
            max: 100,
            degrees: 250,
            style: const GaugeAxisStyle(
              thickness: 20,
              background: Color.fromARGB(0, 223, 226, 236),
              segmentSpacing: 4,
            ),
            progressBar: const GaugeProgressBar.rounded(
              color: Color.fromARGB(0, 180, 194, 248),
              placement: GaugeProgressPlacement.over,
            ),
            segments: [
              GaugeSegment(
                border: GaugeBorder(color: Colors.white),
                from: 0,
                to: 5,
                color: Colors.blue.shade600,
                cornerRadius: Radius.circular(8),
              ),
              GaugeSegment(
                border: GaugeBorder(color: Colors.white),
                from: 5,
                to: 50,
                color: Colors.yellow.shade600,
                cornerRadius: Radius.circular(8),
              ),
              GaugeSegment(
                border: GaugeBorder(color: Colors.white),
                from: 50,
                to: 100,
                color: Colors.red.shade500,
                cornerRadius: Radius.circular(8),
              ),
            ],
          ),
          builder: (context, child, value) => RadialGaugeLabel(
            value: value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 46,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    profil(),
    riwayat_pengecekan(
        collectionPath: 'riwayat_pengecekan',
        firestore: FirebaseFirestore.instance),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: Text('FISSY, PETANI TAMBAK'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: _pages.elementAt(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 255, 255, 255),
        onTap: _onItemTapped,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

class GaugePage extends StatelessWidget {
  final String text;

  GaugePage(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HALO, SELAMAT DATANG DI FISSY ULUL !',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                RadialGaugeWidget(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => riwayat_pengecekan(
                                collectionPath: 'riwayat_pengecekan',
                                firestore: FirebaseFirestore.instance,
                              )),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    backgroundColor: const Color.fromARGB(255, 0, 89, 161),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'RIWAYAT PENGECEKAN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GaugePage('TINGKAT KEJERNIHAN \n           AIR ANDA');
  }
}
