import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'dart:async';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}
class _OTPScreenState extends State<OTPScreen> {
  OtpFieldController otpController = OtpFieldController();
  late Timer _timer;
  int _start = 60;
   bool _isButton=false;

  @override
  void initState() {
    super.initState();
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
     _isButton=false;

  }
  bool clock(){
    if(_start==0) {
      setState(() {
        _isButton=true;
      });
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('OTP screen'),),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cleaning_services),
        onPressed: () {
          //print("Floating button was pressed.");
          otpController.clear();
          // otpController.set(['2', '3', '5', '5', '7']);
          // otpController.setValue('3', 0);
          // otpController.setFocus(1);
        },
      ),

      body:Column(
      children: [
        const Padding(padding: EdgeInsets.all(20)),
        const Text('OTP Verification',
            style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.pink)),
        const Padding(padding: EdgeInsets.all(70)),
        const Text('We have sent an OTP code to phone number *** *** **99. '
            '\n\nEnter the code below:',
            style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black)),
        const Padding(padding: EdgeInsets.all(30)),
        Center(
        child: OTPTextField(
            controller: otpController,
            length: 5,
            width: MediaQuery
                .of(context)
                .size
                .width,
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldWidth: 45,
            fieldStyle: FieldStyle.box,
            outlineBorderRadius: 15,
            style: const TextStyle(fontSize: 17),
            onChanged: (pin) {
              //print("Changed: $pin");
            },
            onCompleted: (pin) {
              //print("Completed: $pin");
            }),
      ),

        const Padding(padding: EdgeInsets.all(10)),
         TextButton(onPressed:() => {if (clock()==false){null}} , child:const Text('Resend code',
          style: TextStyle(fontWeight: FontWeight.normal,
              fontSize: 15,
              fontStyle: FontStyle.italic,
              color: Colors.pink),
          textAlign: TextAlign.center,
        ), ),

        Text("$_start"),
    ],

      ),
    );
  }
}




