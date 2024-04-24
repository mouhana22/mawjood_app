// Mohammed ALGhamdi
// Mohalatq88@gmail.com

import 'package:flutter/material.dart';
import 'package:mawjood_app/Screens/RegisterPage.dart';
import 'package:mawjood_app/widgets/imageWidget.dart';
import 'package:mawjood_app/widgets/statusBox.dart';
// Import Button widget

class Unrecognized extends StatelessWidget {
  const Unrecognized({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 242, 255, 1),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const ImageWidget(
                avatarURL:
                    'https://i.ibb.co/94RhRtG/logo.png', //  the URL of the image
                width: 50,
                height: 50,
              ),
              const SizedBox(height: 200.0),
              const StatusBox(
                icon: Icons.highlight_remove_outlined,
                iconColor: Color.fromRGBO(242, 81, 101, 1),
                title: 'Unrecognized',
                textColor: Color.fromRGBO(242, 81, 101, 1),
                color: Color.fromRGBO(239, 182, 198, 1),
                showDateTime: false, // Do not show DateTimeWidget
              ),
              const Spacer(),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Do not have an account ? '),
                  GestureDetector(
                    onTap: () {
                      // Navigate the user to the register page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  RegisterPage()),
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_right, size: 24),
                ],
              ),
              const SizedBox(
                height: 20, // Add some space between the button and bottom
              ),
            ],
          ),
        ),
      ),
    );
  }
}
