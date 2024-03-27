import 'package:flutter/material.dart';

class EmployeeRequests extends StatefulWidget {
  const EmployeeRequests({super.key});

  @override
  State<EmployeeRequests> createState() => _EmployeeRequestsState();
}

class _EmployeeRequestsState extends State<EmployeeRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("this is Employee Requests page"),
    );
  }
}