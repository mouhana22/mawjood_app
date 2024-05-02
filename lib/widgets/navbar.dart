import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mawjood_app/Screens/Profile.dart';
import 'package:mawjood_app/Screens/home_page.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/iconButton.dart';

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

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context) => const HomePage(hasAccount: true,)),);
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: widget.appBars[selectedIndex],
          centerTitle: true,
          actions: [
            IconButton(onPressed: _logout, icon: const Icon(Icons.logout), color: Colors.indigo[800],),
            const SizedBox(width: 10,)
          ],
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
            )
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
