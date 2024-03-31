import 'package:flutter/material.dart';
import 'package:mawjood_app/cardsWidgets/employeeListCard.dart';
import 'package:mawjood_app/widgets/navbar.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 242, 255, 1),
      appBar: AppBar(title: const Text('Employees List')),
      body: const Column(
        children: [
          Expanded(
            child: EmployeeListCard(),
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
