import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'settingsA.dart';
import 'liveA.dart';
import 'locationA.dart';





class DestinationA extends StatefulWidget {
  const DestinationA({super.key});

  @override
  State<DestinationA> createState() => _DestinationAState();
}

class _DestinationAState extends State<DestinationA> {
  final TextEditingController _destinationController = TextEditingController();
  String ? _output;
  String? _currentAddress;
  Position? _currentPosition;
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;



  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
    locationFromAddress(_destinationController.text)
        .then((locations) {
      var output = 'No results found.';
      if (locations.isNotEmpty) {
        output = locations[0].toString();
      }
      setState(() {
        _output = output;
      });
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Destination'),),
        backgroundColor: const Color.fromARGB(255, 223, 218, 230),
        body: Column(children: [
          GestureDetector( onDoubleTap: () {
            _getCurrentPosition();
          },
            child:Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              child:  TextField(
                style: const TextStyle(color: Colors.black),
                readOnly: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.location_searching,
                    color: Colors.blue,
                  ),
                  hintText: 'موقعك: ${_currentAddress ?? ""}',
                  hintStyle: const TextStyle(color: Colors.black),
                ),

              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top:5)),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child:  TextField(
              controller: _destinationController,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
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

          //Here should be the Map

          const Padding(padding: EdgeInsets.all(290)),
          Align(  alignment: Alignment.bottomCenter,
            child:ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MapAScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                backgroundColor: Colors.pink,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 16),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              child: const Text('تأكيد'),
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
