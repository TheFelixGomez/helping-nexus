import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_nexus/manager/app_state_manager.dart';

class SplashScreen extends ConsumerStatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.read(appStateProvider.notifier).initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Padding(
               padding: EdgeInsets.all(15.0),
               child: Image(
                height: 300,
                image: AssetImage('assets/logos/HelpingNexus.png'),
               ),
             ),
          ],
        ),
      ),
    );
  }
}

