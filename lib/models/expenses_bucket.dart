import 'package:expense/models/models.dart';
import 'package:flutter/material.dart';

class ExpensesBucket extends ChangeNotifier {
  final Map<Category, List<Expense>> _expensesByCategory = {};
  static final ExpensesBucket _instance = ExpensesBucket._internal();
  ExpensesBucket._internal();
  factory ExpensesBucket() {
    return _instance;
  }

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  toggleIsLoading() {
    isLoading = !isLoading;
  }

  getData() {
    toggleIsLoading();
    final categoriesList = CategoriesList().categories.values;
    final expensesList = ExpensesList().expensesList;
    for (Category cat in categoriesList) {
      _expensesByCategory[cat] =
          expensesList.where((element) => element.category == cat).toList();
    }
    toggleIsLoading();
    return _expensesByCategory;
  }
}
