import 'package:flutter/material.dart';
import 'package:mawjood_app/Screens/adminScreens/employeeList.dart';
import 'package:mawjood_app/Screens/home_page.dart';
import 'package:mawjood_app/Screens/adminScreens/employeeAttendance.dart';
import 'package:mawjood_app/Screens/adminScreens/locations.dart';
import 'package:mawjood_app/Screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mawjood',
        debugShowCheckedModeBanner: false,
        home: HomePage(
          hasAccount: true,
        ));
  }
}