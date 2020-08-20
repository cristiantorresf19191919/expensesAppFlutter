import 'package:expenses/widgets/transactionItem.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function deleteTransaction;
  TransactionList({@required this.userTransaction, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return userTransaction.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  "No hay transacciones agregadas en el momento",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                Container(
                  height: constraints.maxHeight * 0.60,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: userTransaction.length,
            itemBuilder: (context, index) {
              return TransactionItem(
                key: ValueKey(userTransaction[index].id),
                userTransaction: userTransaction[index],
                deleteTransaction: deleteTransaction,
              );
            },
          );
    // listo :)
  }
}
