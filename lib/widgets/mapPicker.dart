import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPicker extends StatefulWidget {
  const MapPicker({
    super.key,
    this.width = 320,
    this.height = 180,
    required this.onLocationChanged,
  });

  final double width;
  final double height;
  final void Function(LatLng) onLocationChanged;

  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  late LatLng? deviceLocation;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    isLoading = true;
    Timer(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
    }

  Future<void> getCurrentLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      deviceLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: isLoading
        ? const Center(child: CircularProgressIndicator())
        : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: deviceLocation!,
          zoom: 13,
        ),
        onCameraIdle: (){
          widget.onLocationChanged(deviceLocation!);
        },
        onTap: (LatLng tapPosition){
          setState(() {
            deviceLocation = tapPosition;
          });
          widget.onLocationChanged(tapPosition);
        },
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
        },
        markers: {
          Marker(
            markerId: const MarkerId('New Location'),
            position: deviceLocation!,
            draggable: true,
            onDragEnd: (LatLng newPosition) {
              setState(() {
                deviceLocation = newPosition;
              });
              widget.onLocationChanged(newPosition);
            },
          ),
        },
      )
    );
  }
}