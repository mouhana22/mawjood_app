import 'package:flutter/material.dart';
import 'package:mawjood_app/widgets/navbar.dart';
import 'package:mawjood_app/Screens/adminScreens/employeeAttendance.dart';
import 'package:mawjood_app/Screens/adminScreens/employeeList.dart';
import 'package:mawjood_app/Screens/adminScreens/employeeRequests.dart';
import 'package:mawjood_app/Screens/adminScreens/locations.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return NavBar(screens:const [
            EmployeeAttendance(), 
            EmployeeList(),
            EmployeeRequests(),
            Locations(),
          ], appBars: [
            AppBar(title: const Text('Employees Attendance')),
            AppBar(title: const Text('Employees List')),
            AppBar(title: const Text('Employees Requests')),
            AppBar(title: const Text('Locations'))
          ],);
  }
}


    