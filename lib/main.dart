import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:excel/excel.dart';
import 'package:green_raiders/constants.dart';
import 'package:green_raiders/screens/Auth/components/auth_screen.dart';
import 'package:green_raiders/constants.dart';
import 'package:green_raiders/screens/Splash/components/splash_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: 'whatever',
    options: FirebaseOptions(
      apiKey: "AIzaSyBcfix7Bq44Yu_VpbKUpHkIxmZis0g_2Sk",
      appId: "XXX",
      messagingSenderId: "XXX",
      projectId: "XXX",
    ),
  );
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "hello",
      theme: ThemeData(

        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32)
            )
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: Size.fromHeight(50),
            textStyle: TextStyle(fontSize: 20),
            backgroundColor: kPrimaryColor,
            primary: Colors.white,
          ),
        ),
      ),
      home: Scaffold(
        body: SplashScreen(),
        // body: AuthPage(),
      ),
    );
  }
}


