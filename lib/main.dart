import 'package:flutter/material.dart';
import 'package:post_api/view/Sing%20UP%20Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SinUpScreen(),
    );
  }
}
