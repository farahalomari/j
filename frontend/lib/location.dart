import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gradproj7/route.dart';
import 'package:gradproj7/settings.dart';
import 'package:gradproj7/signup.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Location Screen ",
      home: LocationScreen(),
    ),
  );
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  String? _currentAddress;
  Position? _currentPosition;
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [

            Expanded(

              child: Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                decoration: const BoxDecoration(
                  color: Colors.white,
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

                          Text('ADDRESS: ${_currentAddress ?? ""}',
                            style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight:FontWeight.bold,fontStyle: FontStyle.italic),
                          ),
                          const Padding(padding: EdgeInsets.all(10)),
                          ElevatedButton(onPressed: _getCurrentPosition,style: ElevatedButton.styleFrom(
                            shape:RoundedRectangleBorder (borderRadius: BorderRadius.circular(20)),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,color:Colors.white,fontSize: 15),),
                              child:
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(Icons.location_on, color: Colors.pink,),
                                    ),
                                    TextSpan(
                                        text: " Click here to find your current location ",
                                    ),
                                  ],
                                ),
                              ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black,
                            ),
                            child: const TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.location_searching,
                                  color: Colors.pink,
                                ),
                                hintText: 'Your location',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black
                            ),
                            child: const TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.location_on,
                                  color: Colors.pink,
                                ),
                                hintText: 'Where to ?',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text('Saved places',
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                  color: Colors.pink)
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 5),),
                          RichText(
                            text: const TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(Icons.home, size: 30),
                                ),
                                TextSpan(
                                  text: " Home",style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black)
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 40),),
                          RichText(
                            text: const TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(Icons.work, size: 30),
                                ),
                                TextSpan(
                                    text: " Work",style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black)
                                ),
                              ],
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text('Recent',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 35,
                                    color: Colors.pink)
                            ),
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
                            padding: EdgeInsets.only(top: 50),
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => const MapScreen()));
                            },
                          child: const Align(
                            alignment: Alignment.bottomRight,
                          child:Icon(
                                    Icons.double_arrow_rounded,
                                    color: Colors.pink,
                                    size: 40,
                          ),

                                  ),),
                        ],
                      )
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
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => const SignupScreen()));
              },
              child: const NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
            ),
            GestureDetector(
              onDoubleTap: () {
                Navigator.push(context,
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
                Navigator.push(context,
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

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
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
      List <Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = "${place.locality},${place.country},${place.street}";
      });
    } catch (e) {
      print(e);
    }
  }

}
