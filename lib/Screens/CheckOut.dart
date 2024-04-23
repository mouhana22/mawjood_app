// Mohammed ALGhamdi
// Mohalatq88@gmail.com

import 'package:flutter/material.dart';
import 'package:mawjood_app/widgets/imageWidget.dart';
import 'package:mawjood_app/widgets/statusBox.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
                icon: Icons.logout,
                iconColor: Colors.black,
                title: 'Successfully Checked Out',
                textColor: Color.fromRGBO(30, 27, 75, 1),
                color: Color.fromRGBO(203, 204, 242, 0.8),
                showDateTime: true, // Pass false to hide DateTimeWidget
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
