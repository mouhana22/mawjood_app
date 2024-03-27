import 'package:flutter/material.dart';
import 'package:mawjood/btnTypes.dart';
import 'package:mawjood/button.dart';
import 'package:mawjood/iconButton.dart';
import 'package:mawjood/imageWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hasAccount = true; // Change this to true if the user has an account

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
          SizedBox(height: 50),
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
          SizedBox(height: 120),
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
                          if (hasAccount) {
                            Navigator.pushNamed(context, '/check-in');
                          } else {
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
