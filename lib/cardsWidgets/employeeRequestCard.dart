// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './employeeCard.dart';
import '../widgets/iconButton.dart';
import '../widgets/btnTypes.dart';


class EmployeeRequestCard extends StatefulWidget {
  const EmployeeRequestCard({super.key});

  @override
  State<EmployeeRequestCard> createState() => _EmployeeRequestCardState();
}

class _EmployeeRequestCardState extends State<EmployeeRequestCard> {

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

    return EmployeeCard(employees: _employees ,infoRow:["jobTitle","email","phone"],actionRow: [acceptButton,rejectButton]);
  }



  acceptButton(employee) {
    return const CustomIconButton(text: "Accept", icon: Icons.check, type: btnType.Green,);
  }

  rejectButton(employee) {
    return const CustomIconButton(text: "Reject", icon: Icons.close, type: btnType.Red,);
  }
}
