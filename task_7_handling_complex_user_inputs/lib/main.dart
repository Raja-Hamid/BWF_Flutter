import 'package:flutter/material.dart';
import 'package:task_7_handling_complex_user_inputs/screens/main_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advanced User Input App',
      home: MainScreen(),
    );
  }
}
