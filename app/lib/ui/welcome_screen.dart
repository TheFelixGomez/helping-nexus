import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/custom_card_wrapper.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/screens_background_grey.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          minimum: const EdgeInsets.only(
              top: 5.0,
              right: 10.0,
              left: 10.0,
              bottom: 10.0
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomCardWrapper(
                    child: Image.asset('assets/logos/TextLogo.png',
                      width: double.infinity,),
                  ),
                  CustomCardWrapper(
                    child: Column(
                      children: [
                        Text(
                          'Your friendly helper, always ready to lend a hand. 🚀 ',
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _box('I Want to Help!', Icons.travel_explore_outlined, Colors.green,
                            () => {},
                      ),
                      _box('I Need Help!', Icons.sos_outlined, Colors.red, () => {}),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      onPressed: () => context.pushNamed('login'),
                      child: Text('🔐  Login',
                        style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            )
                        )
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _box(String text, IconData icon, Color color, Function() onTap ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        width: 150,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 80,
                color: color,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
