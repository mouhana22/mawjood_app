import 'package:flutter/material.dart';
import 'package:mawjood_app/Screens/RegisterPage.dart';
import './cardsWidgets/employeeListCard.dart';
import './cardsWidgets/employeeRequestCard.dart';
import './cardsWidgets/employeeAttendanceCard.dart';
import './cardsWidgets/locationCard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(238, 242, 255, 1),
        appBar: AppBar(title: const Text('testing')),
        body: const employeeAttendanceCard(),
      ),
    );
  }

}