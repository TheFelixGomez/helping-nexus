import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_back_button.dart';

AppBar customAppBarBackButton(String title, context) {
  return AppBar(
    centerTitle: true,
    leading: const CustomBackButton(),
    title: Text(
      title,
      style: GoogleFonts.nunito(
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      )
    ),
    backgroundColor: Colors.black,
  );
}