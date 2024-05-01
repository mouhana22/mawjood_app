import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/iconButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mawjood_app/widgets/mapPicker.dart';

class AddLocation extends StatelessWidget {
  const AddLocation({super.key});

  @override
  Widget build(BuildContext context) {
    // TextEditingController for handling user inputs
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController radiusController = TextEditingController();

    late LatLng position;

    // Function to add location to Firebase Firestore
    Future<void> addLocationToFirebase(String name, String address, double radius, LatLng location) async {
      await FirebaseFirestore.instance.collection('locations').add({
          'city': name,
          'address': address,
          'radius': radius,
          'lat': location.latitude,
          'lng': location.longitude
        });
    }

    return CustomIconButton(
      width: 200,
      text: 'Add New Location',
      icon: Icons.add,
      type: btnType.Primary,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Add New Location'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    MapPicker(
                      onLocationChanged: (LatLng location) {
                        position = location;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'City'),
                    ),
                    TextField(
                      controller: addressController,
                      decoration: InputDecoration(labelText: 'Address'),
                    ),
                    TextField(
                      controller: radiusController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Radius'),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Add'),
                  onPressed: () {
                    String name = nameController.text.trim();
                    String address = addressController.text.trim();
                    double radius = double.parse(radiusController.text.trim());
                    if (name.isNotEmpty && address.isNotEmpty && radius > 0) {
                      addLocationToFirebase(name, address, radius, position);
                      Navigator.of(context).pop();
                    } 
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}