import 'package:flutter/material.dart';
import './employeeCard.dart';
import './greenButton.dart';
import './redButton.dart';


class employeeListCard extends StatelessWidget {
  const employeeListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return EmployeeCard(infoRow:["jobTitle","email","phone","status"],actionRow: [statusButtons,deleteButton]);
  }

  statusButtons(employee) {
    return employee["status"]
        ? redButton(text: "Deactivate Employee", icon: Icons.block_outlined)
        : greenButton(text: "Activate Employee", icon: Icons.beenhere_outlined);
  }

  deleteButton(employee) {
    return redButton(text: "Delete Employee", icon: Icons.delete_outline);
  }
}
