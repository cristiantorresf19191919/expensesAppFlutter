import 'dart:io';
import 'package:expenses/utils/checkPlatform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  Function handler;
  String text;

  AdaptiveFlatButton({@required this.handler, @required this.text});

  @override
  Widget build(BuildContext context) {
    return checkPlatform()
        ? CupertinoButton(
            child: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Color.fromRGBO(150, 150, 150, .7),
                      offset: Offset(2.0, 1.0),
                    )
                  ],
                  fontSize: Theme.of(context).textTheme.headline6.fontSize - 2,
                  color: Theme.of(context).primaryColor),
            ),
            onPressed: handler,
          )
        : FlatButton(
            child: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Color.fromRGBO(150, 150, 150, .7),
                      offset: Offset(2.0, 1.0),
                    )
                  ],
                  fontSize: Theme.of(context).textTheme.headline6.fontSize - 2,
                  color: Theme.of(context).primaryColor),
            ),
            onPressed: handler,
          );
  }
}
