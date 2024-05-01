import 'package:flutter/material.dart';
import 'package:mawjood_app/cardsWidgets/employeeListCard.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  @override
  Widget build(BuildContext context) {
    return const Column(
        children: [
          Expanded(
            child: EmployeeListCard(),
          ),
        ],
      );
  }
}