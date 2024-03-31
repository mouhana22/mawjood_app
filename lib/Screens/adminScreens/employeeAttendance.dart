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
    return const Column(
        children: [
          Expanded(
            child: EmployeeAttendanceCard(),
          ),
        ],
      );
  }
}
