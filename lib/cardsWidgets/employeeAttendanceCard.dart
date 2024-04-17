import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/infoField.dart';
import 'dart:convert';
import './employeeCard.dart';
import 'package:mawjood_app/widgets/iconButton.dart';

class EmployeeAttendanceCard extends StatefulWidget {
  const EmployeeAttendanceCard({Key? key}) : super(key: key);

  @override
  State<EmployeeAttendanceCard> createState() =>
      _EmployeeAttendanceCardState();
}

class _EmployeeAttendanceCardState extends State<EmployeeAttendanceCard> {
  late List<dynamic> _employees;
  late List<dynamic> _filteredEmployees;
  late DateTime _selectedDate; // Store the selected date

  @override
  void initState() {
    super.initState();
    _employees = [];
    _filteredEmployees = [];
    _selectedDate = DateTime.now(); // Initialize with current date
    fetchEmployees();
  }

  void fetchEmployees() async {
    const url = "https://65c8f413a4fbc162e1126b21.mockapi.io/employee";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    setState(() {
      _employees = jsonDecode(response.body);
      _filteredEmployees = _employees
          .where((employee) =>
              DateFormat('yyyy-MM-dd').format(DateTime.parse(employee['checkIn'])) ==
              DateFormat('yyyy-MM-dd').format(_selectedDate))
          .toList();
    });
  }

  void filterEmployees(String query) {
    setState(() {
      _filteredEmployees = _employees.where((employee) {
        final name = employee['name'].toString().toLowerCase();
        final checkInDate = DateTime.parse(employee['checkIn']);
        // Check if employee's name contains the query and check-in date matches selected date
        return name.contains(query.toLowerCase()) &&
            checkInDate.year == _selectedDate.year &&
            checkInDate.month == _selectedDate.month &&
            checkInDate.day == _selectedDate.day;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: filterEmployees,
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120),
          child: CustomIconButton(
            icon: Icons.date_range,
            text: DateFormat('yyyy-MM-dd').format(_selectedDate),
            type: btnType.Primary,
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),

        const SizedBox(height: 8.0), // Add space between search bar and date button
        Expanded(
          child: EmployeeCard(
            employees: _filteredEmployees,
            infoRow: const ["jobTitle", "email", "phone"],
            actionRow: [checkInTime, checkOutTime],
          ),
        ),
      ],
    );
  }

  Widget checkInTime(employee) {
    final DateTime date = DateTime.parse(employee["checkIn"]);
    final String checkInMsg = "Checked-In At: ${DateFormat.jm().format(date)}";
    return InfoField(
      data: checkInMsg,
      height: 34,
      width: 137.5,
      textColor: Color.fromRGBO(99, 102, 241, 1),
    );
  }

  Widget checkOutTime(employee) {
    final DateTime date = DateTime.parse(employee["checkOut"]);
    final String checkOutMsg =
        "Checked-Out At: ${DateFormat.jm().format(date)}";
    return InfoField(
      data: checkOutMsg,
      height: 34,
      width: 137.5,
      textColor: Color.fromRGBO(99, 102, 241, 1),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate){
      setState(() {
        _selectedDate = picked;
        filterEmployees(""); // Reset filter when date changes
        fetchEmployees(); // Update employees for the selected date
      });
    }
  }
}
