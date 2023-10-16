import 'package:flutter/material.dart';

void showMessage(
  BuildContext context, {
  required String message,
  required bool success,
}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(
        fontSize: 18.0,
        color: success == true ? Colors.black : Colors.white,
      ),
    ),
    backgroundColor: success == true ? Colors.white : Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
