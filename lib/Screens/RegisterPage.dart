import 'package:flutter/material.dart';
import 'package:mawjood_app/cardsWidgets/btnTypes.dart';
import 'package:mawjood_app/cardsWidgets/button.dart';
import 'package:mawjood_app/cardsWidgets/iconButton.dart';
import 'package:mawjood_app/cardsWidgets/infoField.dart';



class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            infoField(data: 'Name'),
            SizedBox(height: 10),
            infoField(data: 'Phone Number'),
            SizedBox(height: 10),
            infoField(data: 'Email'),
            SizedBox(height: 10),
            infoField(data: 'Password'),
            SizedBox(height: 10),
            infoField(data: 'Job title'),
            SizedBox(height: 20),
            const iconButton(
              text: 'Scan',
              icon: Icons.camera_alt,
              type: btnType.Secondary
            ),
            SizedBox(height: 16),
            const button(
              text: 'Register',
              type: btnType.Primary
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () { /* Logic for "Or register with check in" */ },
              child: Text('Or register with check in'),
            ),
          ],
        ),
      ),
    );
  }
}