import 'package:flutter/material.dart';
import 'package:gradproj7/live.dart';
import 'package:gradproj7/location.dart';
import 'package:gradproj7/cards.dart';
import 'package:postgres/postgres.dart';

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
  final TextEditingController _passController = TextEditingController();
  late String _passErrorText = "";
  final TextEditingController _phoneController = TextEditingController();
  late String _phoneErrorText = "";
  final TextEditingController _confirmController = TextEditingController();
  late String _confirmErrorText = "";

  bool _validateConfirm(String value1, String value2) {
    if (value1.isEmpty) {
      setState(() {
        _confirmErrorText = 'required';
      });
      return false;
    } else if (value1.isNotEmpty && value1 != value2) {
      _confirmErrorText = 'does not equal the value in password field';
      return false;
    } else {
      return true;
    }
  }

  bool _validatePass(String value) {
    if (value.isEmpty) {
      setState(() {
        _passErrorText = 'Password is required';
      });
      return false;
    } else if (value.isNotEmpty && !isPassValid(value)) {
      setState(() {
        _passErrorText = 'Enter a valid password of minimum 8 characters Minimum eight characters, at least one letter, one number and one special character';
      });
      return false;
    } else {
      return true;
    }
  }

  bool isPassValid(String pass) {
    //Minimum eight characters, at least one letter, one number and one special character:
    return RegExp(
        r'^(?=.[A-Za-z])(?=.\d)(?=.[@$!%#?&])[A-Za-z\d@$!%*#?&]{8,}$')
        .hasMatch(pass);
  }

  bool _validatePhone(String value) {
    if (value.isEmpty) {
      setState(() {
        _phoneErrorText = 'Phone is required';
      });
      return false;
    } else if (value.isNotEmpty && !isPassValid(value)) {
      setState(() {
        _phoneErrorText = 'Enter a valid phone number';
      });
      return false;
    } else {
      return true;
    }
  }

  bool isPhoneValid(String phone) {
    //The numbers should start with a plus sign ( + )
    // It should be followed by Country code and National number.
    // It may contain white spaces or a hyphen ( – ).
    // the length of phone numbers may vary from 7 digits to 15 digits.
    return RegExp(r'07(78|77|79)\d{7}').hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 223, 218, 230),
        body: Column(
          children: [
            const TitleSection(name: 'Profile Settings',
            ),

            Expanded(
              child: Container(
                width: double.infinity,
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
                          TextFormField(
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'New name',
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
                          TextFormField(
                            controller: _phoneController,
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'New phone number',
                              labelStyle: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              errorText: _phoneErrorText,
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
                                return 'Enter your new phone number';
                              }
                              return null;
                            },
                          ),
                          // Password Field
                          TextFormField(
                            controller: _passController,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'Enter your new password',
                              labelStyle: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              errorText: _passErrorText,
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            obscureText: true, // Hides the password input
                          ),
                          // Confirm Password Field
                          TextFormField(
                            controller: _confirmController,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'Confirm your password',
                              labelStyle: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              errorText: _confirmErrorText,
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _passController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            obscureText: true, // Hides the password input
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

                          GestureDetector(
                            onTap: () {
                              showAlertDialog(context);
                            },

                            child: const Text("Log out",
                              style:
                              TextStyle(fontSize: 20,fontWeight:FontWeight.bold ,color:Colors.purple),),
                          ),

                          const SizedBox(height: 35),
                          Center(
                            child: ElevatedButton(
                              onPressed: () async{
                                if (_validatePass(_passController.text) == false ||
                                    _validatePhone(_phoneController.text) == false ||
                                    _validateConfirm(
                                        _confirmController.text, _passController.text) ==
                                        false) {
                                  _validatePass(_passController.text);
                                  _validatePhone(_phoneController.text);
                                  _validateConfirm(
                                      _confirmController.text, _passController.text);
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
                              child: const Text('Save changes'),
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
      padding: const EdgeInsets.all(25),
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