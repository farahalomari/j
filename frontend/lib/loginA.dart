import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'api_handler.dart';
import 'models/model.dart';
import 'signupA.dart';

import 'liveA.dart';
import 'otpA.dart';






class LoginAScreen extends StatefulWidget {
  const LoginAScreen({super.key});



  @override
  State<LoginAScreen> createState() => _LoginAScreenState();
}

class _LoginAScreenState extends State<LoginAScreen> {

  late List<User> data =[];
  ApiHandler apiHandler = ApiHandler();
  int index=0;

  @override
  void initState() {
    index+=1;
    getData();
    super.initState();
  }



  void getData () async{
    data = await apiHandler.getUserData();
    setState(() {

    });
  }


  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  final TextEditingController _passController = TextEditingController();
  late String _passErrorText = "";
  final TextEditingController _phoneController = TextEditingController();
  late  String _phoneErrorText = "";

  bool _validatePass(String value) {
    if (value.isEmpty) {
      setState(() {
        _passErrorText = 'كلمة السر مطلوبة';
      });
      return false;
    }
    else {
      return true;
    }
  }

  bool _validatePhone(String value) {
    if (value.isEmpty) {
      setState(() {
        _phoneErrorText = 'رقم الهاتف مطلوب';
      });
      return false;
    }
    else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Login Screen'),),
        backgroundColor: const Color.fromARGB(255, 223, 218, 230),
        body: Column(
          children: [
            Padding(padding: const EdgeInsets.only(top:60,bottom:40),
              child: RichText(
                text:  const TextSpan(
                  children: [

                    TextSpan(
                      text: " أهلا بك ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontStyle: FontStyle.italic,
                          color: Colors.black),

                    ),
                    TextSpan(
                        text: " بجولة",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontStyle: FontStyle.italic,
                            color: Colors.pink)),
                  ],
                ),
              ),
            ),
            Expanded(
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
                            return 'ادخل رقم الهاتف';
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
                          labelText: ' كلمة السر',
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OTPAScreen()));
                        },
                        child: const Text(
                          'لا تتذكر كلمة السر ؟',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 35),
                      Padding(padding: const EdgeInsets.only(top:50,bottom:15),
                        child:Center(
                          child: ElevatedButton(
                            onPressed: () async{
                              if (_validatePass(_passController.text) == false ||
                                  _validatePhone(_phoneController.text) == false ){
                                _validatePass(_passController.text);
                                _validatePhone(_phoneController.text);
                              }  else {
                                if(data[index].phoneNumber==_phoneController.text && data[index].password==_passController.text) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (
                                            context) => const PermissionA()),
                                  );
                                }
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
                            child: const Text('تسجيل دخول'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "لا يوجد لك حساب؟ ",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: "افتح حساب",
                                style: const TextStyle(
                                  color: Colors.purple,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const SignupAScreen(),
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
          ],
        ),
      ),
    );
  }
}

