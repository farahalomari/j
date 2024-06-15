import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_map/plugin_api.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:geojson/geojson.dart';
import 'js_util.dart';
//import 'package:flutter_map_geojson/flutter_map_geojson.dart';

void main() {
  runApp(const MapScreen());
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  List<LatLng> routeCoordinates = [];
  List<Marker> stopMarkers = [];

  @override
  void initState() {
    super.initState();
    loadGeoJsonData();
  }

  Future<void> loadGeoJsonData() async {
    final String geoJsonString =
        await rootBundle.loadString('assets/map/map.geojson');
    final GeoJson geoJson = GeoJson();

    geoJson.processedLines.listen((GeoJsonLine line) {
      final List<LatLng> coordinates =
          line.geoSerie?.toLatLng() as List<LatLng>;
      addPolyline(coordinates); // Add polyline to Google Map
    });

    geoJson.processedPoints.listen((GeoJsonPoint point) {
      final LatLng position =
          LatLng(point.geoPoint.latitude, point.geoPoint.longitude);
      addMarker(
          position.latitude, position.longitude); // Add marker to Google Map
    });

    geoJson.endSignal.listen((bool _) => geoJson.dispose());
    geoJson.parse(geoJsonString, verbose: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(0, 0),
          zoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: routeCoordinates,
                color: Colors.blue, // Customize polyline color
                strokeWidth: 4, // Customize polyline width
              ),
            ],
          ),
          MarkerLayer(markers: stopMarkers),
        ],
      ),
    );
  }
}
