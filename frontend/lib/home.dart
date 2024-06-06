import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_map/plugin_api.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:geojson/geojson.dart';

void main() {
  runApp(MapScreen());
}


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  List<LatLng> routeCoordinates = [];
  List<Marker> stopMarkers = [];


  @override
  void initState() {
    super.initState();
    loadGeoJsonData();
  }

  Future<void> loadGeoJsonData() async {
    final String geoJsonString = await rootBundle.loadString('assets/routes.geojson');
    final GeoJson geoJson = GeoJson();
    geoJson.processedLines.listen((GeoJsonLine line) {
      setState(() {
        routeCoordinates.addAll(line.geoSerie?.toLatLng() as Iterable<LatLng>);
      });
    });
    geoJson.processedPoints.listen((GeoJsonPoint point) {
      setState(() {
        stopMarkers.add(
          Marker(
            point: LatLng(point.geoPoint.latitude, point.geoPoint.longitude),
            builder: (ctx) => Icon(Icons.location_on, color: Colors.red),
          ),
        );
      });
    });
    geoJson.endSignal.listen((bool _) => geoJson.dispose());
    geoJson.parse(geoJsonString, verbose: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(0, 0),
          zoom: 13.0,
        ),
        children: [
        TileLayer(
            urlTemplate:
            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],

        ),
        ],
      ),
    );
  }
}
