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
  });

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
        initialCameraPosition: const CameraPosition(
            target: LatLng(21.559278, 39.144475), zoom: 13),
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
        markers: {
          const Marker(
            markerId: MarkerId('DerwazaHQ'),
            position: LatLng(21.559278, 39.144475),
            ),
        },
        circles: {
          Circle(
            circleId: CircleId('range'),
            center: LatLng(21.559278, 39.144475),
            radius: 100.0,
            strokeWidth: 2,
            fillColor: Color(0xFF006491).withOpacity(0.2),
          )
        },
      ),
    );
  }
}
