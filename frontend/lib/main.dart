import 'package:flutter/material.dart';
import 'package:gradproj7/live.dart';
import 'package:gradproj7/signup.dart';
import 'package:gradproj7/location.dart';

//splash screen
void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Jawla',
      home: Permission(),
    );
  }
}
