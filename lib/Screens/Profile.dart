import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mawjood_app/Screens/editProfile.dart';
import 'package:mawjood_app/Screens/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userInfo;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
        if (userDoc.exists) {
          setState(() {
            userInfo = userDoc.data() as Map<String, dynamic>?;
          });
        } else {
          print("Document does not exist");
        }
      } catch (e) {
        print("Error getting user info: $e");
      }
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    Color appBarColor = const Color(0xFF3730A3);
    TextStyle titleStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
    TextStyle infoStyle = TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.9));

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: titleStyle),
        backgroundColor: appBarColor,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfile()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: appBarColor,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(userInfo?['image_URL'] ?? 'https://via.placeholder.com/150'),
                    backgroundColor: Colors.white70,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userInfo?['name'] ?? 'No name available',
                    style: titleStyle.copyWith(fontSize: 18),
                  ),
                  Text(
                    userInfo?['email'] ?? 'No email available',
                    style: infoStyle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User Details",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Divider(color: Color.fromARGB(255, 66, 66, 66)),
                  ListTile(
                    title: const Text("Phone"),
                    subtitle: Text(userInfo?['phone'] ?? 'Phone not available'),
                    leading: const Icon(Icons.phone, color: Color(0xFF3730A3)),
                  ),
                  ListTile(
                    title: const Text("Job Title"),
                    subtitle: Text(userInfo?['jobTitle'] ?? 'Job title not available'),
                    leading: const Icon(Icons.work, color: Color(0xFF3730A3)),
                  ),
                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


    }

