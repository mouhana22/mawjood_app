import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as maps_tool;

class CheckLocation {
  final CollectionReference _collectionRef = FirebaseFirestore.instance.collection('locations');
  late List<dynamic> locations;
  final db = FirebaseFirestore.instance;
  late LatLng registeredPosition;
  late LatLng deviceLocation;
  late Position position;
  bool inLocation = false;

  Future<void> getCurrentLocation() async{
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high); 
    deviceLocation = LatLng(position.latitude,position.longitude);
  }

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    locations = querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  num checkDistance(LatLng device, LatLng registered){
    num distance = maps_tool.SphericalUtil.computeDistanceBetween(maps_tool.LatLng(device.latitude, device.longitude),
    maps_tool.LatLng(registered.latitude, registered.longitude));
    return distance;
  }
  Future<bool> checkLocation() async {
    await getCurrentLocation();
    await getData();
    
    for(int i = 0; i < locations.length ; i++){
      registeredPosition = LatLng(locations[i]['lat'], locations[i]['lng']);
      if(locations[i]['radius'] > checkDistance(deviceLocation, registeredPosition).abs()){
        inLocation = true;
        break;
      }
    }

    return inLocation;
  }
}
