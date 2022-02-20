import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:green_raiders/constants.dart';
import 'package:green_raiders/screens/Profile/componentes/profile_screen.dart';
import 'package:green_raiders/screens/Barcode/componentes/barcode_screen.dart';
import 'package:green_raiders/test.dart';
import 'package:green_raiders/screens/Analytics/components/analytics.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;
  final screens = [
    ProfilePage(),
    BarcodePage(),
    StatsPage()
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: screens[currentIndex],
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => setState(() => currentIndex = index),
      type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.account_circle_sharp), label: 'Profile', backgroundColor: kPrimaryColor),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Scan', backgroundColor: kPrimaryColor),
        BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: 'Analytics', backgroundColor: kPrimaryColor),
      ],
    ),
  );
}