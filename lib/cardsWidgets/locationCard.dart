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


class LocationCard extends StatefulWidget {
  const LocationCard({super.key});

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {

  List<dynamic> _locations = [];
  void fetchLocations() async{
  const url = "https://66016fdf87c91a11641ad6fd.mockapi.io/locatons";
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  _locations = jsonDecode(response.body);
  }

  bool readOnly = true;
  void editFields(){
    setState(() {
      readOnly = !readOnly;
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchLocations();

    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: _locations.length,
        itemBuilder: (_, index) {
          final location = _locations[index];
          return CardWidget(
            cardTitle: location["city"],
            cardBody: [
                const MapWidget(),
                const SizedBox(height: 20,),
                InputTextField(label: "name:", content: location["name"],readOnly: readOnly,),
                const SizedBox(height: 20,),
                InputTextField(label: "Address:", content: location["street"],readOnly: readOnly,),
                const SizedBox(height: 20,),
                InputTextField(label: "Radius:", content: location["radius"],readOnly: readOnly,),
                const SizedBox(height: 20,),
                if(readOnly)...[
                  CustomIconButton(text: "Edit Location", icon: Icons.settings, type: btnType.Primary,width: 320, height: 50, onPressed: editFields,)
                ]else...[
                  CustomIconButton(text: "Save Changes", icon: Icons.check, type: btnType.Primary,width: 320, height: 50, onPressed: editFields,)
                ],
                const SizedBox(height: 10,),
            ],
          );
        });
  }




}