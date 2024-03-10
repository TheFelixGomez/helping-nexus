import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar customAppBar(String title, context) {
  return AppBar(
    title: Center(
      child: Text(
        title,
        style: GoogleFonts.nunito(
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    backgroundColor: Colors.black,
  );
}