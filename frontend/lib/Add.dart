import 'package:flutter/material.dart';
import 'package:gradproj7/location.dart';
import 'package:gradproj7/settings.dart';
import 'package:u_credit_card/u_credit_card.dart';

import 'live.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Add Card Screen ",
      home: AddCardsScreen(),
    ),
  );
}
class AddCardsScreen extends StatefulWidget {
  const AddCardsScreen({super.key});

  @override
  State<AddCardsScreen> createState() => _AddCardsScreenState();
}

class _AddCardsScreenState extends State<AddCardsScreen> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  final name = TextEditingController();
  final cvv = TextEditingController();
  final exp = TextEditingController();
  final number= TextEditingController();
  final type = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 223, 218, 230),
        body: Column(
          children: [
            const TitleSection(name: 'New Payment'),
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

                child:   Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CreditCardUi(
                          cardHolderFullName: name.text,
                          cardNumber: number.text,
                          validThru: exp.text,
                          cvvNumber: cvv.text,
                        ),

                        const Padding(padding: EdgeInsets.all(5)),
                        TextFormField(
                          controller: name,
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Name of card holder',
                            labelStyle: TextStyle(
                                color: Colors.black, fontSize: 16),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 33, 216, 54)),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(3)),
                        TextFormField(
                          controller: number,
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Card Number',
                            labelStyle: TextStyle(
                                color: Colors.black, fontSize: 16),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 33, 216, 54)),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(3)),
                        TextFormField(
                          controller: exp,
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.datetime,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Expiry Date',
                            labelStyle: TextStyle(
                                color: Colors.black, fontSize: 16),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 33, 216, 54)),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(3)),
                        TextFormField(
                          controller: cvv,
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'CVV',
                            labelStyle: TextStyle(
                                color: Colors.black, fontSize: 16),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 33, 216, 54)),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(3)),
                        TextFormField(
                          controller: type,
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Credit card type',
                            labelStyle: TextStyle(
                                color: Colors.black, fontSize: 16),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 33, 216, 54)),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(3)),
                        ElevatedButton(
                          onPressed: () {
                            showAlertDialog(context);
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
                          child: const Text('Add'),
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
            builder: (context) => const AddCardsScreen()));},
  );
  Widget continueButton = TextButton(
    child: const Text("Yes"),
    onPressed:  () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Adding Card "),
    content: const Text("Are you sure you want to add this card ?"),
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