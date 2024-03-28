import 'package:flutter/material.dart';
import 'package:mawjood_app/Screens/CheckIn.dart';
import 'package:mawjood_app/screens/Unrecognized.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/screens/RegisterPage.dart'; // Import RegisterPage
import 'package:mawjood_app/screens/Login.dart';
import 'package:mawjood_app/widgets/imageWidget.dart'; // Import LoginPage

class HomePage extends StatelessWidget {
  final bool hasAccount; // Flag to check if the user has an account

  const HomePage({Key? key, required this.hasAccount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(99, 67, 69, 167),
      body: Column(
        children: [
          SizedBox(height: 30),
          imageWidget(
            avatarURL: 'https://i.ibb.co/VDNmZ8G/logo-2.png',
            width: 70,
            height: 70,
          ),
          SizedBox(height: 50), // Adjust the spacing as needed
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to RegisterPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  icon: Icon(Icons.login),
                  label: Text(
                    'Register',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to LoginPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  icon: Icon(Icons.settings),
                  label: Text(
                    'Manage Account',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 120), // Adjust the spacing as needed
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Check if the user has an account
                          if (hasAccount) {
                            // Navigate to CheckInScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckIn()),
                            );
                          } else {
                            // Navigate to UnrecognizedScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Unrecognized()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color.fromRGBO(55, 48, 163, 1), // button color
                          foregroundColor: Colors.white, //  text color
                        ),
                        child: Text("Check-in"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
