// Mohammed ALGhamdi
// Mohalatq88@gmail.com

import 'package:flutter/material.dart';
import 'package:mawjood_app/widgets/imageWidget.dart';
import 'package:mawjood_app/widgets/statusBox.dart';

class CheckOut extends StatelessWidget {
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
                iconColor: Colors.black,
                title: 'Successfully Checked in',
                textColor: Color.fromRGBO(30, 27, 75, 1),
                date: 'Date: x/x/xxxx',
                time: 'Time: x:xx:xx',
                color: Color.fromRGBO(
                    203, 204, 242, 0.8), // Set the color of the box to blue
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
