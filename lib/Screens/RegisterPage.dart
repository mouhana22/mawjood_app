import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

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
    // Create a new user with FirebaseAuth
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    String? customUserId; // Make it nullable

    await firestore.runTransaction((Transaction transaction) async {
      DocumentReference counterRef = firestore.collection('counters').doc('userIDs');
      DocumentSnapshot snapshot = await transaction.get(counterRef);

      if (!snapshot.exists) {
        throw Exception("Counter document does not exist!");
      }

      int lastUserId = snapshot['lastUserId'] ?? 999; // Start from 999 so that the first user gets 1000
      customUserId = '${lastUserId + 1}';

      // Update the counter
      transaction.update(counterRef, {'lastUserId': lastUserId + 1});
    });

    // Ensure customUserId was actually assigned a value
    if (customUserId != null) {
  await firestore.collection('users').doc(userCredential.user!.uid).set({
    'customId': customUserId,
    'name': nameController.text.trim(),
    'phone': nameController.text.trim(),
    'email': emailController.text.trim(),
    'jobTitle': jobController.text.trim(),
    'photoUrl': _imageUrl ?? "default_photo_url", // Save the image URL; use a default or leave blank if no photo was selected
  });
      // Show a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Registration successful. Your ID is $customUserId'),
      ));

      // Navigate back to the login screen after showing the message
      Navigator.popUntil(context, ModalRoute.withName('/'));
    } else {
      throw Exception("Failed to generate custom user ID.");
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to register user: $e")));
  }
}
File? _image; // Variable to hold the selected image file
String? _imageUrl; // Variable to hold the uploaded image URL

// Method to pick an image
Future<void> pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    setState(() {
      _image = File(pickedFile.path);
    }); 
    uploadImage();
  }
}

// Method to upload the image to Firebase Storage
Future<void> uploadImage() async {
  try {
    if (_image != null) {
      String fileName = 'user_photos/${DateTime.now().millisecondsSinceEpoch.toString()}';
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      firebase_storage.UploadTask task = ref.putFile(_image!);
      firebase_storage.TaskSnapshot snapshot = await task;
      _imageUrl = await snapshot.ref.getDownloadURL();
    }
  } catch (e) {
    print(e); // Handle errors as needed
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Your name',
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              hintText: 'Your phone number',
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Your email',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Your password',
            ),
            obscureText: true,
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: jobController,
            decoration: const InputDecoration(
              labelText: 'Job Title',
              hintText: 'Type role',
            ),
          ),
          const SizedBox(height: 16.0),
          TextButton(
            child: const Text('Scan'),
            onPressed: () {
            pickImage(); // Calls the pickImage method // Call the pickImage method when the button is pressed
            },
          ),
          const SizedBox(height: 16.0),
          Button(
            text: 'Register',
            type: btnType.Primary,
            height: 50,
            width: double.infinity,
            onPressed: registerUser,
          ),
          const SizedBox(height: 16.0),
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
