import 'package:expense/shared/move_content_for_keyboard.dart';
import 'package:expense/views/expenses/new_expense_form_view.dart';
import 'package:flutter/material.dart';

class AddExpenseView extends StatefulWidget {
  const AddExpenseView({
    super.key,
  });

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  _openModal() => MediaQuery.of(context).size.width < 600
      ? showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) =>
              const MoveContentForKeyboard(child: NewExpenseForm()),
        )
      : showDialog(
          context: context,
          builder: (context) => const Dialog(
                child: SizedBox(
                  width: 600,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: NewExpenseForm(),
                  ),
                ),
              ));

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _openModal,
      child: const Icon(Icons.add),
    );
  }
}
