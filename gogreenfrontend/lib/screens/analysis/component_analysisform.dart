import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

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
        "Analysis form data is given is json format: $combinepromptinJson .Give me the entire analysis of this data suggest me plants to grow to improve my data also check image of that area if you require it ";
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: isSwitched
                  ? [
                      Text(output),
                      TextButton(
                        onPressed: () => _pickImage(ImageSource.camera),
                        child: Text('Open Camera'),
                      ),
                      TextButton(
                        onPressed: () => _pickImage(ImageSource.gallery),
                        child: Text('Open Gallery'),
                      ),
                      _pickedImage != null
                          ? Image.file(File(_pickedImage!.path))
                          : Container(
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
                      TextButton(
                        onPressed: () {
                          setState(() {
                            submitdata();
                          });
                        },
                        child: Text('Next'),
                      ),
                    ]
                  : [
                      TextField(
                          controller: primaryReasonsController,
                          decoration: InputDecoration(
                            labelText: 'Enter primary reasons of red zone',
                          )),
                      TextField(
                        controller: numPeopleObservedController,
                        decoration: InputDecoration(
                          labelText: 'Number of people observed outdoors',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      TextField(
                        controller: observationsController,
                        decoration: InputDecoration(
                          labelText: 'Observations',
                        ),
                      ),
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
                        ),
                      ),
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
                        ),
                      ),
                      TextField(
                        controller: dustController,
                        decoration: InputDecoration(
                          labelText: 'Odors',
                        ),
                      ),
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
                        ),
                      ),
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
                        ),
                      ),
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
                        ),
                      ),
                      TextField(
                        controller: openBurningController,
                        decoration: InputDecoration(
                          labelText: 'Industrial facilities',
                        ),
                      ),
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
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Other',
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isSwitched = true;
                            paddingvalue = 20.0;
                          });
                        },
                        child: Text('Next'),
                      ),
                    ],
            ),
          );
  }
}
