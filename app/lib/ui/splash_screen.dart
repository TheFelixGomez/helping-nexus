import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // TODO: initializeApp
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: Change for real image
             // Padding(
             //   padding: EdgeInsets.all(15.0),
             //   child: Image(
             //    height: 80,
             //    image: AssetImage('assets/logos/launch_image.png'),
             //   ),
             // ),
            Text('Splash'),
          ],
        ),
      ),
    );
  }
}

