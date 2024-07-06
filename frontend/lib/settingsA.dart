import 'package:flutter/material.dart';
import 'package:gradproj7/loginA.dart';
import 'package:gradproj7/settings.dart';
import 'api_handler.dart';
import 'cardsA.dart';
import 'liveA.dart';
import 'locationA.dart';
import 'models/model.dart';


class SettingsAScreen extends StatefulWidget {
  const SettingsAScreen({super.key});

  @override
  State<SettingsAScreen> createState() => _SettingsAScreenState();
}
class _SettingsAScreenState extends State<SettingsAScreen> {

  ApiHandler apiHandler = ApiHandler();
  late List<User> data =[];
  int index = 0 ;


  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  final TextEditingController _passController = TextEditingController();
  late String _passErrorText = "";
  final TextEditingController _phoneController = TextEditingController();
  late String _phoneErrorText = "";
  final TextEditingController _confirmController = TextEditingController();
  late String _confirmErrorText = "";


  void addUser() async{
    final user = User(
      userID: 0,
      phoneNumber: _phoneController.text,
      password: _passController.text,
    );
    await apiHandler.addUser(user: user);
  }

  void deleteUser(int userID) async{

    await apiHandler.deleteUser(userID: userID );
    setState(() {

    });
  }


  bool _validateConfirm(String value1, String value2) {
    if (value1.isEmpty) {
      setState(() {
        _confirmErrorText = 'مطلوب';
      });
      return false;
    } else if (value1.isNotEmpty && value1 != value2) {
      _confirmErrorText = 'ليس نفس كلمة السر';
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
    } else if (value.isNotEmpty && !isPhoneValid(value)) {
      setState(() {
        _phoneErrorText = 'ادخل رقم صحيح';
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
    return RegExp(r' 07(78|77|79)\d{7}').hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(title: const Text('Settings screen'),),
        backgroundColor: const Color.fromARGB(255, 223, 218, 230),
        body: Column(
          children: [
            const Align(alignment: Alignment.topRight,
            child:TitleSection(name: 'اعدادات الحساب',
            ),
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
                              labelText: 'اسم جديد',
                              labelStyle: TextStyle(
                                  color: Colors.black, fontSize: 16,
                              ),

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
                              labelText: 'رقم هاتف جديد',
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
                          // Password Field
                          TextFormField(
                            controller: _passController,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'ادخل كلمة سر جديدة',
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
                                return 'ادخل كلمة سر';
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
                              labelText: 'أكد كلمة السر',
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
                                return 'اكد كلمة السر';
                              }
                              if (value != _passController.text) {
                                return 'كلمات السر لا يتساوون';
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
                                      builder: (context) => const CardsAScreen()));
                            },
                            child:const Text("تعديل البطاقات",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold ),),),
                          const Padding(padding: EdgeInsets.all(10),),
                          GestureDetector(
                            onTap: () {
                              showAlertDialog2(context);
                            },
                            child:const Text("اللغة",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold ),),),
                          const Padding(padding: EdgeInsets.all(10),),
                          GestureDetector(
                            onTap: () {
                              showAlertDialog(context);
                              //deleteUser(data[index].userID);
                            },

                            child: const Text("حذف الحساب ",
                              style:
                              TextStyle(fontSize: 20,fontWeight:FontWeight.bold ,color:Colors.purple),),
                          ),
                          GestureDetector(
                            onTap: () {
                              showAlertDialog(context);
                            },

                            child: const Text("تسجيل الخروج",
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
                                else{
                                  addUser();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (
                                            context) => const LoginAScreen()),
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
                              child: const Text('حفظ التغيرات'),
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
                  textAlign: TextAlign.right,

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
    onPressed:  () {Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => const SettingsAScreen()));},
  );
  Widget continueButton = TextButton(
    child: const Text("نعم"),
    onPressed:  () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("تسجيل الخروج "),
    content: const Text("هل تريد تسجيل الخروج؟"),
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

showAlertDialog2(BuildContext context) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("لا"),
    onPressed:  () {Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => const SettingsAScreen()));},
  );
  Widget continueButton = TextButton(
    child: const Text("نعم"),
    onPressed:  () {Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => const SettingsScreen()));},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("تغير اللفة "),
    content: const Text("هل تريد تغير اللغة الى اللغة الانجليزية ؟"),
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

showAlertDialog3(BuildContext context) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("لا"),
    onPressed:  () {Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => const SettingsAScreen()));},
  );
  Widget continueButton = TextButton(
    child: const Text("نعم"),
    onPressed:  () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("حذف الحساب "),
    content: const Text("هل تريد حذف الحساب؟"),
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