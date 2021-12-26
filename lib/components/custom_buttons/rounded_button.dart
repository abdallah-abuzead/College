import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({required this.title, required this.colour, required this.onPressed, this.titleStyle});

  final Color colour;
  final String title;
  final TextStyle? titleStyle;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: colour,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 200.0,
        height: 42.0,
        child: Text(title, style: titleStyle ?? TextStyle(color: Colors.white)),
      ),
    );
  }
}
