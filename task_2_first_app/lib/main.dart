import 'package:flutter/material.dart';
import 'package:task_2_first_app/screens/task2_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Task2Screen(),
    );
  }
}