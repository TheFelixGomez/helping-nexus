import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              fontWeight: FontWeight.w700,
            ),
          ),
      ),
    ),
    actions: [
      IconButton(
        onPressed: () => GoRouter.of(context).pushNamed('chats'),
        icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
      ),
    ],
    backgroundColor: Colors.black,
  );
}