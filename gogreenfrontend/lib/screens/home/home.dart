import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gogreenfrontend/maps/maps.dart';
import 'package:gogreenfrontend/screens/analysis/analysis.dart';
import 'package:gogreenfrontend/screens/login/login.dart';
import 'package:gogreenfrontend/util/govapi.dart';
import '../../util/constants.dart';
import '../profile/profile.dart';
import '../search/search.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0; // Initially selected index

  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.analytics_sharp), label: 'Analysis'),
    const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];

  final List<Widget> _screens = [
    const HomeScreen(),
    AnalysisScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove default back button
        title: const Text(
          "GoGreen",
          style: TextStyle(
            fontSize: 25.0,
            color: GoGreenColors.primaryContrast, // Set text color
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: const Icon(Icons.logout, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
          ),
        ],
        backgroundColor: GoGreenColors.primaryDark,
        elevation: 4.0,
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        currentIndex: _selectedIndex,
        selectedItemColor: GoGreenColors.primaryContrast,
        backgroundColor: GoGreenColors.primaryDark,
        unselectedItemColor: GoGreenColors.accentLight,
        selectedIconTheme: const IconThemeData(
          size: 33,
        ),
        selectedFontSize: 15,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Needed for more than 3 items
        showUnselectedLabels: true, // Show labels for all items
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isferching = true;
  late ApiResponse apiResponse;
  Future<ApiResponse> fetchApiResponse() async {
    final response = await http.get(Uri.parse(
        'https://api.data.gov.in/resource/3b01bcb8-0b14-4abf-b6f2-c1bfd384ba69?api-key=579b464db66ec23bdd000001008f801bb46b446d4d5288ec59676582&format=json&offset=10&limit=1000'));

    if (response.statusCode == 200) {
      // log(response.body);
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load API data');
    }
  }

  List<ApiQualityarea> qualityarea = [];

  List<ApiQualityarea> convertApiResponseToApiQualityarea(
      ApiResponse apiResponse) {
    List<ApiQualityarea> qualityarea = [];

    for (var record in apiResponse.records) {
      var existingQualityArea = qualityarea.firstWhere(
          (qa) => qa.station == record.station,
          orElse: () => ApiQualityarea(
              country: record.country,
              state: record.state,
              city: record.city,
              station: record.station,
              lastUpdate: record.lastUpdate,
              latitude: record.latitude,
              longitude: record.longitude,
              pollutant_co: null,
              pollutant_nh3: null,
              pollutant_ozone: null,
              pollutant_pm10: null,
              pollutant_pm2_5: null,
              pollutant_so2: null,
              pollutant_no2: null));

      switch (record.pollutantId) {
        case 'CO':
          existingQualityArea = existingQualityArea.updatePollutants(
              pollutant_co: record.pollutantAvg);
          break;
        case 'NH3':
          existingQualityArea = existingQualityArea.updatePollutants(
              pollutant_nh3: record.pollutantAvg);
          break;
        case 'OZONE':
          existingQualityArea = existingQualityArea.updatePollutants(
              pollutant_ozone: record.pollutantAvg);
          break;
        case 'PM10':
          existingQualityArea = existingQualityArea.updatePollutants(
              pollutant_pm10: record.pollutantAvg);
          break;
        case 'PM2.5':
          existingQualityArea = existingQualityArea.updatePollutants(
              pollutant_pm2_5: record.pollutantAvg);
          break;
        case 'SO2':
          existingQualityArea = existingQualityArea.updatePollutants(
              pollutant_so2: record.pollutantAvg);
          break;
        case 'NO2':
          existingQualityArea = existingQualityArea.updatePollutants(
              pollutant_no2: record.pollutantAvg);
          break;
      }

      if (!qualityarea.contains(existingQualityArea)) {
        qualityarea.add(existingQualityArea);
      }
    }

    return qualityarea;
  }

  @override
  void initState() {
    super.initState();

    fetchApiResponse().then((value) => {
          setState(() {
            _isferching = false;
            apiResponse = value;
            qualityarea = convertApiResponseToApiQualityarea(apiResponse);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _isferching
            ? const Center(child: CircularProgressIndicator())
            : MapComponent(qualityarea));
  }
}
