import 'package:flutter/material.dart';

showSpinner(context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Please wait...', style: TextStyle(fontSize: 15)),
        content: Container(
          height: 50,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}
