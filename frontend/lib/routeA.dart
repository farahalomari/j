import 'package:flutter/material.dart';
import 'package:gradproj7/live.dart';
import 'package:gradproj7/location.dart';
import 'package:gradproj7/settings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat_lng;
//import 'dart:convert';
//import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Map screen ",
      home: MapAScreen(),
    ),
  );
}

class MapAScreen extends StatefulWidget {
  const MapAScreen({super.key});

  @override
  State<MapAScreen> createState() => _MapAScreenState();
}

class _MapAScreenState extends State<MapAScreen> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  Position? _currentPosition;
  double? l1;
  double? l2;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  Future<void> _getCurrentPosition() async {
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      l1 = _currentPosition?.latitude;
      l2 = _currentPosition?.longitude;
    });
  }

  //supposed to connect map
  /* Future<void> readGeoJSONFile() async {
    File file = File('path_to_your_geojson_file.geojson');
    String contents = await file.readAsString();
    Map<String, dynamic> data = json.decode(contents);
    // Now you have your GeoJSON data in the 'data' variable
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FlutterMap(
          options: MapOptions(
            center: lat_lng.LatLng(30.5852, 36.2384),
            zoom: 16.0,
            minZoom: 10,
          ),
          children: [
            TileLayer(
              urlTemplate:
              'https://www.openstreetmap.org/#map=15/31.9568/35.9168&layers=T',
              // map box URl
              // 'https://api.mapbox.com/styles/v1/juliagreen/clv2ok0mt00cs01qzdkqs2cfc/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoianVsaWFncmVlbiIsImEiOiJjbHYyb2dwdTQwYzhzMmtvN3JtY2l3ejBlIn0.Y3mES-JsXhTpyPmI3O8dpQ',
              //access token of mapbox map
              /*additionalOptions: const {
                     'accessToken': 'pk.eyJ1IjoianVsaWFncmVlbiIsImEiOiJjbHYyb2dwdTQwYzhzMmtvN3JtY2l3ejBlIn0.Y3mES-JsXhTpyPmI3O8dpQ',
                   },*/
            ),
          ],
        ),

        //navigation bar
        bottomNavigationBar: NavigationBar(
          labelBehavior: labelBehavior,
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: <Widget>[
            GestureDetector(
              onDoubleTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Permission()));
              },
              child: const NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
            ),
            GestureDetector(
              onDoubleTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LocationScreen()));
              },
              child: const NavigationDestination(
                icon: Icon(Icons.route),
                label: 'Routes',
              ),
            ),
            GestureDetector(
              onDoubleTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()));
              },
              child: const NavigationDestination(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ),
          ],
        ),
      ),
    );
  }
}