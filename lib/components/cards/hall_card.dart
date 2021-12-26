import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HallCard extends StatelessWidget {
  HallCard({required this.text, required this.onTap, this.icon = Icons.class__sharp});
  final String text;
  final Function() onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: icon == Icons.class__sharp ? 30 : 40,
              color: icon == Icons.class__sharp ? Colors.tealAccent.shade400 : Colors.green,
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: GoogleFonts.sourceSansPro(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
