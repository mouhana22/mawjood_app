import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mawjood_app/Screens/Profile.dart';
import 'package:mawjood_app/Screens/adminScreens/adminScreen.dart';  // Assuming this file exists
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/button.dart';
import 'package:mawjood_app/widgets/inputTextField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Controllers to take the input from user
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginUser() async {
  try {
    // Sign in the user with the provided credentials
    final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (userCredential.user != null) {
      // Fetch user details from Firestore
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists || userDoc.data() == null) {
        throw Exception("User document does not exist or has no data.");
      }

      final userData = userDoc.data() as Map<String, dynamic>;

      // Check if the 'status' field is true
      if (userData['status'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Your account is inactive. contact the admin for enquiries about account registrations.")),
        );
        return;
      }

      // Assuming usertype is stored and works as expected
      final bool usertype = userData['admin'] ?? false;

      // Navigate based on user type
        if (!usertype) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ProfilePage()));
        } else {
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminScreen()));
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AdminScreen()),
            (route) => false, // Remove all routes from the stack
          );
        }
    }
  } on FirebaseAuthException catch (e) {
    var errorMessage = "An error occurred, please try again.";
    if (e.code == 'user-not-found') {
      errorMessage = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Wrong password provided.';
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
  } catch (e) {
    print(e); // Log the error for debugging purposes
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("An unexpected error occurred: ${e.toString()}")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, 
        elevation: 1, // Show some shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Ensure icon is visible
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 55, 56, 132),
                  ),
                ),
                const SizedBox(height: 60),
                InputTextField(
                  label: "Email",
                  hintText: "Your email",
                  readOnly: false,
                  controller: _emailController, 
                  width: 320,
                  height: 40,
                ),
                const SizedBox(height: 20),
                InputTextField(
                  label: "Password",
                  hintText: "Your password",
                  readOnly: false,
                  controller: _passwordController, 
                  obscureText: true, 
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
                  onPressed: _loginUser, 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}