import 'package:flutter/material.dart';
//import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:gradproj7/settings.dart';
import 'location.dart';
import 'package:iamport_webview_flutter/iamport_webview_flutter.dart'; // Use the iamport_webview_flutter package
import 'dart:io';

class Permission extends StatefulWidget {
  const Permission({super.key});

  @override
  State<Permission> createState() => _PermissionState();
}

class _PermissionState extends State<Permission> {
  String? _currentAddress;
  loc.LocationData? _currentPosition;
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  final loc.Location location = loc.Location();

  @override
  void initState() {
    super.initState();
    _handleLocationPermission();
    // Enable hybrid composition for Android
    print('=========================================');
    print('=======test==============================');
    print('=========================================');

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Permission'),
        ),
        backgroundColor: const Color.fromARGB(255, 223, 218, 230),
        body: Column(
          children: [
            Expanded(
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
                      children: [
                        GestureDetector(
                          onDoubleTap: () {
                            _handleLocationPermission();
                          },
                          child: Container(
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
                                hintText: 'Your location',
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 15)),
                        GestureDetector(
                          onDoubleTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LocationScreen()));
                          },
                          child: Container(
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
                                hintText: 'Where to ?',
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(20)),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('ADDRESS: ${_currentAddress ?? ""}'),
                        ),
                        // Add the WebView here
                        const SizedBox(
                          height: 400, // Set a height for the WebView
                          child: WebView(
                            initialUrl:
                                'assets/web/index.html', // Path to your HTML file
                            javascriptMode: JavascriptMode.unrestricted,
                          ),
                        ),
                      ],
                      //Here should be the Map
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

  Future<void> _handleLocationPermission() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        _showSnackBar(
            'Location services are disabled. Please enable the services');
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        _showSnackBar('Location permissions are denied');
        return;
      }
    }

    if (permissionGranted == loc.PermissionStatus.deniedForever) {
      _showSnackBar(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    _getCurrentPosition();
  }

  Future<void> _getCurrentPosition() async {
    try {
      _currentPosition = await location.getLocation();
      _getAddressFromLatLng();
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }

  Future<void> _getAddressFromLatLng() async {
    if (_currentPosition != null) {
      try {
        // Use a geocoding API to get the address from coordinates
        // This is a placeholder and should be replaced with actual geocoding code
        String address =
            "Lat: ${_currentPosition!.latitude}, Lon: ${_currentPosition!.longitude}";
        setState(() {
          _currentAddress = address;
        });
      } catch (e) {
        _showSnackBar('Error: $e');
      }
    }
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
