import 'package:expense/data/expenses_list_data.dart';
import 'package:expense/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'categories_list_data.dart';

mixin DataGetter {
  static void initAdaptors() {
    Hive.registerAdapter<Category>(CategoryAdapter());
    Hive.registerAdapter<Expense>(ExpenseAdapter());
  }

  static Future<void> init() async {
    await CategoriesListData().initCategoriesList();
    await ExpensesListData().getExpensesMap();
  }
}
