import 'package:flutter/material.dart';
import 'package:mawjood_app/Screens/CheckIn.dart';
import 'package:mawjood_app/screens/Unrecognized.dart';
import 'package:mawjood_app/screens/RegisterPage.dart'; // Import RegisterPage
import 'package:mawjood_app/Screens/login.dart';
import 'package:mawjood_app/widgets/CameraPreviewWidget.dart';
import 'package:mawjood_app/widgets/imageWidget.dart'; // Import LoginPage
import 'package:mawjood_app/widgets/iconButton.dart'; // Import CustomIconButton widget
import 'package:mawjood_app/widgets/btnTypes.dart'; // Import btnType enum

class HomePage extends StatelessWidget {
  final bool hasAccount; // Flag to check if the user has an account

  const HomePage({Key? key, required this.hasAccount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(148, 92, 94, 233),
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -160,
            child: Container(
              width: 470,
              height: 470,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(96, 27, 25, 68),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 30),
              ImageWidget(
                avatarURL:
                    'https://i.ibb.co/0sM3NKG/logo-2-removebg-preview.png',
                width: 70,
                height: 70,
              ),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                      icon: Icons.login,
                      text: 'Register',
                      type: btnType.Secondary,
                    ),
                    CustomIconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      icon: Icons.settings,
                      text: 'Manage Account',
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
                          child: CustomIconButton(
                            onPressed: () {
                              if (hasAccount) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckIn()),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Unrecognized()),
                                );
                              }
                            },
                            text: 'Check-in',
                            icon: Icons.check,
                            type: btnType.Primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 230,
            left: 0,
            right: 0,
            bottom: 0,
            child: CameraPreviewWidget(), // Add the CameraPreviewWidget here
          ),
        ],
      ),
    );
  }
}
