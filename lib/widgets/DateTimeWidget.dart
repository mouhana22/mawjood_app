// Mohammed ALGhamdi
// Mohalatq88@gmail.com

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MM/dd/yyyy').format(DateTime.now());
    String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());

    return Column(
      children: [
        Text(
          'Date: $formattedDate',
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(height: 8),
        Text(
          'Time: $formattedTime',
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
