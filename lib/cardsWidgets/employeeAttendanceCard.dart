import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/iconButton.dart';
import 'package:mawjood_app/widgets/infoField.dart';
import './employeeCard.dart';

class EmployeeAttendanceCard extends StatefulWidget {
  const EmployeeAttendanceCard({Key? key}) : super(key: key);

  @override
  State<EmployeeAttendanceCard> createState() => _EmployeeAttendanceCardState();
}

class _EmployeeAttendanceCardState extends State<EmployeeAttendanceCard> {
  late List<dynamic> _employees;
  late List<dynamic> _filteredEmployees;
  late DateTime _selectedDate; // Store the selected date
  late List<dynamic> userAttendance;
  late List<dynamic> selectedDateAttendance;

  @override
  void initState() {
    super.initState();
    _employees = [];
    _filteredEmployees = [];
    userAttendance = [];
    selectedDateAttendance = [];
    _selectedDate = DateTime.now();
    getAttendanceByDate(_selectedDate);

  }

 Future getAttendanceByDate(DateTime date) async {
  final DateFormat formatter = DateFormat('yyyyMMdd');
  final String formatted = formatter.format(_selectedDate);
  await fetchAttendanceData(formatted);
  await getData();
  getEmployeesWithAttendance();
}

 Future getEmployeesWithAttendance() async{
  selectedDateAttendance = [];
  // Iterate over userAttendance
  for (var attendance in userAttendance) {
    String userId = attendance['userId'];
    print(attendance);
    // Find corresponding employee by userID
    Map<String, dynamic> employee = _employees.firstWhere((emp) => emp['id'] == userId,orElse: () => Map<String, dynamic>(),);


    if (employee != null) {
      // If employee found, add attendance info to employee data
            Map<String, dynamic> employeeWithAttendance = {
        'checkInTime': attendance['checkInTime'],
        'checkOutTime': attendance['checkOutTime'],
        ...employee, 
      };
      selectedDateAttendance.add(employeeWithAttendance);
    }
  }
  setState(() {
        _filteredEmployees = List.from(selectedDateAttendance);
        userAttendance =[];
      });
}





  Future fetchAttendanceData(String date) async {
      final db = FirebaseFirestore.instance;
    try {
      QuerySnapshot snapshot = await db
          .collection('Attendance')
          .doc(date) // Document ID is the chosen date
          .collection('users')
          .get();
      snapshot.docs.forEach((doc) {
        userAttendance.add(doc.data()); // Add userID to the list
      });
      setState(() {
        userAttendance = userAttendance; 
        
      });
    } catch (e) {
      print("Error fetching attendance data: $e");
    }
  }


  Future getData() async {
    final db = FirebaseFirestore.instance;
    try {
      QuerySnapshot querySnapshot = await db.collection("users").get();
      List<dynamic> fetchedEmployees = [];
      querySnapshot.docs.forEach((docSnapshot) {
        fetchedEmployees.add(docSnapshot.data());
      });
      setState(() {
        _employees = fetchedEmployees;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

void filterEmployees(String query) {
  setState(() {
    if (query.isEmpty) {
      // If the search query is empty, show all employees
      _filteredEmployees = List.from(selectedDateAttendance);
    } else {
      // Filter the employees whose name contains the search query
      _filteredEmployees = selectedDateAttendance.where((employee) {
        final name = employee['name'].toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    }
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
          padding: const EdgeInsets.symmetric(horizontal: 100),
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
    final String checkInMsg = "Checked-In At: ${employee['checkInTime']}";
        return InfoField(
      data: checkInMsg,
      height: 34,
      width: 137.5,
      textColor: Color.fromRGBO(99, 102, 241, 1),
    );
  }

  Widget checkOutTime(employee) {
    final String checkOutMsg = "Checked-Out At: ${employee['checkOutTime']}";
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
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _filteredEmployees = [];
        getAttendanceByDate(_selectedDate);

      });
    }
  }
}
