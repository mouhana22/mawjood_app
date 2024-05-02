import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mawjood_app/Screens/CheckOut.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/iconButton.dart';
import 'package:mawjood_app/widgets/imageWidget.dart';
import 'package:mawjood_app/widgets/statusBox.dart';

class CheckIn extends StatelessWidget {
  final String id;
  late String refDocId;

  CheckIn({super.key, required this.id});

  void checkIn() {
    DateTime now = DateTime.now();
    String today = DateFormat('yyyyMMdd').format(now);
    String timeOnly =
        DateFormat('HH:mm:ss').format(now); // Format for time only
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('Attendance')
        .doc(today)
        .collection('users')
        .doc();
    refDocId = docRef.id;
    docRef.set({
      'checkIn': timeOnly, // Store the formatted time
      'userId': id,
    });
  }

  void checkOut() {
    DateTime now = DateTime.now();
    String today = DateFormat('yyyyMMdd').format(now);
    String timeOnly =
        DateFormat('HH:mm:ss').format(now); // Format for time only
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('Attendance')
        .doc(today)
        .collection('users')
        .doc(refDocId);
    docRef.update({
      'checkOut': timeOnly, // Update with the formatted time
    });
  }

  @override
  Widget build(BuildContext context) {
    checkIn(); // Consider the implications of calling this in build method
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 242, 255, 1),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const ImageWidget(
                avatarURL: 'https://i.ibb.co/94RhRtG/logo.png',
                width: 50,
                height: 50,
              ),
              const SizedBox(height: 200.0),
              const StatusBox(
                icon: Icons.check_circle_outline,
                iconColor: Color.fromRGBO(140, 170, 52, 1),
                title: 'Successfully Checked in',
                textColor: Color.fromRGBO(140, 170, 52, 1),
                color: Color.fromRGBO(222, 231, 194, 1),
                showDateTime:
                    true, // Assuming you still want to show something here
              ),
              const SizedBox(height: 16),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomIconButton(
                  onPressed: () {
                    checkOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CheckOut()),
                    );
                  },
                  icon: Icons.logout,
                  text: 'Check-Out',
                  type: btnType.Red,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
