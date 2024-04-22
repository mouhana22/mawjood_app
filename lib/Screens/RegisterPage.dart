import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/button.dart';
import 'package:mawjood_app/widgets/inputTextField.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  bool _agreeToTerms = false;

  Future<void> registerUser() async {
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You must agree to the terms and conditions before registering.'),
      ));
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      FirebaseFirestore.instance
          .collection('requests')
          .doc(userCredential.user!.uid)
          .set({
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
        'jobTitle': jobController.text.trim(),
        'admin': false, 
        'status': true,
        'id' : userCredential.user!.uid
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registration request sent. You will be able to check in when the admin accepts your request.'),
      ));

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to register user: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 55, 56, 132),
                  ),
                ),
                const SizedBox(height: 30),
                InputTextField(
                  label: "Name",
                  hintText: "Your name",
                  controller: nameController,
                  width: 320,
                  height: 40,
                ),
                const SizedBox(height: 20),
                InputTextField(
                  label: "Phone Number",
                  hintText: "Your phone number",
                  controller: phoneController,
                  width: 320,
                  height: 40,
                ),
                const SizedBox(height: 20),
                InputTextField(
                  label: "Email",
                  hintText: "Your email",
                  controller: emailController,
                  width: 320,
                  height: 40,
                ),
                const SizedBox(height: 20),
                InputTextField(
                  label: "Password",
                  hintText: "Your password",
                  controller: passwordController,
                  obscureText: true,
                  width: 320,
                  height: 40,
                ),
                const SizedBox(height: 20),
                InputTextField(
                  label: "Job Title",
                  hintText: "Your role",
                  controller: jobController,
                  width: 320,
                  height: 40,
                ),
                
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // add action (camera widget) actiono here later
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 8),
                      Text("Scan", style: TextStyle(color: Theme.of(context).primaryColor)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      onChanged: (bool? value) {
                        setState(() {
                          _agreeToTerms = value!;
                        });
                      },
                    ),
                    const Text("I agree to the terms and conditions"),
                  ],
                ),
                
                const SizedBox(height: 20),
                Button(
                  text: 'Register',
                  type: btnType.Primary,
                  height: 50,
                  width: double.infinity,
                  onPressed: registerUser,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Or register with check-in'),
                    GestureDetector(
                      onTap: () {
                        // ***add action for check in here later**
                      },
                      child: const Icon(Icons.arrow_right),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}