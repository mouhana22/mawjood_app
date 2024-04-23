// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as map_tool;

class MapWidget extends StatefulWidget {
  const MapWidget({
    super.key,
    this.width = 320,
    this.height = 180,
    required this.name,
    required this.raduis,
    required this.lat,
    required this.lng,
  });

  final String name;
  final double raduis;
  final double lat;
  final double lng;
  
  final double width;
  final double height;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.lat, widget.lng), zoom: 13),
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
        markers: {
          Marker(
            markerId: MarkerId(widget.name),
            position: LatLng(widget.lat, widget.lng),
            ),
        },
        circles: {
          Circle(
            circleId: const CircleId('range'),
            center: LatLng(widget.lat, widget.lng),
            radius: widget.raduis,
            strokeWidth: 2,
            fillColor: const Color(0xFF006491).withOpacity(0.2),
          )
        },
      ),
    );
  }
}
//LatLng(21.559278, 39.144475)