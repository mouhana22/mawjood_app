import 'package:flutter/material.dart';
import 'package:mawjood_app/Screens/CheckOut.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/iconButton.dart';
import 'package:mawjood_app/widgets/imageWidget.dart';
import 'package:mawjood_app/widgets/statusBox.dart';

class CheckIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 242, 255, 1),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              imageWidget(
                avatarURL:
                    'https://i.ibb.co/94RhRtG/logo.png', //  the URL of the image
                width: 50,
                height: 50,
              ),
              SizedBox(height: 200.0),
              StatusBox(
                icon: Icons.check_circle_outline,
                iconColor: Color.fromRGBO(140, 170, 52, 1),
                title: 'Successfully Checked in',
                textColor: Color.fromRGBO(140, 170, 52, 1),
                date: 'Date: x/x/xxxx',
                time: 'Time: x:xx:xx',
                color: Color.fromRGBO(222, 231, 194, 1),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the CheckOut screen when pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckOut()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    // Button background color
                    foregroundColor:
                        const Color.fromARGB(255, 201, 55, 44), // Text color
                    minimumSize: Size(137.5, 34), // Button size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout), // Icon
                      SizedBox(width: 8), // Space between icon and text
                      Text(
                        "Check-Out", // Button text
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
