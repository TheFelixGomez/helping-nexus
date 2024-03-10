import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar customAppBar(String title, context) {
  return AppBar(
    centerTitle: true,
    title: Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.nunito(
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
    ),
    backgroundColor: Colors.black,
  );
}