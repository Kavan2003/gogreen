import 'package:flutter/material.dart';
import '../../util/constants.dart';

class Login extends StatelessWidget {
  const Login({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GoGreen",
          style: TextStyle(
            fontSize: 25.0,
            color: GoGreenColors.primaryContrast, // Set text color
          ),
        ),
        backgroundColor: GoGreenColors.primaryDark,
        elevation: 4.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'User Gmail',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0), // Adjust the border radius as needed
                  borderSide: BorderSide(color: Colors.grey[850]!, width: 1.0), // Set default border color and width
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0), // Adjust the border radius as needed
                  borderSide: BorderSide(color:GoGreenColors.primaryDark, width:2.0), // Set focused border color and width
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0), // Adjust the border radius as needed
                  borderSide: BorderSide(color: Colors.grey[850]!, width: 1.0), // Set default border color and width
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0), // Adjust the border radius as needed
                  borderSide: BorderSide(color:GoGreenColors.primaryDark, width:2.0), // Set focused border color and width
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add login functionality here
              },
              child: Text('Login',

              ),
            ),
          ],
        ),
      ),
    );
  }
}
