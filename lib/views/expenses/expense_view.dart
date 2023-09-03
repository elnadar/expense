import 'package:expense/models/expense.dart';
import 'package:expense/models/expenses_list.dart';
import 'package:flutter/material.dart';

class ExpenseView extends StatelessWidget {
  const ExpenseView({super.key, required this.expense});
  final Expense expense;

  _onDismess(DismissDirection direction) {
    if (direction == DismissDirection.endToStart) {
      ExpensesList().deleteExpense(expense);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: _onDismess,
      key: ValueKey(expense),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          child: Column(
            children: [
              Text(expense.title),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$${expense.amount.toStringAsFixed(2)}"),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (expense.category.icon != null)
                        Icon(expense.category.icon),
                      if (expense.category.icon == null)
                        const Icon(Icons.alarm),
                      const SizedBox(width: 6),
                      Text(expense.formatedDate)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
