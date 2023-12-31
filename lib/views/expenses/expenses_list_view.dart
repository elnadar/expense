import 'package:expense/models/expenses_list.dart';
import 'package:expense/views/expenses/expense_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesListView extends StatelessWidget {
  const ExpensesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesList>(builder: (context, value, child) {
      if (value.isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (value.expensesList.isNotEmpty) {
        return ListView.separated(
          itemCount: value.expensesList.length,
          itemBuilder: (context, index) =>
              ExpenseView(expense: value.expensesList[index]),
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              indent: 20,
              height: 1,
            );
          },
        );
      } else {
        return const Center(child: Text("No Data"));
      }
    });
  }
}
