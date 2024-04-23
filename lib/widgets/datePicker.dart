import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/iconButton.dart';


class DatePicker extends StatefulWidget {
  const DatePicker({super.key});
  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  var date = DateFormat('dd-MM-yyyy').format(DateTime.now());
 
  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
        icon: Icons.date_range,
        text: date,
        type: btnType.Primary,  
        onPressed: () async {
          final DateTime? selectedDate = await showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime(2025)
            );
          if (selectedDate != null) {
            setState(() {
              date = DateFormat('dd-MM-yyyy').format(selectedDate);
            });
            //widget.onPicked(today);
          }
        },
      );
  }
}

 // var _employees = [];
  // void fetchEmployees() async{
  // const url = "https://65c8f413a4fbc162e1126b21.mockapi.io/employee";
  // final uri = Uri.parse(url);
  // final response = await http.get(uri);
  // _employees = jsonDecode(response.body);
  // }
  // void onPicked(){
  //   fetchEmployees();
  // }
  