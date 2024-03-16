import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gogreenfrontend/util/govapi.dart';
import 'package:http/http.dart' as http;
import '../../util/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _showData = false;
  List<String> pollutant_id = [];
  List<String> pollutant_min = [];
  List<String> pollutant_max = [];
  List<String> pollutant_avg = [];
  List<String> station = [];
  TextEditingController _searchController = TextEditingController();

// Create a GlobalKey for the autocomplete field
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  void onsearch() {
    print('Search button clicked');
    apiResponse.records.forEach((element) {
      if (element.station == _searchController.text) {
        pollutant_id.add(element.pollutantId);
        pollutant_min.add(element.pollutantMin);
        pollutant_max.add(element.pollutantMax);
        pollutant_avg.add(element.pollutantAvg);
        print('City: ${element.city}');
        print('State: ${element.state}');
        print('Country: ${element.country}');
        setState(() {
          _showData = true; // Set the _showData state variable to true
        });
      }
    });
  }

  bool _isferching = true;
  late ApiResponse apiResponse;
  Future<ApiResponse> fetchApiResponse() async {
    final response = await http.get(Uri.parse(
        'https://api.data.gov.in/resource/3b01bcb8-0b14-4abf-b6f2-c1bfd384ba69?api-key=579b464db66ec23bdd000001008f801bb46b446d4d5288ec59676582&format=json&offset=10&limit=1000'));

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load API data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchApiResponse().then((value) => {
          setState(() {
            _isferching = false;
            apiResponse = value;

            for (var i = 0; i < apiResponse.records.length; i++) {
              if (!station.contains(apiResponse.records[i].station)) {
                station.add(apiResponse.records[i].station);
              }
            }
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        // Wrapping the entire column with SingleChildScrollView
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: AutoCompleteTextField<String>(
                      key: key,
                      suggestions: station,
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search.....',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              BorderSide(color: Colors.grey[850]!, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                              color: GoGreenColors.primaryDark, width: 2.0),
                        ),
                      ),
                      itemFilter: (item, query) {
                        return item
                            .toLowerCase()
                            .startsWith(query.toLowerCase());
                      },
                      itemSorter: (a, b) {
                        return a.compareTo(b);
                      },
                      itemSubmitted: (item) {
                        onsearch();
                      },
                      itemBuilder: (context, item) {
                        // You can customize your suggestion rows here.
                        return Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                item,
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                    width: 7), // Add space between search bar and button
                // Container(
                //   height: 50, // Set the height of the button
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(
                //         25.0), // Adjust the border radius as needed
                //     border: Border.all(
                //         color: GoGreenColors.primaryDark,
                //         width: 1.0), // Set button border color and width
                //   ),
                //   child: ElevatedButton(
                //     onPressed: () {
                //       onsearch();
                //     },
                //     style: ButtonStyle(
                //       backgroundColor: MaterialStateProperty.all<Color>(
                //         GoGreenColors.primaryContrast,
                //       ),
                //       shape: MaterialStateProperty.all<OutlinedBorder>(
                //         RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(
                //               25.0), // Adjust the border radius as needed
                //         ),
                //       ),
                //     ),
                //     child: _isferching
                //         ? const CircularProgressIndicator()
                //         : Icon(
                //             Icons.search,
                //             color: GoGreenColors.primaryDark,
                //             size: 25,
                //           ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 20),
            if (_showData) // Conditionally render the data based on the _showData state variable
              Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      border: TableBorder.all(color: GoGreenColors.primaryDark),
                      columns: const [
                        DataColumn(label: Text('Attribute')),
                        DataColumn(label: Text('Value')),
                      ],
                      rows: [
                        DataRow(cells: [
                          const DataCell(Text('Country')),
                          DataCell(Text(apiResponse.records[0].country)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('State')),
                          DataCell(Text(apiResponse.records[0].state)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('City')),
                          DataCell(Text(apiResponse.records[0].city)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Station')),
                          DataCell(Text(apiResponse.records[0].station)),
                        ]),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Pollution",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      border: TableBorder.all(color: GoGreenColors.primaryDark),
                      columns: const [
                        DataColumn(label: Text('pollutant')),
                        DataColumn(label: Text('Min')),
                        DataColumn(label: Text('Max')),
                        DataColumn(label: Text('Avg')),
                      ],
                      rows: [
                        for (int i = 0; i < pollutant_id.length; i++)
                          DataRow(cells: [
                            DataCell(Text(pollutant_id[i])),
                            DataCell(Text(pollutant_min[i])),
                            DataCell(Text(pollutant_max[i])),
                            DataCell(Text(pollutant_avg[i])),
                          ]),
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
