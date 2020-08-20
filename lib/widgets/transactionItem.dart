import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem(
      {Key key,
      @required this.userTransaction,
      @required this.deleteTransaction})
      : super(key: key);

  final Transaction userTransaction;
  final Function deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  List<Color> colors = [
    Colors.black,
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.purple
  ];
  Color color;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    color = colors[Random().nextInt(5)];
  }

  void borrarTransaccion(BuildContext context, String transaccionId) {
    // pasar por parametros el contexto y el id de la transaccion
    // construir los botones
    Widget cancelar = FlatButton(
        onPressed: () => Navigator.of(context).pop(), child: Text("Cancelar"));

    Widget eliminar = FlatButton(
        onPressed: () {
          this.widget.deleteTransaction(transaccionId);
          //cerrrar la alerta apenas se elimine la transaaccion
          //perfecto
          Navigator.of(context).pop();
        },
        child: Text("eliminar"));

    // la alerta
    AlertDialog alert = AlertDialog(
      title: Text("Eliminar"),
      content: Text("Esta seguro que desea eliminar la transaccion"),
      actions: <Widget>[cancelar, eliminar],
    );

    // disparar la alerta

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });

    // listo poner la funcion en el boton de eliminar para que funcione
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                "\$ ${widget.userTransaction.amount}",
              ),
            ),
          ),
        ),
        title: Text(
          "${widget.userTransaction.title}",
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat.yMMMd().format(widget.userTransaction.date)),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () =>
              borrarTransaccion(context, widget.userTransaction.id),
        ),
      ),
    );
  }
}
