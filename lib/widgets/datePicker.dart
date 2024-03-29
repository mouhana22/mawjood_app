import 'package:flutter/material.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/iconButton.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  var today = (DateTime.now().year, DateTime.now().month, DateTime.now().day);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: CustomIconButton(
        icon: Icons.date_range,
        text: today.toString(),
        type: btnType.Secondary,
        onPressed: () async {
          final DateTime? dateTime = await showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime(2025));
          if (dateTime != null) {
            setState(() {
              today = (dateTime.year, dateTime.month, dateTime.day);
            });
          }
        },
      ),
    );
  }
}
