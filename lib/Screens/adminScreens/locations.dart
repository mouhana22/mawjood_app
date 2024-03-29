import 'package:flutter/material.dart';
import 'package:mawjood_app/cardsWidgets/locationCard.dart';

class Locations extends StatefulWidget {
  const Locations({super.key});

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 242, 255, 1),
      appBar: AppBar(title: const Text('Locations')),
      body: const LocationCard(),
    );
  }
}
