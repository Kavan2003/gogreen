import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

import '../../util/constants.dart';

class AnalysisForm extends StatefulWidget {
  @override
  State<AnalysisForm> createState() => _AnalysisFormState();
}

class _AnalysisFormState extends State<AnalysisForm> {
  final primaryReasonsController = TextEditingController();
  final numPeopleObservedController = TextEditingController();
  final observationsController = TextEditingController();
  final visibilityController = TextEditingController();
  final hazeSmogController = TextEditingController();
  final dustController = TextEditingController();
  final vehicleTrafficController = TextEditingController();
  final constructionActivityController = TextEditingController();
  final industrialFacilitiesController = TextEditingController();
  final openBurningController = TextEditingController();
  final otherController = TextEditingController();

  bool isSwitched = false;
  bool loading = false;

  final _imagePicker = ImagePicker();

  XFile? _pickedImage;
  var paddingvalue = 10.0;
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);
    setState(() {
      _pickedImage = pickedFile;
    });
  }

  String output = "";

  void submitdata() {
    final enteredPrimaryReasons = primaryReasonsController.text;
    final enteredNumPeopleObserved = numPeopleObservedController.text;
    final enteredObservations = observationsController.text;
    final enteredVisibility = visibilityController.text;
    final enteredHazeSmog = hazeSmogController.text;
    final enteredDust = dustController.text;
    final enteredVehicleTraffic = vehicleTrafficController.text;
    final enteredConstructionActivity = constructionActivityController.text;
    final enteredIndustrialFacilities = industrialFacilitiesController.text;
    final enteredOpenBurning = openBurningController.text;
    final enteredOther = otherController.text;
    final String combinepromptinJson = '''

   
   {
      "primaryReasons": "$enteredPrimaryReasons",
      "numPeopleObserved": "$enteredNumPeopleObserved",
      "observations": "$enteredObservations",
      "visibility": "$enteredVisibility",
      "hazeSmog": "$enteredHazeSmog",
      "dust": "$enteredDust",
      "vehicleTraffic": "$enteredVehicleTraffic",
      "constructionActivity": "$enteredConstructionActivity",
      "industrialFacilities": "$enteredIndustrialFacilities",
      "openBurning": "$enteredOpenBurning",
      "other": "$enteredOther"
   }
   ''';
    final gprompt =
        "Act as an bio diverserty researcher and a analyst, I am providing you with json like data and I want a complete detailed analysis and key insights and how to make it better place by growing plants give sugested plants for growing. JSON: $combinepromptinJson ";
    final gemini = Gemini.instance;

    final file = File(_pickedImage!.path);
    setState(() {
      loading = true;
    });
    gemini
        .textAndImage(
            text: gprompt,

            /// text
            images: [file.readAsBytesSync()]

            /// list of images
            )
        .then((value) => {
              setState(() {
                loading = false;
                output = value?.content?.parts?.join("_") ?? 'not avaiable';
              }),
              log(value?.content?.parts?.join("_") ?? '')
            })
        .catchError((e) => log('textAndImageInput', error: e));
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.all(paddingvalue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: isSwitched
                  ? [
                      Text(output),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () => _pickImage(ImageSource.camera),
                            child: Text(
                              'Open Camera',
                              style: TextStyle(
                                color: GoGreenColors.primaryContrast,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                GoGreenColors.primaryDark,
                              ),
                            )),
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () => _pickImage(ImageSource.gallery),
                            child: Text(
                              'Open Gallery',
                              style: TextStyle(
                                color: GoGreenColors.primaryContrast,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                GoGreenColors.primaryDark,
                              ),
                            )),
                      ),
                      SizedBox(height: 15),
                      _pickedImage != null
                          ? Image.file(File(_pickedImage!.path))
                          : Container(
                              height: 50,
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              margin: EdgeInsets.all(10),
                              child: Text('No image selected'),
                            ),
                      SizedBox(height: 15),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              submitdata();
                            });
                          },
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: GoGreenColors.primaryContrast,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              GoGreenColors.primaryDark,
                            ),
                          ),
                        ),
                      ),
                    ]
                  : [
                      SizedBox(height: 50.0),
                      TextField(
                          controller: primaryReasonsController,
                          decoration: InputDecoration(
                            labelText: 'Enter primary reasons of red zone',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.grey[850]!,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: GoGreenColors.primaryDark,
                                width: 2.0,
                              ),
                            ),
                          )),
                      SizedBox(height: 20),
                      TextField(
                        controller: numPeopleObservedController,
                        decoration: InputDecoration(
                          labelText: 'Number of people observed outdoors',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey[850]!,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: GoGreenColors.primaryDark,
                              width: 2.0,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: observationsController,
                        decoration: InputDecoration(
                          labelText: 'Observations',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey[850]!,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: GoGreenColors.primaryDark,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        items: ['Good', 'Moderate', 'Poor'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            visibilityController.text = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Visibility',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey[850]!,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: GoGreenColors.primaryDark,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        items: ['Present', 'Absent'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            hazeSmogController.text = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Haze/Smog',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey[850]!,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: GoGreenColors.primaryDark,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: dustController,
                        decoration: InputDecoration(
                          labelText: 'Odors',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey[850]!,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: GoGreenColors.primaryDark,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        items: ['Present', 'Absent'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            vehicleTrafficController.text = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Dust',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey[850]!,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: GoGreenColors.primaryDark,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        items:
                            ['Heavy', 'Moderate', 'Light'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            constructionActivityController.text = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Vehicle traffic',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey[850]!,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: GoGreenColors.primaryDark,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        items: ['Present', 'Absent'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            industrialFacilitiesController.text = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Construction activity',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey[850]!,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: GoGreenColors.primaryDark,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: openBurningController,
                        decoration: InputDecoration(
                          labelText: 'Industrial facilities',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey[850]!,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: GoGreenColors.primaryDark,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      DropdownButtonFormField<String>(
                        items: ['Present', 'Absent'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            openBurningController.text = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Open burning',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey[850]!,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: GoGreenColors.primaryDark,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Other',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey[850]!,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: GoGreenColors.primaryDark,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isSwitched = true;
                              paddingvalue = 25.0;
                            });
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              color: GoGreenColors.primaryContrast,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              GoGreenColors.primaryDark,
                            ),
                          ),
                        ),
                      )
                    ],
            ),
          );
  }
}
