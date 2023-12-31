import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/expense.dart';
import '../../constants/icons.dart';
import '../models/expense_category.dart';
import 'confirm_box.dart';

class ExpenseTile extends StatelessWidget {
  final Expense exp;
  final List<ExpenseCategory> categories;
  const ExpenseTile(this.exp, this.categories, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(exp.id),
      direction: DismissDirection.endToStart,
      background: const Align(alignment: Alignment.centerRight,
        child: Icon(Icons.delete,color: Colors.red,),
      ),
      confirmDismiss: (_) async {
        final dismiss = await showDialog(
          context: context,
          builder: (_) => ConfirmBox(exp: exp),
        );
        return dismiss;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: Colors
                    .primaries[icons.keys.toList().indexOf(exp.category)])),
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icons[exp.category]),
          ),
          title: Text(exp.title),
          subtitle: Text(DateFormat('MMMM dd, yyyy').format(exp.date)),
          trailing: Text(NumberFormat.currency(locale: 'en_IN', symbol: '₹')
              .format(exp.amount)),
        ),
      ),
    );
  }
}
