import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final List <List<Widget>> screens;
  const NavBar({super.key, required this.screens});
  //List<Widget> get screen => screens;
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color.fromRGBO(238, 242, 255, 1),
        appBar: AppBar(
          title: widget.screens[selectedIndex][1],
        ),
        body: Center(
          child: widget.screens[selectedIndex][0],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
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
          onTap: _onItemTapped,
        ));
  }
}
