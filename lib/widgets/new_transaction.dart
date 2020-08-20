import 'dart:io';

import 'package:expenses/utils/showAlertFunc.dart';
import 'package:expenses/widgets/adaptiveFlatButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function createTransaction;

  NewTransaction(this.createTransaction) {
    print("constructor new transaction widget");
  }

  @override
  _NewTransactionState createState() {
    print("create state in newtransaction widget");
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    print("new Constructor only state");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Print init state()");
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("print didUpdateWidget()");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
  }

  void _submitData() {
    if (_amountController.text.isEmpty) {
      showALertFunc(
          buttonMsj: "ok",
          content: "olvidaste poner la cantidad del gasto",
          title: "El valor esta vacio",
          context: context);
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      //boton ok showDialog widget
      showALertFunc(
          buttonMsj: "lo corregire",
          title: "llena todos los campos",
          content: "olvidaste llenar el titulo o la fecha de la transaccion",
          context: context);
      return;
    }
    //it gives you acces to the connected widget
    widget.createTransaction(enteredTitle, enteredAmount, _selectedDate);
    //
    Navigator.of(context).pop();
  }

  // vamos a ver carajo a meter la fecha
  void _datePresent() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                /* onChanged: (value) {
                              titleInput = value;
                            }, */
              ),
              TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number
                  /*  onChanged: (value) {
                              amountInput = value;
                            }, */
                  ),
              Container(
                height: 70,
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _selectedDate == null
                          ? "No se ha escogido fecha"
                          : DateFormat.yMEd().format(_selectedDate),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    AdaptiveFlatButton(
                      handler: _datePresent,
                      text: "seleccionar la fecha",
                    )
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: _submitData,
                child: Text("Add Transaction mijo"),
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
