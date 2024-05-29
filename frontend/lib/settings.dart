import 'package:flutter/material.dart';
import 'package:gradproj7/signup.dart';
import 'package:gradproj7/location.dart';
import 'package:gradproj7/cards.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Settings screen ",
      home: SettingsScreen(),
    ),
  );
}
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {
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
            const TitleSection(name: 'Profile Settings',
            ),
            const Padding(padding:EdgeInsets.all(20)),
            const Icon(Icons.account_circle,size:80),
            Expanded(
              child: Container(
                width: double.infinity,
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
                          const Text(
                            'Name',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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
                                  Icons.auto_fix_high,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,

                            ),
                          ),

                          const SizedBox(height: 15),
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
                                  Icons.auto_fix_high,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Phone number ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,

                            ),
                          ),

                          const SizedBox(height: 15),
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
                                  Icons.auto_fix_high,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(10),),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => const CardsScreen()));
                        },
                         child:const Text("Manage Cards",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold ),),),
                          const Padding(padding: EdgeInsets.all(10),),
                          const Text("Language",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold ),),
                          const Padding(padding: EdgeInsets.all(10),),
                          const Text("Share the app",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold ),),
                          const Padding(padding: EdgeInsets.all(10),),
                          GestureDetector(
                            onTap: () {
                              showAlertDialog(context);
                            },

                          child: const Text("Log out",
                            style:
                            TextStyle(fontSize: 20,fontWeight:FontWeight.bold ,color:Colors.pink),),
                ),

                          const SizedBox(height: 35),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.pink,
                            ),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  ' Save Changes',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),

                                ),

                              ),
                            ),
                          ),
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
              child:const NavigationDestination(
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
              child:const NavigationDestination(
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
              child:const NavigationDestination(
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

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30,
                      color: Colors.black87
                  ),

                ),
              ],
            ),
          ),
          /*3*/
        ],
      ),
    );
  }
}
showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed:  () {Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => const SettingsScreen()));},
  );
  Widget continueButton = TextButton(
    child: const Text("Continue"),
    onPressed:  () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Logging out "),
    content: const Text("Are you sure you want to log out ?"),
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