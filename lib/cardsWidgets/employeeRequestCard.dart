// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com


import 'package:flutter/material.dart';
import './employeeCard.dart';
import './btnTypes.dart';
import './iconButton.dart';
import './btnTypes.dart';


class employeeRequestCard extends StatelessWidget {
  const employeeRequestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return EmployeeCard(infoRow:const ["jobTitle","email","phone"],actionRow: [acceptButton,rejectButton]);
  }

  acceptButton(employee) {
    return const iconButton(text: "Accept", icon: Icons.check, type: btnType.Green,);
  }

  rejectButton(employee) {
    return const iconButton(text: "Reject", icon: Icons.close, type: btnType.Red,);
  }
}