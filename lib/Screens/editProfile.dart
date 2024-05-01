import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = true;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _jobTitleController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String? _imageUrl;
  bool? _admin; // Admin flag
  bool? _status; // User status

  final Color primaryColor = const Color(0xFF3730A3);

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    setState(() { _isLoading = true; });
    try {
      var userId = FirebaseAuth.instance.currentUser!.uid;
      var doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (doc.exists) {
        _initTextControllers(doc.data());
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  void _initTextControllers(Map<String, dynamic>? data) {
    _nameController.text = data?['name'] ?? '';
    _emailController.text = data?['email'] ?? '';
    _jobTitleController.text = data?['jobTitle'] ?? '';
    _phoneController.text = data?['phone'] ?? '';
    _imageUrl = data?['image_URL'];
    _admin = data?['admin']; // Initialize the admin field
    _status = data?['status']; // Initialize the status field
  }

  Future<void> _updateProfilePhoto() async {
    final _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      File imageFile = File(photo.path);
      var userId = FirebaseAuth.instance.currentUser!.uid;
      var storageRef = FirebaseStorage.instance.ref().child('user_images/$userId');
      var uploadTask = storageRef.putFile(imageFile);
      var storageSnapshot = await uploadTask.whenComplete(() {});
      _imageUrl = await storageSnapshot.ref.getDownloadURL();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isLoading ? null : _saveProfile,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _buildTextField(_nameController, "Name", "Please enter your name"),
                    _buildTextField(_emailController, "Email", "Please enter your email"),
                    _buildTextField(_phoneController, "Phone", "Please enter your phone number"),
                    _buildTextField(_jobTitleController, "Job Title", "Please enter your job title"),
                    if (_imageUrl != null)
                      Image.network(_imageUrl!, height: 100, width: 100),
                    ElevatedButton(
                      onPressed: _updateProfilePhoto,
                      child: const Text('Update Profile Photo'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String validationMessage) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
      validator: (value) => value!.isEmpty ? validationMessage : null,
    );
  }

void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        var userId = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance.collection('requests').doc(userId).set(
            {
              'id': userId, // Add the userId as "id"
              'name': _nameController.text,
              'email': _emailController.text,
              'jobTitle': _jobTitleController.text,
              'phone': _phoneController.text,
              'image_URL': _imageUrl ?? '',
              'admin': _admin,
              'status': _status,
            }); 
        Navigator.pop(context);
      } catch (e) {
        print("Failed to save data: $e");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}