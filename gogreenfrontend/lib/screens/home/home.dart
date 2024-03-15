import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gogreenfrontend/maps/maps.dart';
import 'package:gogreenfrontend/screens/login/login.dart';
import '../../util/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0; // Initially selected index

  final List<BottomNavigationBarItem> _items = [
    // Define each bottom navigation bar item
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.add_shopping_cart),
    //   label: 'Add To Cart',
    // ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  final List<Widget> _screens = [
    // Define each screen corresponding to bottom navigation items
    HomeScreen(),
    SearchScreen(),
    //AddToCartScreen(),
    ProfileScreen(),
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
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                // Your profile button action
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
        onWillPop: () async => false, // Disable device back button
        child: _screens[_selectedIndex], // Show the selected screen
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
        // Optional: Center the text labels
        type: BottomNavigationBarType.fixed, // Needed for more than 3 items
        // Optional: Display centered badge to indicate selected screen
        showUnselectedLabels: true, // Show labels for all items
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: const MapComponent());
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Search Screen',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}

// class AddToCartScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Add To Cart Screen',
//         style: TextStyle(fontSize: 20.0),
//       ),
//     );
//   }
// }
class AddToCartScreen extends StatelessWidget {
  const AddToCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Add To Cart Screen', style: TextStyle(fontSize: 20.0)),
    );
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
