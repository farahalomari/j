import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gradproj7/route.dart';
import 'package:gradproj7/settings.dart';
import 'package:gradproj7/signup.dart';
import 'package:geocoding/geocoding.dart';

import 'live.dart';

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
                                color: Colors.grey,
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
                          const SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey),
                            child: const TextField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),
                                hintText: 'Where to ?',
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),

                          const Divider(
                            height: 70,
                            color: Colors.grey,
                            thickness: 1,

                          ),
                          const Text('Saved places',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
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
                                    text: " Home",
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
                                    text: " Work",
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
                            padding: EdgeInsets.only(top: 0,bottom:10),
                            child: Text('Recent',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35,
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
                          //I have removed this part for now cause now we can go to a screen where we get user live location
                          /*
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MapScreen()));
                        },
                        child: const Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.double_arrow_rounded,
                            color: Colors.pink,
                            size: 40,
                          ),
                        ),
                      ),
*/
                        ],
                      )),
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
                        builder: (context) => const SignupScreen()));
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
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: const Center(child: Text('Map Screen')),
    );
  }
}

showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget cancelButton = TextButton(
    onPressed:() {Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => const LocationScreen()));},
    child: const Text("No"),
  );
  Widget continueButton = TextButton(
    child: const Text("Yes"),
    onPressed:  () {Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => const Permission()));},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Location "),
    content: const Text("Do you want to get your live location ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
