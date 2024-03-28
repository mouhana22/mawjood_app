import 'package:flutter/material.dart';

class StatusBox extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Color textColor;
  final String? date; // Make date nullable
  final String? time; // Make time nullable
  final Color color; // New parameter for box color

  const StatusBox({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.textColor,
    this.date, // Nullable date parameter
    this.time, // Nullable time parameter
    required this.color, // Added color parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: color, // Use the provided color for the box
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
          if (date != null) // Display date if it's not null
            Text(date!),
          if (time != null) // Display time if it's not null
            Text(time!),
        ],
      ),
    );
  }
}
