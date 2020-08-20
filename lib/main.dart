import 'dart:io';
import 'package:expenses/extraWidgets/chartWidgetPortrait.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/utils/checkPlatform.dart';
import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/new_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool _isIOS = checkPlatform();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gastos Personales",
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
          fontFamily: 'Quicksand'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool _showCart = false;
  final bool _isIOS = checkPlatform();

  final List<Transaction> _userTransaction = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 16.53,
        date: DateTime.now()),
    Transaction(
        id: 't3',
        title: 'Chocolates',
        amount: 16.53,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: 't3',
        title: 'Chocolates',
        amount: 56.53,
        date: DateTime.now().subtract(Duration(days: 2))),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    print("app initstate is triggered");
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    print("the state has updated to ${state}");
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    print("app dispose triggered");
    super.dispose();
  }

  //disparar el modal de abajo
  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  //mostrar las ultimas transacciones de la semana
  List<Transaction> get _recentTransaction {
    //retorna la las transacciones de hoy menos siete dias
    return _userTransaction.where((tx) {
      //vota verdadero si cada fecha estaDespues de hoy menos siete dias
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  double get _gastoTotal {
    return _recentTransaction.fold(
        0.0, (previousValue, element) => previousValue + element.amount);
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime dateSelected) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: dateSelected,
        id: DateTime.now().toString());
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    double totalAvailableSpace = mediaQuery.size.height;
    double navBarHeight = appBar.preferredSize.height;
    double mainNavBarHeight = mediaQuery.padding.top;
    //70% del campo disponible
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "mostrar grafico",
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value: _showCart,
              onChanged: (value) {
                setState(() {
                  _showCart = value;
                });
              })
        ],
      ),
      _showCart
          ? Container(
              height:
                  (totalAvailableSpace - navBarHeight - mainNavBarHeight) * 0.7,
              child: Chart(_recentTransaction))
          : txListWidget
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    double totalAvailableSpace = mediaQuery.size.height;
    double navBarHeight = appBar.preferredSize.height;
    //main menu
    double mainNavBarHeight = mediaQuery.padding.top;
    //30% del campo disponible
    return [
      Container(
          height: (totalAvailableSpace - navBarHeight - mainNavBarHeight) * 0.3,
          child: Chart(_recentTransaction)),
      txListWidget
    ];
  }

  // metodo principal
  @override
  Widget build(BuildContext context) {
    //negar aca para cambiar de material a cupertino

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final mediaQuery = MediaQuery.of(context);

    final PreferredSizeWidget appBar =
        appBarWidgetx(_isIOS, context, _startAddNewTransaction, _gastoTotal);

    final Widget txListWidget = transactionListWidget(
        appBar.preferredSize.height,
        context,
        _userTransaction,
        _deleteTransaction);

    final Widget body = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if (isLandscape)
            ..._buildLandscapeContent(mediaQuery, appBar, txListWidget),
          if (!isLandscape)
            ..._buildPortraitContent(mediaQuery, appBar, txListWidget),
        ],
      ),
    ));

    return _isIOS
        ? CupertinoPageScaffold(
            child: body,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context)),
          );
  }
}
