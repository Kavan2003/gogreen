import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gogreenfrontend/screens/home/home.dart';
import 'package:gogreenfrontend/screens/login/login.dart';
import 'package:gogreenfrontend/util/govapi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  Gemini.init(apiKey: 'AIzaSyBmi7YS3LpwClfeTlozL9scHrX7d8ThBos');
  // final responseMap = await fetchApiResponse();

  // Convert the Map to ApiResponse object
  // final apiResponse = ApiResponse.fromJson();

  // Access top-level data
  // print(apiResponse.message); // Output: Resource lists
  // print(apiResponse.records.length); // Number of records

  // // Loop through records
  // for (final record in apiResponse.records) {
  //   print("Country: ${record.country}");
  //   print("Pollutant ID: ${record.pollutantId}");
  //   print("Average Pollutant Value: ${record.pollutantAvg}");
  //   print("----");
  // }
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
