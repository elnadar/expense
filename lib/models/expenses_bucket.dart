import 'package:expense/models/models.dart';
import 'package:flutter/material.dart';

class ExpensesBucket extends ChangeNotifier {
  static final ExpensesBucket _instance = ExpensesBucket._internal();
  ExpensesBucket._internal();
  factory ExpensesBucket() {
    return _instance;
  }

  final Map<Category, List<Expense>> _expensesByCategory = {};
  Map<Category, List<Expense>> get expensesByCategory => _expensesByCategory;

  final Map<Category, double> _expensesTotals = {};
  Map<Category, double> get expensesTotals => _expensesTotals;

  double _total = 0;
  double get total => _total;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  getData() {
    _isLoading = true;

    _getExpensesByCategory();
    _getTotalExpensesAmount();
    _getExpensesTotalsByCategory();
    _isLoading = false;

    return _expensesByCategory;
  }

  void _getTotalExpensesAmount() {
    final expensesList = ExpensesList().expensesList;

    double t = 0;
    for (final expense in expensesList) {
      t += expense.amount;
    }
    _total = t;
  }

  _getExpensesByCategory() {
    final categoriesList = CategoriesList().categories.values;
    final expensesList = ExpensesList().expensesList;
    for (Category cat in categoriesList) {
      _expensesByCategory[cat] = expensesList
          .where((element) => element.category.name == cat.name)
          .toList();
    }
    return _expensesByCategory;
  }

  _getExpensesTotalsByCategory() {
    for (Category cat in _expensesByCategory.keys) {
      _expensesTotals[cat] = _expensesByCategory[cat]!
          .map((expense) => expense.amount)
          .fold(0, (a, b) => a + b);
    }
  }
}
