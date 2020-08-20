import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget transactionListWidget(double navBarHeight, BuildContext context,
    List<Transaction> transactions, Function deleteTransaction) {
  double totalAvailableSpace = MediaQuery.of(context).size.height;
  double mainNavBarHeight = MediaQuery.of(context).padding.top;
  //100%
  return Container(
    height: (totalAvailableSpace - navBarHeight - mainNavBarHeight) * 0.7,
    child: TransactionList(
      userTransaction: transactions,
      deleteTransaction: deleteTransaction,
    ),
  );
}

PreferredSizeWidget appBarWidgetx(bool isIOS, BuildContext context,
    Function popUpNewTransaction, double totalExpense) {
  return isIOS
      ? CupertinoNavigationBar(
          middle: Text(
            'Gastos Personales',
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                child: Icon(CupertinoIcons.add),
                onTap: () => popUpNewTransaction(context),
              )
            ],
          ),
        )
      : AppBar(
          title: Text(
            'Gastos Personales',
          ),
          actions: <Widget>[
            Center(
                child: Text(
              "\$ ${totalExpense.toStringAsFixed(2)}",
              style: TextStyle(color: Colors.white),
            )),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => popUpNewTransaction(context),
            )
          ],
        );
}
