import 'package:flutter/material.dart';
import 'package:mawjood_app/Screens/adminScreens/employeeAttendance.dart';
import 'package:mawjood_app/Screens/adminScreens/employeeList.dart';
import 'package:mawjood_app/Screens/adminScreens/employeeRequests.dart';
import 'package:mawjood_app/Screens/adminScreens/locations.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  List<Widget> screens = const [
    EmployeeAttendance(),
    EmployeeList(),
    EmployeeRequests(),
    Locations()
  ];
  void route(index) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screens[index]));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screens[index]));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screens[index]));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screens[index]));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          selectedIndex = index;
          route(index);
        });
      },
      currentIndex: selectedIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          activeIcon: Icon(Icons.person),
          label: 'Attendance',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.format_list_bulleted),
          label: 'List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_add_outlined),
          activeIcon: Icon(Icons.person_add),
          label: 'Requests',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.place_outlined),
          activeIcon: Icon(Icons.place),
          label: 'Location',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout_outlined),
          activeIcon: Icon(Icons.logout),
          label: 'Logout',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.indigo[800],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.indigo[300],
      showUnselectedLabels: true,
    );
  }
}
