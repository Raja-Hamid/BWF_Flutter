import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/components/expense.dart';
import 'add_expense_screen.dart';
import 'expense_details_screen.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  final List<Expense> _userExpenses = [];
  String _selectedFilter = 'All';

  void _startAddNewExpense(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return const AddExpenseScreen();
      }),
    ).then((result) {
      if (result != null && result is Expense) {
        setState(() {
          _userExpenses.add(result);
        });
      }
    });
  }

  void _viewExpenseDetails(Expense expense) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return ExpenseDetailsScreen(expense: expense);
      }),
    ).then((result) {
      if (result != null) {
        if (result == 'delete') {
          setState(() {
            _userExpenses.remove(expense);
          });
        } else if (result is Expense) {
          setState(() {
            final index = _userExpenses.indexOf(expense);
            if (index != -1) {
              _userExpenses[index] = result;
            }
          });
        }
      }
    });
  }

  double get _totalAmount {
    return _userExpenses.fold(0.0, (sum, item) => sum + item.amount);
  }

  List<Expense> get _filteredExpenses {
    if (_selectedFilter == 'All') {
      return _userExpenses;
    } else {
      return _userExpenses
          .where((expense) => expense.category == _selectedFilter)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Expense Tracker',
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => _startAddNewExpense(context),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total: \$${_totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: _selectedFilter,
                  items: ['All', 'Food', 'Transport', 'Entertainment']
                      .map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedFilter = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredExpenses.length,
              itemBuilder: (ctx, index) {
                final expense = _filteredExpenses[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      expense.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            '\$${expense.amount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          expense.date.toLocal().toString().split(' ')[0],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => _viewExpenseDetails(expense),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
