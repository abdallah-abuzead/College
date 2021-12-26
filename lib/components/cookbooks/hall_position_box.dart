import 'package:flutter/material.dart';

class HallPositionBox extends StatelessWidget {
  HallPositionBox({required this.text, required this.bottom, required this.left, required this.onTap});
  final String text;
  final double bottom, left;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      left: left,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 70,
          width: 100,
          color: Color(0xFFD1D6E1),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 18, color: Colors.blue[900], fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
