import 'package:expense/models/categories_list.dart';
import 'package:expense/models/expenses_list.dart';
import 'package:expense/models/models.dart';
import 'package:expense/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewExpenseForm extends StatefulWidget {
  const NewExpenseForm({
    super.key,
  });

  @override
  State<NewExpenseForm> createState() => _NewExpenseFormState();
}

class _NewExpenseFormState extends State<NewExpenseForm> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;
  late final TextEditingController _dateController;
  late final TextEditingController _categoryController;
  late final CategoriesList _categoriesList;
  bool _isCategoryValid = true;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController();
    _amountController = TextEditingController();
    _categoryController = TextEditingController();
    _dateController =
        TextEditingController(text: dateFormater.format(DateTime.now()));
    _categoriesList = CategoriesList()..getData();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  _showDatePicker() async {
    final now = DateTime.now();
    var newDate = await showDatePicker(
        context: context,
        initialDate: dateFormater.parse(_dateController.text),
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: now);
    if (newDate != null) _dateController.text = dateFormater.format(newDate);
  }

  _validateCategory() {
    if (_categoryController.text.isEmpty) {
      _isCategoryValid = false;
    } else {
      _isCategoryValid = true;
    }
    setState(() {});
  }

  _submitForm() {
    _validateCategory();
    if (_formKey.currentState!.validate() && _isCategoryValid) {
      ExpensesList().addExpense(Expense(
          title: _titleController.text.isEmpty
              ? "This Expense has no title"
              : _titleController.text,
          amount: double.parse(_amountController.text),
          date: dateFormater.parse(_dateController.text),
          category: _categoriesList.categories[_categoryController.text]!));
      ExpensesList().getExpenses();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add new Expense",
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              const Divider(
                color: Color.fromARGB(180, 171, 171, 171),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _titleController,
                maxLength: 50,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _amountController,
                      validator: (value) {
                        if (value!.isEmpty || double.parse(value) == 0) {
                          return "Amount can't be embty or 0.";
                        }
                        return null;
                      },
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}')),
                      ],
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Amount",
                        prefixText: r"$",
                        hintText: "00.00",
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      readOnly: true,
                      controller: _dateController,
                      onTap: _showDatePicker,
                      decoration: const InputDecoration(
                        labelText: "Date",
                        suffixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              DropdownMenu<String>(
                  controller: _categoryController,
                  label: const Text("Category"),
                  onSelected: (value) => _validateCategory(),
                  errorText:
                      _isCategoryValid ? null : "You must choose a category.",
                  dropdownMenuEntries: _categoriesList.categories.values
                      .map(
                        (value) => DropdownMenuEntry<String>(
                            value: value.name,
                            label: value.name,
                            leadingIcon: Icon(value.icon)),
                      )
                      .toList()),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.cancel),
                      label: const Text("Canel")),
                  const SizedBox(width: 12),
                  FilledButton.icon(
                      onPressed: _submitForm,
                      icon: const Icon(Icons.done),
                      label: const Text("Save Expense"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
