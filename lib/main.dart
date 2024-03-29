import 'package:flutter/material.dart';
import 'package:mawjood_app/Screens/home_page.dart';
import 'package:mawjood_app/Screens/adminScreens/employeeAttendance.dart';
import 'package:mawjood_app/Screens/adminScreens/locations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mawjood',
      debugShowCheckedModeBanner: false,
      home: HomePage(
        hasAccount: true,
      ),
    );
  }
}
