import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mawjood_app/cardsWidgets/locationCard.dart';
import 'package:mawjood_app/widgets/addLocation.dart';
import 'package:mawjood_app/widgets/navbar.dart';

class Locations extends StatefulWidget {
  const Locations({super.key});

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  @override
  Widget build(BuildContext context) {
    return const Column(
        children: [
          AddLocation(),
          Expanded(child: LocationCard(),),
        ],
      );
  }
}
// appBar: AppBar(title: const Text('Locations')),
