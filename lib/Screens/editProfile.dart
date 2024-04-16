import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = true;
  String? _name, _email, phone, _jobTitle;

  // Defining the text editing controllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _jobTitleController;
 late TextEditingController _phoneController;
  // Defining colors and styles for the page
  final Color primaryColor = const Color(0xFF3730A3);
  final TextStyle inputTextStyle = const TextStyle(fontSize: 18, color: Colors.black87);
  final TextStyle labelTextStyle = TextStyle(fontSize: 16, color: Colors.grey[600]);

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (doc.exists) {
      Map<String, dynamic>? data = doc.data();
      _initTextControllers(data);
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      
    }
  }

  void _initTextControllers(Map<String, dynamic>? data) {
    _nameController = TextEditingController(text: data?['name']);
    _emailController = TextEditingController(text: data?['email']);
    _jobTitleController = TextEditingController(text: data?['jobTitle']);
    _phoneController = TextEditingController(text: data?['phone']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _jobTitleController.dispose();
     _phoneController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
         elevation: 0,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: _isLoading ? null : _saveProfile,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _buildTextField(_nameController, "Name", "Please enter your name"),
                    _buildTextField(_emailController, "Email", "Please enter your email"),
                    _buildTextField(_phoneController, "Phone", "Please enter your phone number"),
                    _buildTextField(_jobTitleController, "Job Title", "Please enter your job title"),
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
        labelStyle: labelTextStyle,
        enabledBorder: UnderlineInputBorder(      
          borderSide: BorderSide(color: primaryColor),   
        ),  
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
      style: inputTextStyle,
      validator: (value) => value!.isEmpty ? validationMessage : null,
    );
  }

  void _saveProfile() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      var userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'name': _nameController.text,
        'email': _emailController.text,
        'jobTitle': _jobTitleController.text,
         'phone': _phoneController.text, 
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully!', style: TextStyle(color: Colors.white))));
      Navigator.pop(context);
    }
  }
}