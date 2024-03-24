// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com


import 'package:flutter/material.dart';
import './employeeCard.dart';
import './iconButton.dart';
import './btnTypes.dart';


class employeeListCard extends StatelessWidget {
  const employeeListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return EmployeeCard(infoRow:["jobTitle","email","phone","status"],actionRow: [statusButtons,deleteButton]);
  }

  statusButtons(employee) {
    return employee["status"]
        ? const iconButton(text: "Deactivate Employee", icon: Icons.block_outlined, type: btnType.Red,)
        : const iconButton(text: "Activate Employee", icon: Icons.beenhere_outlined, type: btnType.Green,);
  }

  deleteButton(employee) {
    return const iconButton(text: "Delete Employee", icon: Icons.delete_outline, type: btnType.Red,);
  }
}
