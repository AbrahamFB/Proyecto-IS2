import 'package:flutter/material.dart';
import 'package:qr_reader/page/qr_scan.dart';
import 'package:qr_reader/src/pages/login/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABCU',
      debugShowCheckedModeBanner: false,
initialRoute: 'login',
      routes: {
        'login':(BuildContext context)=> LoginPage(),
        'qr':(BuildContext context)=> QrScan(),
      },
    );
  }
}