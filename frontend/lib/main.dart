import 'package:flutter/material.dart';
import 'package:gradproj7/live.dart';
//import 'package:gradproj7/signup.dart';

//import 'live.dart';

//splash screen
void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jawla',
      home:  Permission(),
      //dsds Permission
    );
  }
}
class dsds extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
 return _dsdsstate();
  }
}
class _dsdsstate extends State<dsds>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(child:Text('Test')),
   );
  }

}