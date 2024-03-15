import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gogreenfrontend/screens/analysis/component_analysisform.dart';

class AnalysisScreen extends StatelessWidget {
  AnalysisScreen({Key? key}) : super(key: key);
  final gemini = Gemini.instance;
  final TextEditingController _AnalysisControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/analysis.png"),
                    Text(
                      "Enter your Observations",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Take Photos of area",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    Image.asset("assets/takephoto.png")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/submit.png"),
                    Text(
                      "Submit details",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  enableDrag: true,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AnalysisForm(),
                    ),
                  ),
                );
              },
              child: Text('Show Modal'),
              style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.2),
                  backgroundColor: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
