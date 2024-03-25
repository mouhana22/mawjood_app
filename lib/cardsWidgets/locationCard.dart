// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './cardWidget.dart';
import './employeeCard.dart';
import './iconButton.dart';
import './btnTypes.dart';


class locationCard extends StatefulWidget {
  const locationCard({super.key});

  @override
  State<locationCard> createState() => _locationCardState();
}

class _locationCardState extends State<locationCard> {

  List<dynamic> _locations = [];
  void fetchEmployees() async{
  const url = "https://66016fdf87c91a11641ad6fd.mockapi.io/locatons";
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  _locations = jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    fetchEmployees();

    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: _locations.length,
        itemBuilder: (_, index) {
          final location = _locations[index];
          return cardWidget(
            cardTitle: location["city"],
            cardBody: [
              
            ],
          );
        });
  }




}