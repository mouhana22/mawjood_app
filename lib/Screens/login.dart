//import all widgets/packages
import 'package:flutter/material.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/button.dart';
import 'package:mawjood_app/widgets/inputTextField.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(98, 14, 15, 84),
                ),
              ),
              const SizedBox(height: 60),
           
              InputTextField(
                label: "Email", 
                hintText: "Your email", 
                readOnly: false,
                width: 320,
                height: 40,
              ),
              const SizedBox(height: 20),
              InputTextField(
                label: "Password", 
                hintText: "Your password", 
                readOnly: false,
                width: 320,
                height: 40,
              ),
              const SizedBox(height: 30),
              Button(
                text: "Login",
                type: btnType.Primary,
                width: MediaQuery.of(context).size.width, 
                height: 50,
                fontSize: 16,
                onPressed: () {
                  // *****Handle the login logic later*****
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}