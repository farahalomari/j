import 'package:flutter/material.dart';
import 'package:gradproj7/login.dart';
import 'package:gradproj7/otp.dart';
import 'package:flutter/gestures.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:postgres/postgres.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
// Open the database and store the reference.

  final database = openDatabase(

    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.

    join(await getDatabasesPath(), 'user.db'),

    version: 1,

  );

  Future<void> insertUser(User user) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the user into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  var fido = User(
    id: 1,
    phoneNumber: '123',
  );

  await insertUser(fido);

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.purple),
          ),
        ),
      ),
      home: const SignupScreen(),
    );
  }
}

// class TextSection extends StatelessWidget {
//   const TextSection({
//     super.key,
//     required this.description,
//   });

//   final String description;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10),
//       child: Text(
//         description,
//         softWrap: true,
//         style: const TextStyle(
//             fontSize: 20,
//             //color: Color.fromRGBO(164, 0, 82, 10),
//             color: Color.fromARGB(255, 16, 3, 201),
//             fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// } //text



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});



  @override
  State<SignupScreen> createState() => _SignupScreenState();

}

class _SignupScreenState extends State<SignupScreen> {

String num= _phoneController.text;


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
        _passErrorText = 'Enter a valid password, must be at least 8 characters long and include at least one letter, one number, and one special character';
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
            const TitleSection(
              name: 'Sign up to Jawla',
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

                          controller: _phoneController,
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: 'Phone number',
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
                              return 'Enter your phone number';
                            }
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
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 35),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_validatePass(_passErrorText) == false ||
                                  _validatePass(_phoneErrorText) == false ||
                                  _validateConfirm(
                                          _confirmErrorText, _passErrorText) ==
                                      false) {
                                _validatePass(_passErrorText);
                                _validatePhone(_phoneErrorText);
                                _validateConfirm(
                                    _confirmErrorText, _passErrorText);
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const OTPScreen()),
                                );
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
                            child: const Text('Sign up'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: "Log in",
                                  style: const TextStyle(
                                    color: Colors.purple,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
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
      padding: const EdgeInsets.fromLTRB(32, 70, 32, 16),
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


class User {
  final int id;
  final String phoneNumber;


  User({
    required this.id,
    required this.phoneNumber,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'phone Number': phoneNumber,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $phoneNumber}';
  }
}