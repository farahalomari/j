import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'bus_routes.dart';
import 'settingsA.dart';
import 'destinationA.dart';
import 'liveA.dart';



class LocationAScreen extends StatefulWidget {
  const LocationAScreen({super.key});

  @override
  State<LocationAScreen> createState() => _LocationAScreenState();
}

class _LocationAScreenState extends State<LocationAScreen> {
  String? _currentAddress;
  Position? _currentPosition;
  final TextEditingController _destinationController = TextEditingController();
  String ? _output;
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  var node = FocusNode();



  @override
  void initState() {
    super.initState();
    _getCurrentPosition();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(title: const Text('Location Screen'),),
        backgroundColor: const Color.fromARGB(255, 223, 218, 230),

        body:
    KeyboardListener(
    focusNode: node,
    onKeyEvent: (event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.enter) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => const DestinationA()));
    }
    },
    child:Column(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          GestureDetector( onDoubleTap: () {
                            showAlertDialog(context);
                          },
                            child:Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
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
                          const SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            child:   TextField(
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

                          const Divider(
                            height: 70,
                            color: Colors.grey,
                            thickness: 1,

                          ),
                          const Text('الاماكن المحفوظة ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.purple)),
                          const Padding(
                            padding: EdgeInsets.only(top: 0,bottom:30),
                          ),
                          RichText(
                            text: const TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(Icons.home, size: 30),
                                ),
                                TextSpan(
                                    text: " البيت",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black)),
                              ],
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 10,bottom:0),
                          ),
                          const Divider(
                            height: 30,
                            color: Colors.grey,
                            thickness: 1,

                          ),
                          RichText(
                            text: const TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(Icons.work, size: 30),
                                ),
                                TextSpan(
                                    text: " العمل",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 70,
                            color: Colors.grey,
                            thickness: 5,

                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 0,bottom:1),
                            child: Text('سابقا',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.purple)),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Icon(
                              Icons.access_time_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Icon(
                              Icons.access_time_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Icon(
                              Icons.access_time_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child:GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Bus()));
                              },
                              child: const Icon(
                                Icons.alt_route_sharp,
                                color: Colors.pink,
                                size: 40,
                              ),
                            ),
                          ),


                        ],
                      )),
                              ),
                ),
              ),
        ],
            ),

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


class MapAScreen extends StatelessWidget {
  const MapAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: const Center(child: Text('Map Screen')),
    );
  }
}


