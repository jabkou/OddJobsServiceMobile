import 'package:flutter/material.dart';

class AlertBox{
  static showAlertDialog(BuildContext context, String title, String message, String buttonText) {
    Widget okButton = FlatButton(
      child: Text(buttonText),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}