import 'package:flutter/material.dart';
import 'settingsA.dart';
import 'package:u_credit_card/u_credit_card.dart';
import 'addA.dart';
import 'liveA.dart';
import 'locationA.dart';


class CardsAScreen extends StatefulWidget {
  const CardsAScreen({super.key});

  @override
  State<CardsAScreen> createState() => _CardsAScreenState();
}

class _CardsAScreenState extends State<CardsAScreen> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Card Screen'),),
        backgroundColor: const Color.fromARGB(255, 223, 218, 230),
        body: Column(
          children: [
            const TitleSection(name: 'بطاقاتك'),
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
                        const Text('تحويلات سابقة',style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold )),

                        const Padding(padding: EdgeInsets.all(80.0),),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddCardsAScreen()));
                            },
                            child:const Text('اضف بطاقة',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold ))),
                        const Padding(padding: EdgeInsets.all(10.0),),
                        GestureDetector(
                          onTap: () {
                            showAlertDialog(context);
                          },

                          child: const Text("مسح بطاقة",
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
                        builder: (context) => const PermissionA()));
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
                        builder: (context) => const LocationAScreen()));
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
                        builder: (context) => const SettingsAScreen()));
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
    child: const Text("لا"),
    onPressed: () {
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => const CardsAScreen()));
    },
  );
  Widget continueButton = TextButton(
    child: const Text("نعم"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("مسح البطاقة "),
    content: const Text("هل تريد مسح البطاقة؟"),
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