import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'settingsA.dart';

import 'locationA.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PermissionA ",
      home: PermissionA(),
    ),
  );
}



class PermissionA extends StatefulWidget {
  const PermissionA({super.key});

  @override
  State<PermissionA> createState() => _PermissionAState();
}

class _PermissionAState extends State<PermissionA> {
  String? _currentAddress;
  Position? _currentPosition;
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 223, 218, 230),
        body: Column(children: [Expanded(
        child: Container(
        width: double.infinity,
        alignment: Alignment.topLeft,
        decoration: const BoxDecoration(
        color: Color.fromARGB(255, 223, 218, 230),
        borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
        ),
        ),
        child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
        child: Column(
        children:[
          GestureDetector( onDoubleTap: () {
            _getCurrentPosition();
          },
            child:Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: const TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.location_searching,
                    color: Colors.blue,
                  ),
                  hintText:'موقعك الحالي',
                  hintStyle: TextStyle(color: Colors.black),
                ),

              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top:15)),
          GestureDetector( onDoubleTap: () {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => const LocationAScreen()));
          },
            child:Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: const TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.location_on_sharp,
                    color: Colors.red,
                  ),
                  hintText: 'الى اين تريد الذهاب؟',
                  hintStyle: TextStyle(color: Colors.black),
                ),

              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(20)),
          Align(alignment: Alignment.topRight,
            child:Text('موقعك :${_currentAddress ?? ""}'),
          ),

          //Here should be the Map

        ],
        ),
    ),
        ),
        ),
        ),
        ],
    ),


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
                        builder: (context) => const PermissionA()));
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
                        builder: (context) => const LocationAScreen()));
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
                        builder: (context) => const SettingsAScreen()));
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

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showSnackBar(
          'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showSnackBar('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _showSnackBar(
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _getAddressFromLatLng(_currentPosition!);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = "${place.locality},${place.country},${place.street}";
      });
    } catch (e) {
      //print(e);
    }
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)));
    }
  }
}
