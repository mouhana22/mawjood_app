// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './employeeCard.dart';
import '../widgets/iconButton.dart';
import '../widgets/btnTypes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
    getData();
  }

getData() async {
  final db = FirebaseFirestore.instance;
  try {
    QuerySnapshot querySnapshot = await db.collection("requests").get();
    List<dynamic> fetchedEmployees = [];
    querySnapshot.docs.forEach((docSnapshot) {
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
  //print("Filtering employees with query: $query");
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
    //print("Filtered employees: $_filteredEmployees");
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
  return CustomIconButton(
    text: "Accept",
    icon: Icons.check,
    type: btnType.Green,
    onPressed: () async {
      try {
        // Move the document to the "users" collection
        await FirebaseFirestore.instance.collection("users").doc(employee['id']).set(employee);
        
        // Delete the document from the "requests" collection
        await FirebaseFirestore.instance.collection("requests").doc(employee['id']).delete();

        setState(() {
          // Remove the deleted employee from the _employees list
          _employees.removeWhere((e) => e['id'] == employee['id']);
          // Update the filtered employees as well
          _filteredEmployees = List.from(_employees);
        });
      } catch (e) {
        print("Error accepting request: $e");
      }
    },
  );
}

rejectButton(employee) {
  return CustomIconButton(
    text: "Reject",
    icon: Icons.close,
    type: btnType.Red,
    onPressed: () async {
      try {
        // Delete the document from the "requests" collection
        await FirebaseFirestore.instance.collection("requests").doc(employee['id']).delete();

        setState(() {
          // Remove the deleted employee from the _employees list
          _employees.removeWhere((e) => e['id'] == employee['id']);
          // Update the filtered employees as well
          _filteredEmployees = List.from(_employees);
        });
      } catch (e) {
        print("Error rejecting request: $e");
      }
    },
  );
}



}
