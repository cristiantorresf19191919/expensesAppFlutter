import 'package:flutter/material.dart';

void showALertFunc(
    {@required BuildContext context,
    @required String title,
    @required String content,
    @required String buttonMsj}) {
  // delcate the burron
  Widget button = FlatButton(
    child: Text(buttonMsj),
    onPressed: () => Navigator.of(context).pop(),
  );

  // AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: <Widget>[button],
  );

  // ShowDialog
  showDialog(context: context, builder: (BuildContext context) => alert);
}
