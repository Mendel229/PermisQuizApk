import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quiz/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Remplacez MaterialApp par GetMaterialApp
      debugShowCheckedModeBanner: false,
      title: 'QCM App',
      home: Home(),
    );
  }
}
