import 'package:flutter/material.dart';
import 'settingsA.dart';
import 'liveA.dart';
import 'locationA.dart';


class AddCardsAScreen extends StatefulWidget {
  const AddCardsAScreen({super.key});

  @override
  State<AddCardsAScreen> createState() => _AddCardsAScreenState();
}
enum SingingCharacter { lafayette, jefferson }

class _AddCardsAScreenState extends State<AddCardsAScreen> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  final cvv = TextEditingController();
  final exp = TextEditingController();
  final number= TextEditingController();

  late String _cvvErrorText = "";
  late String _numberErrorText = "";

   SingingCharacter? _character = SingingCharacter.lafayette;




  bool _validateCVV(String value) {
    if (value.isEmpty) {
      setState(() {
        _cvvErrorText = 'مطلوب';
      });
      return false;
    } else if (value.isNotEmpty && !isCvvValid(value)){
      _cvvErrorText = 'ادخل cvv صحيح';
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
        _numberErrorText = 'مطلوب';
      });
      return false;
    } else if (value.isNotEmpty && !isNumberValid(value)){
      _numberErrorText = 'ادخل رقم صحيح';
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
        //appBar: AppBar(title: const Text('Add Card Screen'),),
        backgroundColor: const Color.fromARGB(255, 223, 218, 230),
        body: Column(
          children: [
            const TitleSection(name: 'بطاقة جديدة'),
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
                      const Text("نوع البطاقة:",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold ),),
                    const Padding(padding: EdgeInsets.all(5)),

                    ListTile(
                      title: const Text('باص عمان'),
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
                      title: const Text('بطاقة ائتمانية'),
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

                        const Padding(padding: EdgeInsets.all(5)),
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'اسم مستخدم البطاقة',
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
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'رقم البطاقة',
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'ادخل رقم صحيح';
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
                            labelText: 'تاريخ انتهاء البطاقة',
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'ادخل cvv صحيح';
                            }
                            return null;
                          },
                        ),

                        const Padding(padding: EdgeInsets.all(20)),
                        Align(alignment: Alignment.bottomCenter,
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
                          child: const Text('اضافة'),
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
