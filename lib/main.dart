import 'package:flutter/material.dart';
import 'package:http_example/screen.dart';

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
      title: 'Http Example',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const HomeScreen(),
    );
  }
}
