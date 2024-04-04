import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/button.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // كنترولز للكتابخ
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  Future<void> registerUser() async {
    try {
      // Create a new user
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // If the user is successfully created, then store additional information in Firestore in the collection userd
      FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
        'jobTitle': jobController.text.trim(),
      });

      // Show a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Registration request sent, You will be able to check-in when the admin accepts your request'),
      ));

      // Navigate back to the login screen after showing the message
      Navigator.popUntil(context, ModalRoute.withName('/'));
      // or if there's have a named route for the login screen, use this ******8
      // Navigator.pushReplacementNamed(context, '/loginRouteName');
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to register user: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              hintText: 'Your name',
            ),
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              hintText: 'Your phone number',
            ),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Your email',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Your password',
            ),
            obscureText: true,
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: jobController,
            decoration: const InputDecoration(
              labelText: 'Job Title',
              hintText: 'Type role',
            ),
          ),
          SizedBox(height: 16.0),
          TextButton(
            child: Text('Scan'),
            onPressed: () {
              /***** * add Code for scanning later  *******/
            },
          ),
          SizedBox(height: 16.0),
          Button(
            text: 'Register',
            type: btnType.Primary,
            height: 50,
            width: double.infinity,
            onPressed: registerUser,
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Or register with check in'),
              GestureDetector(
                onTap: () {
                  // *****Add the action here later*****
                },
                child: Text(
                  ' Check in ',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const Icon(Icons.arrow_right, size: 24),
            ],
          ),
        ],
      ),
    );
  }
}
