import 'package:flutter/material.dart';
import 'screens/expense_list_screen.dart';

void main() => runApp(const ExpenseTrackerApp());

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      home: ExpenseListScreen(),
    );
  }
}