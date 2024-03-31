import 'package:flutter/material.dart';
import 'package:mawjood_app/cardsWidgets/employeeAttendanceCard.dart';
import 'package:mawjood_app/widgets/navbar.dart';

class EmployeeAttendance extends StatefulWidget {
  const EmployeeAttendance({super.key});

  @override
  State<EmployeeAttendance> createState() => _EmployeeAttendanceState();
}

class _EmployeeAttendanceState extends State<EmployeeAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 242, 255, 1),
      appBar: AppBar(title: const Text('Employees Attendance')),
      body: const Column(
        children: [
          Expanded(
            child: EmployeeAttendanceCard(),
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
