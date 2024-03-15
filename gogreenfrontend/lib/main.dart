import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gogreenfrontend/screens/home/home.dart';
import 'package:gogreenfrontend/screens/login/login.dart';

void main() {
  Gemini.init(apiKey: 'AIzaSyBmi7YS3LpwClfeTlozL9scHrX7d8ThBos');

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
