// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/cardWidget.dart';
import '../widgets/mapWidget.dart';
import '../widgets/inputTextField.dart';
import '../widgets/iconButton.dart';
import '../widgets/btnTypes.dart';


class locationCard extends StatefulWidget {
  const locationCard({super.key});

  @override
  State<locationCard> createState() => _locationCardState();
}

class _locationCardState extends State<locationCard> {

  List<dynamic> _locations = [];
  void fetchLocations() async{
  const url = "https://66016fdf87c91a11641ad6fd.mockapi.io/locatons";
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  _locations = jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    fetchLocations();

    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: _locations.length,
        itemBuilder: (_, index) {
          final location = _locations[index];
          return cardWidget(
            cardTitle: location["city"],
            cardBody: [
                mapWidget(),
                SizedBox(height: 20,),
                inputTextField(lablel: "name:", content: location["name"],readOnly: true,),
                SizedBox(height: 20,),
                inputTextField(lablel: "Address:", content: location["street"],readOnly: true,),
                SizedBox(height: 20,),
                inputTextField(lablel: "Radius:", content: location["radius"],readOnly: true,),
                SizedBox(height: 20,),
                iconButton(text: "Edit Location", icon: Icons.settings, type: btnType.Primary,width: 320, height: 50,fontSize: 14,),
                SizedBox(height: 10,),
            ],
          );
        });
  }




}