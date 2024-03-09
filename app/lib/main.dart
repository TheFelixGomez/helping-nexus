import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_nexus/ui/splash_screen.dart';

void main() {
  runApp(const ProviderScope(
      child: HelpingNexus()));
}

class HelpingNexus extends StatelessWidget {
  const HelpingNexus({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helping Nexus',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const SplashScreen(),
    );
  }
}