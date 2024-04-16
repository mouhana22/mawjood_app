import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './employeeCard.dart';
import '../widgets/iconButton.dart';
import '../widgets/btnTypes.dart';

class EmployeeListCard extends StatefulWidget {
  const EmployeeListCard({Key? key}) : super(key: key);

  @override
  State<EmployeeListCard> createState() => _EmployeeListCardState();
}

class _EmployeeListCardState extends State<EmployeeListCard> {
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
            infoRow: ["jobTitle", "email", "phone", "status"],
            actionRow: [statusButtons, deleteButton],
          ),
        ),
      ],
    );
  }

  Widget statusButtons(employee) {
    return employee["status"]
        ? CustomIconButton(
            text: "Deactivate Employee",
            icon: Icons.block_outlined,
            type: btnType.Red,
            fontSize: 10,
            onPressed: () {},
          )
        : CustomIconButton(
            text: "Activate Employee",
            icon: Icons.beenhere_outlined,
            type: btnType.Green,
            fontSize: 10,
            onPressed: () {},
          );
  }

  Widget deleteButton(employee) {
    return CustomIconButton(
      text: "Delete Employee",
      icon: Icons.delete_outline,
      type: btnType.Red,
      fontSize: 10,
      onPressed: () {},
    );
  }
}