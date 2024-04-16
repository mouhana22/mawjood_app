import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mawjood_app/Screens/editProfile.dart';

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

  @override
  Widget build(BuildContext context) {
    void editProfile() {
      print('Edit Profile Clicked');
       Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditProfile()),
                    );
    }

    Color appBarColor = const Color(0xFF3730A3);
    TextStyle titleStyle = const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white);
    TextStyle subtitleStyle = const TextStyle(fontSize: 20, color: Colors.white70);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: titleStyle),
        backgroundColor: appBarColor,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: editProfile,
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: 
                      Alignment.bottomCenter,
                      colors: [Color(0xFF3730A3), Color(0xFF5C49E0)],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 60.0),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(user?.photoURL ?? 'https://via.placeholder.com/150'),
                    backgroundColor: Colors.white, // Ensuring there's a background color in case the image fails to load
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              userInfo?['name'] ?? 'No name',
              style: titleStyle.copyWith(fontSize: 24, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Text(
              userInfo?['email'] ?? 'No email',
              style: subtitleStyle.copyWith(color: Colors.black54, fontSize: 18),
            ),
             const SizedBox(height: 8),
            Text(
              userInfo?['phone'] ?? 'No phone number',
              style: subtitleStyle.copyWith(color: Colors.black54, fontSize: 18),
            ),
            
            const SizedBox(height: 8),
            Text(
              userInfo?['jobTitle'] ?? 'No job Title',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 1),
            const SizedBox(height: 16),
            const Text(
              'Employee’s History',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ..._buildHistoryList(userInfo?['history'] as List?),
          ],
        ),
      ),
    );
  }

  // Helper method to build a list of history tiles, now integrated within cards for a modern look
  List<Widget> _buildHistoryList(List? historyData) {
    if (historyData == null || historyData.isEmpty) {
      return [const Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Text('No history available', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
      )];
    }

    return historyData.map((data) {
      String date = data['date'] ?? 'Unknown Date';
      String event = data['event'] ?? 'Unknown Event';
      return Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          leading: const Icon(Icons.history, color: Color(0xFF3730A3)),
          title: Text(
            event,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            date,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      );
    }).toList();
  }
}