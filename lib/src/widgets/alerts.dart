import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/src/styles/text.dart';

abstract class AppAlerts {
  static Future<void> showErrorDialog(
      bool isIOS, BuildContext context, String errorMessage) async {
    return (isIOS)
        ? showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(
                  'Error',
                  style: TextStyles.subtitle,
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(errorMessage, style: TextStyles.body)
                    ],
                  ),
                ),
                actions: <Widget>[
                  CupertinoButton(
                    child: Text('Okay', style: TextStyles.body),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              );
            })
        : showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Error',
                  style: TextStyles.subtitle,
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(errorMessage, style: TextStyles.body)
                    ],
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('Okay', style: TextStyles.body),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              );
            });
  }
}
