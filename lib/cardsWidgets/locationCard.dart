import 'package:flutter/material.dart';
import '../widgets/cardWidget.dart';
import '../widgets/mapWidget.dart';
import '../widgets/inputTextField.dart';
import '../widgets/iconButton.dart';
import '../widgets/btnTypes.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class LocationCard extends StatefulWidget {
  const LocationCard({super.key});
  
  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  List<QueryDocumentSnapshot<Object?>>? _locations;
  CollectionReference<Map<String, dynamic>>? documents;
  bool readOnly = true;
  
  @override
  void initState() {
    super.initState();
  } 

  void editFields() {
    setState(() {
      readOnly = !readOnly;
    });
  }
  
  @override
  Widget build(BuildContext context) { 
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('locations').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          _locations = snapshot.data?.docs.reversed.toList();
          documents = FirebaseFirestore.instance.collection('locations');
        }
        return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: _locations?.length,
            itemBuilder: (_, index) {
              String name = _locations?[index]['city'];
              String address = _locations?[index]['address'];
              double radius = _locations?[index]['radius'].toDouble();
              double lat = _locations?[index]['lat'].toDouble();
              double lng = _locations?[index]['lng'].toDouble();
              return CardWidget(
                cardTitle: name,
                cardBody: [
                  MapWidget(name: name, raduis: radius, lat: lat, lng: lng,),
                  const SizedBox(height: 20,),
                  InputTextField(label: "Name:", content: name, readOnly: readOnly,),
                  const SizedBox(height: 20,),
                  InputTextField(label: "Address:", content: address, readOnly: readOnly,),
                  const SizedBox(height: 20,),
                  InputTextField(label: "Radius:", content: radius.toString(), readOnly: readOnly,),
                  const SizedBox(height: 20,),
                  CustomIconButton(text: 'Delete Location', icon: Icons.delete, type: btnType.Primary, width: 320, height: 50, onPressed:()
                    {
                      documents?.doc(_locations?[index].id).delete();
                    }),
                  const SizedBox(height: 10,),
                ],
              );
            });
      }
    );
  }
}

//print('-----------------------------------------');