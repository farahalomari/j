import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


Set<Polyline> polylines = {
  const Polyline(
    polylineId: PolylineId('route1'),
    points: [
      LatLng(37.7749, -122.4194),
      LatLng(37.8051, -122.4300),
      LatLng(37.8070, -122.4093),
    ],
    color: Colors.blue,
    width: 4,
  ),
};
class Bus extends StatelessWidget {
  const Bus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(31.9972367, 35.924535),
              zoom: 14.6,
            ),
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            onCameraMove: (position) {
              log(position.target.latitude.toString());
              log(position.target.longitude.toString());
            },
            onMapCreated: (controller) {},
          ),
          const Center(
            child: Icon(
              Icons.location_pin,
              size: 30,
            ),
          )
        ],
      ),
    );
  }

}