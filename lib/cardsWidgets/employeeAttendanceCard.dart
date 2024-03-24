// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './employeeCard.dart';
import './infoField.dart';


class employeeAttendanceCard extends StatelessWidget {
  const employeeAttendanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return EmployeeCard(infoRow:["jobTitle","email","phone"],actionRow: [checkInTime,checkOutTime]);
  }

  checkInTime(employee) {
    final DateTime date = DateTime.parse(employee["checkIn"]);
    final String checkInMsg = "Checked-In At: ${DateFormat.jm().format(date)}";
    return infoField(data: checkInMsg, height: 34,width: 137.5,textColor: Color.fromRGBO(99, 102, 241, 1));
  }

  checkOutTime(employee) {
    final DateTime date = DateTime.parse(employee["checkOut"]);
    final String checkOutMsg = "Checked-Out At: ${DateFormat.jm().format(date)}";
    return infoField(data: checkOutMsg, height: 34,width: 137.5, textColor: Color.fromRGBO(99, 102, 241, 1),);
  }
}