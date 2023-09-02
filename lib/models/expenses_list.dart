import 'package:expense/data/expenses_list_data.dart';
import 'package:expense/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends ChangeNotifier {
  static final ExpensesList _instance = ExpensesList._internal();
  ExpensesList._internal();
  factory ExpensesList() {
    return _instance;
  }
  List<Expense> expenses = [];
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await ExpensesListData().addExepnes(expense);
  }

  Future<List<Expense>> getExpenses() async {
    isLoading = true;
    await ExpensesListData().getExpensesList();
    isLoading = false;
    return expenses;
  }
}
