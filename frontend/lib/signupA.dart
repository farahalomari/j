import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'loginA.dart';
import 'otpA.dart';



class Signupa extends StatelessWidget {
  const Signupa({super.key});

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
      home: const SignupAScreen(),
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

class SignupAScreen extends StatefulWidget {
  const SignupAScreen({super.key});

  @override
  State<SignupAScreen> createState() => _SignupAScreenState();
}

class _SignupAScreenState extends State<SignupAScreen> {
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
        _confirmErrorText = 'مطلوب';
      });
      return false;
    } else if (value1.isNotEmpty && value1 != value2) {
      _confirmErrorText = 'لا يساوي كلمة السر';
      return false;
    } else {
      return true;
    }
  }

  bool _validatePass(String value) {
    if (value.isEmpty) {
      setState(() {
        _passErrorText = 'كلمة السر مطلوبة';
      });
      return false;
    } else if (value.isNotEmpty && !isPassValid(value)) {
      setState(() {
        _passErrorText = 'ادخل كلمة سر صحيحة';
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
        _phoneErrorText = 'رقم الهاتف مطلوب';
      });
      return false;
    } else if (value.isNotEmpty && !isPassValid(value)) {
      setState(() {
        _phoneErrorText = 'ادخل رقم هاتف صحيح';
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
    return RegExp(r' [+][0-9-]\s?{6, 15}[0-9]$').hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 223, 218, 230),
        body: Column(
          children: [
            const TitleSection(
              name: 'افتح حساب ',
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
                            labelText: 'رقم الهاتف',
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
                              return 'ادخل رقم هاتفك';
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
                            labelText: 'ادخل كلمة سر',
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
                              return 'ادخل كلمة السر';
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
                            labelText: 'أكد على كلمة السر',
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
                              return 'أكد كلمة السر';
                            }
                            if (value != _passController.text) {
                              return 'كلمات السر غير متساووين';
                            }
                            return null;
                          },
                          obscureText: true, // Hides the password input
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
                              } else {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const OTPAScreen()),
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
                            child: const Text('افتح حساب'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "يوجد لك حساب ؟ ",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: "تسجيل دخول",
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
                                          const LoginAScreen(),
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
