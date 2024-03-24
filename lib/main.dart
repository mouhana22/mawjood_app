import 'package:flutter/material.dart';
import './cardsWidgets/employeeListCard.dart';
import './cardsWidgets/employeeRequestCard.dart';
import './cardsWidgets/employeeAttendanceCard.dart';

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
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(238, 242, 255, 1),
        appBar: AppBar(title: const Text('testing')),
        body: const employeeListCard(),
      ),
    );
  }

}

