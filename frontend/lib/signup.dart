import 'package:flutter/material.dart';
import 'package:gradproj7/location.dart';
import 'package:gradproj7/login.dart';
import 'package:gradproj7/otp.dart';
import 'package:gradproj7/settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sign up screen ",
      home: SignupScreen(),
    ),
  );
}

class TextSection extends StatelessWidget {
  const TextSection({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        description,
        softWrap: true,
        style: const TextStyle(
            fontSize: 20,
            //color: Color.fromRGBO(164, 0, 82, 10),
            color: Colors.black,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
        _passErrorText = 'Enter a valid password';
      });
      return false;
    } else {
      return true;
    }
  }

  bool isPassValid(String pass) {
    //Minimum eight characters, at least one letter, one number and one special character:
    return RegExp(
            r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$')
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
    return RegExp(r' [+][0-9\-]\s?{6, 15}[0-9]$').hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const TitleSection(
              name: 'Sign up to Jawla',
            ),
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
                      TextFormField(
                        controller: _phoneController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Enter your phone number',
                          labelStyle: const TextStyle(color: Colors.black),
                          errorText: _phoneErrorText,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          // Add more validation logic if needed
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Password Field
                      TextFormField(
                        controller: _passController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Enter your password',
                          labelStyle: const TextStyle(color: Colors.black),
                          errorText: _passErrorText,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          // Add more validation logic if needed
                          return null;
                        },
                        obscureText: true, // Hides the password input
                      ),
                      const SizedBox(height: 16),
                      // Confirm Password Field
                      TextFormField(
                        controller: _confirmController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Confirm your password',
                          labelStyle: const TextStyle(color: Colors.black),
                          errorText: _confirmErrorText,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
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
                      const SizedBox(height: 35),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => {
                            if (_validatePass(_passErrorText) == false &&
                                _validatePass(_phoneErrorText) == false &&
                                _validateConfirm(
                                        _confirmErrorText, _passErrorText) ==
                                    false)
                              {
                                _validatePass(_passErrorText),
                                _validatePhone(_phoneErrorText),
                                _validateConfirm(
                                    _confirmErrorText, _passErrorText)
                              }
                            else
                              {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OTPScreen())),
                              }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: Colors.pink,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          child: const Text('Sign up'),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("Already have an account?",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const TextSection(
                          description: "Log-in !",
                        ),
                      ),
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
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black87),
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
