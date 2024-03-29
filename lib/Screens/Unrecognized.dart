// Mohammed ALGhamdi
// Mohalatq88@gmail.com

import 'package:flutter/material.dart';
import 'package:mawjood_app/Screens/RegisterPage.dart';
import 'package:mawjood_app/widgets/imageWidget.dart';
import 'package:mawjood_app/widgets/statusBox.dart';

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
                date: null,
                time: null,
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the CheckOut screen when pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromRGBO(30, 27, 75, 1), // Set background color
                  minimumSize: Size(137.5, 34), // Set button size
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Set border radius
                  ),
                ),
                child: Text(
                  "Register", // Text for the button
                  style: TextStyle(
                    color: Color.fromRGBO(238, 242, 255, 1), // Set text color
                    fontSize: 10,
                  ),
                ),
              ),
              SizedBox(
                  height: 20), // Add some space between the button and bottom
            ],
          ),
        ),
      ),
    );
  }
}
