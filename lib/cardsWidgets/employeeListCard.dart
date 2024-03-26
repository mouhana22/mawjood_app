// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './employeeCard.dart';
import '../widgets/iconButton.dart';
import '../widgets/btnTypes.dart';


class employeeListCard extends StatefulWidget {
  const employeeListCard({super.key});

  @override
  State<employeeListCard> createState() => _employeeListCardState();
}

class _employeeListCardState extends State<employeeListCard> {

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

    return EmployeeCard(employees: _employees ,infoRow:["jobTitle","email","phone","status"],actionRow: [statusButtons,deleteButton]);
  }



  statusButtons(employee) {
    return employee["status"]
        ? const iconButton(text: "Deactivate Employee", icon: Icons.block_outlined, type: btnType.Red,)
        : const iconButton(text: "Activate Employee", icon: Icons.beenhere_outlined, type: btnType.Green,);
  }

  deleteButton(employee) {
    return const iconButton(text: "Delete Employee", icon: Icons.delete_outline, type: btnType.Red,);
  }
}
