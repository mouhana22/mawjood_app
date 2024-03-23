import 'package:flutter/material.dart';
import './employeeCard.dart';
import './greenButton.dart';
import './redButton.dart';


class employeeRequestCard extends StatelessWidget {
  const employeeRequestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return EmployeeCard(infoRow:["jobTitle","email","phone"],actionRow: [acceptButton,rejectButton]);
  }

  acceptButton(employee) {
    return greenButton(text: "Accept", icon: Icons.delete_outline);
  }

  rejectButton(employee) {
    return redButton(text: "Reject", icon: Icons.delete_outline);
  }
}