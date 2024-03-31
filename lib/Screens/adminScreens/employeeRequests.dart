import 'package:flutter/material.dart';
import 'package:mawjood_app/cardsWidgets/employeeRequestCard.dart';
import 'package:mawjood_app/widgets/navbar.dart';

class EmployeeRequests extends StatefulWidget {
  const EmployeeRequests({super.key});

  @override
  State<EmployeeRequests> createState() => _EmployeeRequestsState();
}

class _EmployeeRequestsState extends State<EmployeeRequests> {
  @override
  Widget build(BuildContext context) {
    return const Column(
        children: [
          Expanded(
            child: EmployeeRequestCard(),
          ),
        ],
      );
  }
}
//AppBar(title: const Text('Employees Requests')),