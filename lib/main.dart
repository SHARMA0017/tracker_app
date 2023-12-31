import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/add_new_expense_page.dart';
import 'provider/database_provider.dart';
import 'pages/all_expenses_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => DatabaseProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AllExpensesPage.name,
      routes: {
        AllExpensesPage.name: (_) => const AllExpensesPage(),
        AddNewExpensePage.name: (_) => const AddNewExpensePage(),
      },
    );
  }
}
