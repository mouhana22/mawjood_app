// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './employeeCard.dart';
import '../widgets/infoField.dart';


class EmployeeAttendanceCard extends StatefulWidget {
  const EmployeeAttendanceCard({super.key});

  @override
  State<EmployeeAttendanceCard> createState() => _EmployeeAttendanceCardState();
}

class _EmployeeAttendanceCardState extends State<EmployeeAttendanceCard> {

  List<dynamic> _employees = [];
  void fetchEmployees() async{
  const url = "https://65c8f413a4fbc162e1126b21.mockapi.io/employee";
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  _employees = jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    fetchEmployees();

    return EmployeeCard(employees: _employees ,infoRow:const ["jobTitle","email","phone"],actionRow: [checkInTime,checkOutTime]);
  }



   checkInTime(employee) {
    final DateTime date = DateTime.parse(employee["checkIn"]);
    final String checkInMsg = "Checked-In At: ${DateFormat.jm().format(date)}";
    return InfoField(data: checkInMsg, height: 34,width: 137.5,textColor: Color.fromRGBO(99, 102, 241, 1));
  }

  checkOutTime(employee) {
    final DateTime date = DateTime.parse(employee["checkOut"]);
    final String checkOutMsg = "Checked-Out At: ${DateFormat.jm().format(date)}";
    return InfoField(data: checkOutMsg, height: 34,width: 137.5, textColor: Color.fromRGBO(99, 102, 241, 1),);
  }
}
