import 'package:flutter/material.dart';

import '../../util/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _showData = false; // Initially, set to false
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView( // Wrapping the entire column with SingleChildScrollView
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50, // Set the height of the search bar
                      child: Center(
                        child: TextField(
                          controller: _searchController,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                            hintText: 'Search.....',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  25.0), // Adjust the border radius as needed
                              borderSide: BorderSide(
                                  color: Colors.grey[850]!,
                                  width:
                                  1.0), // Set default border color and width
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  25.0), // Adjust the border radius as needed
                              borderSide: BorderSide(
                                  color: GoGreenColors.primaryDark,
                                  width:
                                  2.0), // Set focused border color and width
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 7), // Add space between search bar and button
                  Container(
                    height: 50, // Set the height of the button
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          25.0), // Adjust the border radius as needed
                      border: Border.all(
                          color: GoGreenColors.primaryDark,
                          width: 1.0), // Set button border color and width
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Toggle the _showData state variable when the button is pressed
                        if (_searchController.text == 'Ahmedabad') {
                          setState(() {
                            _showData = true;
                          });
                        } else {
                          setState(() {
                            _showData = false;
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          GoGreenColors.primaryContrast,
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                25.0), // Adjust the border radius as needed
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.search,
                        color: GoGreenColors.primaryDark,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (_showData) // Conditionally render the data based on the _showData state variable
                Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        border: TableBorder.all(color: GoGreenColors.primaryDark),
                        columns: [
                          DataColumn(label: Text('Attribute')),
                          DataColumn(label: Text('Value')),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text('Country')),
                            DataCell(Text('India')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('State')),
                            DataCell(Text('Gujarat')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('City')),
                            DataCell(Text('Ahmedabad')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Station')),
                            DataCell(Text('Gyaspur, Ahmedabad - IITM')),
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Pollution",
                      style:TextStyle(
                        fontSize:18,
                        fontWeight:FontWeight.w400,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        border: TableBorder.all(color: GoGreenColors.primaryDark),
                        columns: [
                          DataColumn(label: Text('pollutant')),
                          DataColumn(label: Text('Min')),
                          DataColumn(label: Text('Max')),
                          DataColumn(label: Text('Avg')),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text('Ozone')),
                            DataCell(Text('01')),
                            DataCell(Text('52')),
                            DataCell(Text('85')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('CO')),
                            DataCell(Text('0')),
                            DataCell(Text('0')),
                            DataCell(Text('0')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('NH3')),
                            DataCell(Text('0')),
                            DataCell(Text('0')),
                            DataCell(Text('0')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('NO2')),
                            DataCell(Text('0')),
                            DataCell(Text('0')),
                            DataCell(Text('0')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('PM10')),
                            DataCell(Text('0')),
                            DataCell(Text('0')),
                            DataCell(Text('0')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('PM2.5')),
                            DataCell(Text('0')),
                            DataCell(Text('0')),
                            DataCell(Text('0')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('SO2')),
                            DataCell(Text('0')),
                            DataCell(Text('0')),
                            DataCell(Text('0')),
                          ]),
                          // Add more rows here as needed
                        ],
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
