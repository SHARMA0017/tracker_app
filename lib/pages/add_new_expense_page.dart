import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../provider/database_provider.dart';
import '../constants/icons.dart';
import '../models/expense.dart';

class AddNewExpensePage extends StatefulWidget {
  const AddNewExpensePage({super.key});
  static const name = '/AddNewExpensePage';

  @override
  State<AddNewExpensePage> createState() => _AddNewExpensePageState();
}

class _AddNewExpensePageState extends State<AddNewExpensePage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _title = TextEditingController();
  final _amount = TextEditingController();
  DateTime? _date;
  String _initialValue = 'Other';

  _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      setState(() {
        _date = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Expense',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _title,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Title of expense',
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _amount,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    } else if (double.tryParse(value) == null) {
                      return "Please Enter a vaild amount";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount of expense',
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(_date != null
                          ? DateFormat('MMMM dd, yyyy').format(_date!)
                          : 'Select Date'),
                    ),
                    IconButton(
                      onPressed: () => _pickDate(),
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    const Expanded(child: Text('Category')),
                    Expanded(
                      child: DropdownButton(
                        items: icons.keys
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        value: _initialValue,
                        onChanged: (newValue) {
                          setState(() {
                            _initialValue = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final file = Expense(
                        id: 0,
                        title: _title.text,
                        amount: double.parse(_amount.text),
                        date: _date != null ? _date! : DateTime.now(),
                        category: _initialValue,
                      );

                      provider.addExpense(file);

                      Navigator.of(context).pop();
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Expense'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
