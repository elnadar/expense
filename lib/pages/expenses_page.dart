import 'package:expense/models/expenses_list.dart';
import 'package:expense/views/expenses/add_expense_view.dart';
import 'package:expense/views/expenses/expenses_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses Tracker"),
      ),
      floatingActionButton: const AddExpenseView(),
      body: Column(
        children: [
          const Text("The chart"),
          Expanded(
              child: ChangeNotifierProvider(
                  create: (context) => ExpensesList()..getExpenses(),
                  child: const ExpensesListView())),
        ],
      ),
    );
  }
}
