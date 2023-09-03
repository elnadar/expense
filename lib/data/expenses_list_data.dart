import 'package:expense/models/category.dart';
import 'package:expense/models/expenses_list.dart';
import 'package:hive/hive.dart';
import 'package:expense/models/expense.dart';

class ExpensesListData {
  final ExpensesList _expenesList = ExpensesList();

  static final ExpensesListData _instance = ExpensesListData._internal();
  ExpensesListData._internal();
  factory ExpensesListData() {
    return _instance;
  }

  Future<dynamic> deleteExpense(Expense expense) async {
    var box = await Hive.openBox<Expense>('Expense');
    final expenseKey = ExpensesList()
        .expensesMap
        .entries
        .firstWhere((element) => element.value == expense)
        .key;
    await box.delete(expenseKey);
    if (box.isOpen) {
      await box.close();
    }
    return expenseKey;
  }

  Future addExepnes(Expense expense) async {
    var box = await Hive.openBox<Expense>('Expense');
    await box.add(expense);
    if (box.isOpen) {
      await box.close();
    }
  }

  Future<ExpensesList> getExpensesMap() async {
    var box = await Hive.openBox<Expense>('Expense');

    _expenesList.expensesMap = box.toMap();
    if (box.isOpen) {
      await box.close();
    }
    return _expenesList;
  }
}

class ExpenseAdapter extends TypeAdapter<Expense> {
  @override
  final int typeId = 1; // Use a unique ID for your Expense class

  @override
  Expense read(BinaryReader reader) {
    final title = reader.read() as String;
    final amount = reader.read() as double;
    final date = DateTime.fromMillisecondsSinceEpoch(reader.read() as int);
    final category = reader.read() as Category;
    return Expense(
        title: title, amount: amount, date: date, category: category);
  }

  @override
  void write(BinaryWriter writer, Expense obj) {
    writer.write(obj.title);
    writer.write(obj.amount);
    writer.write(obj.date.millisecondsSinceEpoch);
    writer.write(obj.category);
  }
}
