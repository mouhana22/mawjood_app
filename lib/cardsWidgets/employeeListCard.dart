import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './employeeCard.dart';
import '../widgets/iconButton.dart';
import '../widgets/btnTypes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    getData();
  }

Future<dynamic> getData() async {
  final db = FirebaseFirestore.instance;
  try {
    QuerySnapshot querySnapshot = await db.collection("users").get();
    List<dynamic> fetchedEmployees = [];
    querySnapshot.docs.forEach((docSnapshot) {
      Map<String, dynamic>? fetchedEmployee = docSnapshot.data() as Map<String, dynamic>?;

      if(!(fetchedEmployee?["admin"] == true))
          fetchedEmployees.add(docSnapshot.data());
    });
    setState(() {
      _employees = fetchedEmployees;
      _filteredEmployees = List.from(_employees);
    });
  } catch (e) {
    print("Error fetching data: $e");
  }
}

void filterEmployees(String query) {
  setState(() {
    if (query.isEmpty) {
      // If the search query is empty, show all employees
      _filteredEmployees = List.from(_employees);
    } else {
      // Filter the employees whose name contains the search query
      _filteredEmployees = _employees.where((employee) {
        final name = employee['name'].toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: getData,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterEmployees,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
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
      ),
    );
  }

Widget statusButtons(employee) {
  return employee["status"]
      ? CustomIconButton(
          text: "Deactivate Employee",
          icon: Icons.block_outlined,
          type: btnType.Red,
          fontSize: 10,
          onPressed: () {
            // Update status to false (deactivate)
            _updateEmployeeStatus(employee, false);
          },
        )
      : CustomIconButton(
          text: "Activate Employee",
          icon: Icons.beenhere_outlined,
          type: btnType.Green,
          fontSize: 10,
          onPressed: () {
            // Update status to true (activate)
            _updateEmployeeStatus(employee, true);
          },
        );
}

Widget deleteButton(employee) {
  return CustomIconButton(
    text: "Delete Employee",
    icon: Icons.delete_outline,
    type: btnType.Red,
    fontSize: 10,
    onPressed: () {
      // Delete the employee
      _deleteEmployee(employee);
    },
  );
}

// Function to update employee status
void _updateEmployeeStatus(Map<String, dynamic> employee, bool newStatus) async {
  try {
    await FirebaseFirestore.instance.collection("users").doc(employee['id']).update({
      'status': newStatus,
    });
    // Refresh the data after updating status
    getData();
  } catch (e) {
    print("Error updating employee status: $e");
  }
}

// Function to delete an employee
void _deleteEmployee(Map<String, dynamic> employee) async {
  try {
    await FirebaseFirestore.instance.collection("users").doc(employee['id']).delete();
    // Refresh the data after deleting employee
    getData();
  } catch (e) {
    print("Error deleting employee: $e");
  }
}
}