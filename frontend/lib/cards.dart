import 'package:flutter/material.dart';
import 'package:gradproj7/location.dart';
import 'package:gradproj7/settings.dart';
import 'package:u_credit_card/u_credit_card.dart';
import 'package:gradproj7/live.dart';

import 'Add.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Card Screen ",
      home: CardsScreen(),
    ),
  );
}
class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 223, 218, 230),
        body: Column(
          children: [
            const TitleSection(name: 'Your cards'),
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

                child:  Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CreditCardUi(
                          cardHolderFullName: 'John Doe',
                          cardNumber: '1234567812345678',
                          validThru: '10/24',
                          enableFlipping: true,
                          topLeftColor: Colors.blue,
                        ),

                        const Padding(padding: EdgeInsets.all(20.0),),
                        const Text('Recent Transactions',style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold )),

                        const Padding(padding: EdgeInsets.all(80.0),),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddCardsScreen()));
                            },
                            child:const Text('Add Card',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold ))),
                        const Padding(padding: EdgeInsets.all(10.0),),
                        GestureDetector(
                          onTap: () {
                            showAlertDialog(context);
                          },

                          child: const Text("Delete Card",
                            style:
                            TextStyle(fontSize: 20,fontWeight:FontWeight.bold ,color:Colors.pink),),
                        ),
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
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => const Permission()));
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
            builder: (context) => const CardsScreen()));},
  );
  Widget continueButton = TextButton(
    child: const Text("Continue"),
    onPressed:  () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Deleting card "),
    content: const Text("Are you sure you want to delete this card ?"),
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