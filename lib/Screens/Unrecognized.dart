// Mohammed ALGhamdi
// Mohalatq88@gmail.com

import 'package:flutter/material.dart';
import 'package:mawjood_app/Screens/RegisterPage.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/imageWidget.dart';
import 'package:mawjood_app/widgets/statusBox.dart';
import 'package:mawjood_app/widgets/Button.dart'; // Import Button widget

class Unrecognized extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 242, 255, 1),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImageWidget(
                avatarURL:
                    'https://i.ibb.co/94RhRtG/logo.png', //  the URL of the image
                width: 50,
                height: 50,
              ),
              SizedBox(height: 200.0),
              StatusBox(
                icon: Icons.highlight_remove_outlined,
                iconColor: Color.fromRGBO(242, 81, 101, 1),
                title: 'Unrecognized',
                textColor: Color.fromRGBO(242, 81, 101, 1),
                color: Color.fromRGBO(239, 182, 198, 1),
                showDateTime: false, // Do not show DateTimeWidget
              ),
              Spacer(),
              Row(
                // Wrap the Button and Text inside a Row
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Do not have an account?",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1), // Set text color
                      fontSize: 13, // Set font size
                    ),
                  ),
                  SizedBox(
                      width: 8), // Add some space between the text and button
                  Button(
                    onPressed: () {
                      // Navigate to the RegisterPage screen when pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    text: "Register", // Text for the button
                    type: btnType.Primary, // Set button type
                    width: 100.5, // Set button width
                    height: 34, // Set button height
                    fontSize: 12, // Set font size
                  ),
                ],
              ),
              SizedBox(
                height: 20, // Add some space between the button and bottom
              ),
            ],
          ),
        ),
      ),
    );
  }
}
