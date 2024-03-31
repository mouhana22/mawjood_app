// Mohammed ALGhamdi
// Mohalatq88@gmail.com

import 'package:flutter/material.dart';
import 'package:mawjood_app/widgets/DateTimeWidget.dart'; // Import DateTimeWidget

class StatusBox extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Color textColor;
  final Color color;
  final bool
      showDateTime; // New parameter to indicate whether to show DateTimeWidget

  const StatusBox({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.textColor,
    required this.color,
    this.showDateTime = true, // Default value to true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            color: iconColor,
            size: 40.0,
          ),
          SizedBox(height: 10.0),
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          if (showDateTime) // Conditionally show DateTimeWidget
            DateTimeWidget(), // Show DateTimeWidget if showDateTime is true
        ],
      ),
    );
  }
}
