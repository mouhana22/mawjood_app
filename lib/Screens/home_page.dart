import 'package:flutter/material.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/button.dart'; // Import your button widget
import 'package:mawjood_app/widgets/iconButton.dart';
import 'package:mawjood_app/widgets/imageWidget.dart'; // Import your avatar widget

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Assuming you have a variable to track whether the user has an account or not
  bool hasAccount = true; // Change this to true if the user has an account

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(99, 67, 69, 167),
      body: Column(
        children: [
          SizedBox(height: 30), // Adjust the spacing as needed
          // Use your avatar widget here
          imageWidget(
            avatarURL:
                'https://i.ibb.co/VDNmZ8G/logo-2.png', // Provide the URL of the image
            width: 70,
            height: 70,
          ),
          SizedBox(height: 50), // Adjust the spacing as needed
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconButton(
                  text: "Register",
                  icon: Icons.login,
                  type: btnType.Secondary,
                ),
                iconButton(
                  text: "Manage Account",
                  icon: Icons.settings,
                  type: btnType.Secondary,
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
                      child: button(
                        text: "Check-In",
                        type: btnType.Primary,
                        onPressed: () {
                          // Check if the user has an account
                          if (hasAccount) {
                            // Navigate to CheckInScreen
                            Navigator.pushNamed(context, '/CheckIn');
                          } else {
                            // Navigate to UnrecognizedScreen
                            Navigator.pushNamed(context, '/unrecognized');
                          }
                        },
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
