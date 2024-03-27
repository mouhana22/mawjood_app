import 'package:flutter/material.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/iconButton.dart';
import 'package:mawjood_app/widgets/imageWidget.dart';
import 'package:mawjood_app/widgets/statusBox.dart';

class CheckIn extends StatelessWidget {
  @override
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
                    'https://i.ibb.co/94RhRtG/logo.png', //  the URL of the image
                width: 70,
                height: 70,
              ),
              SizedBox(height: 40.0),
              statusBox(
                icon: Icons.check_circle_outline,
                iconColor: const Color.fromARGB(255, 35, 107, 37),
                title: 'Successfully Checked in',
                textColor: Colors.green,
                date: 'Date: x/x/xxxx',
                time: 'Time: x:xx:xx',
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
