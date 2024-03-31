// Mohammed ALGhamdi
// Mohalatq88@gmail.com

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MM/dd/yyyy').format(DateTime.now());
    String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());

    return Column(
      children: [
        Text(
          'Date: $formattedDate',
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(height: 8),
        Text(
          'Time: $formattedTime',
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
