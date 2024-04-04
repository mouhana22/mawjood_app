import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mawjood_app/Screens/Profile.dart';
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
      // Try to sign in the user with the provided credentials
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

       if (userCredential.user != null) {
        // Navigate to ProfilePage after successful login
      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
      }
    } on FirebaseAuthException catch (e) {
      // Handle errors from FirebaseAuth
      var errorMessage = "An error occurred, please try again";
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided.';
      }
// Catch any other exceptions that might occur
    print(e); // Log the error for debugging purposes
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An unexpected error occurred. Please try again.")),
    );
      // Using ScaffoldMessenger to show user feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3730A3),
        elevation: 0,
        toolbarHeight: 0,
        leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.black), // Adjust color as needed
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