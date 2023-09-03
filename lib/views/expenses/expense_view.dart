import 'package:expense/models/expense.dart';
import 'package:expense/models/expenses_list.dart';
import 'package:flutter/material.dart';

class ExpenseView extends StatefulWidget {
  const ExpenseView({super.key, required this.expense});
  final Expense expense;

  @override
  State<ExpenseView> createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpenseView> {
  _onDismess(DismissDirection direction) {
    ExpensesList().deleteExpense(widget.expense);
  }

  Future<bool> _confiemDismiss(DismissDirection direction) async {
    // You can show a confirmation dialog or implement custom logic here.
    // Return true to confirm the dismissal, or false to reject it.
    bool shouldDismiss = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Do you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm dismissal
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Reject dismissal
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
    return shouldDismiss;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: _onDismess,
      confirmDismiss: _confiemDismiss,
      key: ValueKey(widget.expense),
      child: ExpenesTile(expense: widget.expense),
    );
  }
}

class ExpenesTile extends StatelessWidget {
  const ExpenesTile({
    super.key,
    required this.expense,
  });

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    if (expense.category.icon == null) const Icon(Icons.alarm),
                    const SizedBox(width: 6),
                    Text(expense.formatedDate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
