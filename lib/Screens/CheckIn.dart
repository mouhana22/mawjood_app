// Mohammed ALGhamdi
// Mohalatq88@gmail.com

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
              ImageWidget(
                avatarURL: 'https://i.ibb.co/94RhRtG/logo.png',
                width: 50,
                height: 50,
              ),
              SizedBox(height: 200.0),
              StatusBox(
                icon: Icons.check_circle_outline,
                iconColor: Color.fromRGBO(140, 170, 52, 1),
                title: 'Successfully Checked in',
                textColor: Color.fromRGBO(140, 170, 52, 1),
                color: Color.fromRGBO(222, 231, 194, 1),
                showDateTime: true, // Pass true to show DateTimeWidget
              ),
              SizedBox(height: 16),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomIconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckOut()),
                    );
                  },
                  icon: Icons.logout,
                  text: 'Check-Out',
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
