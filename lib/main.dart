import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mawjood_app/Screens/adminScreens/adminScreen.dart';
import 'package:mawjood_app/Screens/adminScreens/employeeList.dart';
import 'package:mawjood_app/Screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mawjood_app/cardsWidgets/locationCard.dart';
import 'package:mawjood_app/widgets/checkLocation.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Mawjood',
        debugShowCheckedModeBanner: false,
        home: HomePage(hasAccount: true));
  }
  
}
