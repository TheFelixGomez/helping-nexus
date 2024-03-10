import 'package:flutter/material.dart';

class CustomCardWrapper extends StatelessWidget {
  final Widget child;
  const CustomCardWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(width: 1, color: Colors.white)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}