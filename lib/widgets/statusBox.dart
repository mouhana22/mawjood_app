import 'package:flutter/material.dart';

class statusBox extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Color textColor;
  final String date;
  final String time;

  const statusBox({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.textColor,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.lightGreen[100],
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
          Text(date),
          Text(time),
        ],
      ),
    );
  }
}
