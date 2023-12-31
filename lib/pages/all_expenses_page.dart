import 'package:flutter/material.dart';
import '../widgets/all_expenses_fetcher.dart';
import 'add_new_expense_page.dart';

class AllExpensesPage extends StatelessWidget {
  const AllExpensesPage({super.key});
  static const name = '/AllExpensesPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Expense Tracker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const AllExpensesFetcher(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewExpensePage.name);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
