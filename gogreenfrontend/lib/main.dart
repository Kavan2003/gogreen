import 'package:flutter/material.dart';
import 'package:gogreenfrontend/screens/home/home.dart';
import 'package:gogreenfrontend/screens/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
