import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/database_provider.dart';
import 'expense_tile.dart';

class AllExpensesList extends StatelessWidget {
  const AllExpensesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var list = db.expenses;
        return list.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: list.length,
                itemBuilder: (_, i) => ExpenseTile(list[i], db.categories),
              )
            : const Center(
                child: Text('No Entries Found'),
              );
      },
    );
  }
}
