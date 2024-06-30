import 'package:flutter/material.dart';
import 'package:gradproj7/settings.dart';
import 'live.dart';
import 'location.dart';


class AddCardsScreen extends StatefulWidget {
  const AddCardsScreen({super.key});

  @override
  State<AddCardsScreen> createState() => _AddCardsScreenState();
}

enum SingingCharacter { lafayette, jefferson }

class _AddCardsScreenState extends State<AddCardsScreen> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  final cvv = TextEditingController();
  final number= TextEditingController();
  late String _cvvErrorText = "";
  late String _numberErrorText = "";

  SingingCharacter? _character = SingingCharacter.lafayette;




  bool _validateCVV(String value) {
    if (value.isEmpty) {
      setState(() {
        _cvvErrorText = 'required';
      });
      return false;
    } else if (value.isNotEmpty && !isCvvValid(value)){
      _cvvErrorText = 'enter a valid cvv';
      return false;
    } else {
      return true;
    }
  }
  bool isCvvValid(String cvv) {
    return RegExp(
        r'^[0-9]{3,4}')
        .hasMatch(cvv);
  }

  bool _validateNumber(String value) {
    if (value.isEmpty) {
      setState(() {
        _numberErrorText = 'required';
      });
      return false;
    } else if (value.isNotEmpty && !isNumberValid(value)){
      _numberErrorText = 'enter a valid number';
      return false;
    } else {
      return true;
    }
  }
  bool isNumberValid(String number) {
    int sum = 0;
    bool isEven = false;
    int i=0;
    for (i = number.length - 1; i >= 0; i--) {
      int digit = int.parse(number[number.length - i - 1]);

      if (isEven) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }
      sum += digit;
      isEven = !isEven;
    }
    if(     sum % 10 == 0
    ){return true;}
    else{
      return false;
    }
  }

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
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Credit card type:",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold ),),
                        const Padding(padding: EdgeInsets.all(5)),

                        ListTile(
                          title: const Text('Amman Bus'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.lafayette,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),

                        ListTile(
                          title: const Text('Credit Card'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.jefferson,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
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
                        const Padding(padding: EdgeInsets.all(5)),

                        TextFormField(
                          controller: number,
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                          decoration:  InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: 'Card Number',
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            errorText: _numberErrorText,
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 33, 216, 54)),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your card number';
                            }
                            return null;
                          },
                        ),
                        const Padding(padding: EdgeInsets.all(5)),

                        TextFormField(
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
                        const Padding(padding: EdgeInsets.all(5)),

                        TextFormField(
                          controller: cvv,
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: 'CVV',
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            errorText: _cvvErrorText,
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 33, 216, 54)),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your cvv';
                            }
                            return null;
                          },
                        ),
                        const Padding(padding: EdgeInsets.all(20)),

                        Align( alignment: Alignment.bottomCenter,
                          child:ElevatedButton(
                            onPressed: () {
                              if (_validateCVV(_cvvErrorText) == false ||
                                  _validateNumber(_numberErrorText) == false) {
                                _validateCVV(_cvvErrorText);
                                _validateNumber(_numberErrorText);
                              }

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
                      fontWeight: FontWeight.bold, fontSize: 35,
                      color: Colors.black87
                  ),
                  textAlign: TextAlign.center,
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
