import 'package:flutter/material.dart';
import 'package:mawjood/btnTypes.dart';
import 'package:mawjood/imageWidget.dart';
import 'package:mawjood/iconButton.dart'; 
class CheckIn extends StatelessWidget {
  @override
  //----------------------------------------
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),

              imageWidget(
                avatarURL:
                    'https://i.ibb.co/94RhRtG/logo.png', // Provide the URL of the image
                width: 70,
                height: 70,
              ),
              SizedBox(height: 40.0),
              Container(
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.lightGreen[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 40.0,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Successfully Checked in',
                      style: TextStyle(
                        color: Colors.green[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text('Date: x/x/xxxx'),
                    Text('Time: x:xx:xx'),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: iconButton(
                  text: "Check-Out",
                  icon: Icons.logout,
                  type: btnType.Red,
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
