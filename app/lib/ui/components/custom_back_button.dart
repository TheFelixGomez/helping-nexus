import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.black,
          backgroundColor: Colors.blue.withOpacity(0),
          splashFactory:  NoSplash.splashFactory,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
        onPressed: () {
          GoRouter.of(context).pop();
        },
        child: const FaIcon(
          FontAwesomeIcons.circleChevronLeft,
          color: Colors.indigo,
          size: 30.0,
        ),
      ),
    );
  }
}