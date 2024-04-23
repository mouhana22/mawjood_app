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

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _jobTitleController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
   String? _imageUrl;

  // Styling for the page
  final Color primaryColor = const Color(0xFF3730A3); 
  final TextStyle inputTextStyle = const TextStyle(fontSize: 15, color: Colors.black54);
  final TextStyle labelTextStyle = TextStyle(fontSize: 14, color: Colors.grey[800]);
  final InputDecoration inputDecoration = const InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.all(10),
    isDense: true,
  );

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var doc = await FirebaseFirestore.instance.collection('requests').doc(userId).get();
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
        title: const Text("Edit Profile"),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white, 
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
                    const SizedBox(height: 16),
                    _buildTextField(_emailController, "Email", "Please enter your email"),
                    const SizedBox(height: 16),
                    _buildTextField(_phoneController, "Phone", "Please enter your phone number"),
                    const SizedBox(height: 16),
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
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        border: OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
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
      await FirebaseFirestore.instance.collection('requests').doc(userId).update({
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