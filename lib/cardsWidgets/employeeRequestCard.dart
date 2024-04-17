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
  late List<dynamic> _employees;
  late List<dynamic> _filteredEmployees;

  @override
  void initState() {
    super.initState();
    _employees = [];
    _filteredEmployees = [];
    fetchEmployees();
  }

  void fetchEmployees() async {
    const url = "https://65c8f413a4fbc162e1126b21.mockapi.io/employee";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    setState(() {
      _employees = jsonDecode(response.body);
      _filteredEmployees = List.from(_employees); // Initialize filtered list with all employees
    });
  }

  void filterEmployees(String query) {
    setState(() {
      _filteredEmployees = _employees.where((employee) {
        final name = employee['name'].toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: filterEmployees,
            decoration: InputDecoration(
              hintText: 'Search by name...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: EmployeeCard(
            employees: _filteredEmployees,
            infoRow: ["jobTitle", "email", "phone"],
            actionRow: [acceptButton, rejectButton],
          ),
        ),
      ],
    );
  }



  acceptButton(employee) {
    return CustomIconButton(text: "Accept", icon: Icons.check, type: btnType.Green, onPressed: (){},);
  }

  rejectButton(employee) {
    return CustomIconButton(text: "Reject", icon: Icons.close, type: btnType.Red, onPressed: (){},);
  }
}
