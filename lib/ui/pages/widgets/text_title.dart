import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextTitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const TextTitleWidget(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.roboto(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: const Color(0xff80848A),
            ),
          ),
        ],
      ),
    );
  }
}
