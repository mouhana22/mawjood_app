// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './employeeCard.dart';
import '../widgets/iconButton.dart';
import '../widgets/btnTypes.dart';


class EmployeeListCard extends StatefulWidget {
  const EmployeeListCard({super.key});

  @override
  State<EmployeeListCard> createState() => _EmployeeListCardState();
}

class _EmployeeListCardState extends State<EmployeeListCard> {

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
        ? const CustomIconButton(text: "Deactivate Employee", icon: Icons.block_outlined, type: btnType.Red, fontSize: 10)
        : const CustomIconButton(text: "Activate Employee", icon: Icons.beenhere_outlined, type: btnType.Green, fontSize: 10,);
  }

  deleteButton(employee) {
    return const CustomIconButton(text: "Delete Employee", icon: Icons.delete_outline, type: btnType.Red, fontSize: 10);
  }
}
