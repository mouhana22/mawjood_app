import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final List <Widget> screens;
  final List <Widget> appBars;
  const NavBar({super.key, required this.screens, required this.appBars});
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
        appBar: AppBar(
          title: widget.appBars[selectedIndex],
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: widget.screens,
        ),
        backgroundColor: const Color.fromRGBO(238, 242, 255, 1),
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
          currentIndex: selectedIndex,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ));
  }
}
