import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../helpers/validate_email.dart';
import '../../../components/custom_card_wrapper.dart';

final stepProvider = StateProvider<int>((ref) => 0);

class RegisterCompanyScreen extends ConsumerStatefulWidget {
  const RegisterCompanyScreen({super.key});

  @override
  ConsumerState<RegisterCompanyScreen> createState() => _RegisterCompanyScreenState();
}

class _RegisterCompanyScreenState extends ConsumerState<RegisterCompanyScreen> {
  final GlobalKey<FormState> _formValidator = GlobalKey<FormState>();
  final TextEditingController _controllerCompanyName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword = TextEditingController();
  final TextEditingController _controllerExplication = TextEditingController();

  double _progressValue = 0.0;

  void _incrementStep() {
    ref.read(stepProvider.notifier).state++;
    setState(() {
      _progressValue = _progressValue + 0.25;
    });
  }

  void _decrementStep() {
    ref.read(stepProvider.notifier).state--;
    setState(() {
      _progressValue = _progressValue - 0.25;
    });
  }

  @override
  Widget build(BuildContext context) {
    final step = ref.watch(stepProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            if (step > 0) {
              _decrementStep();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
            'Register Step:  ${step + 1} of 5',
            style: GoogleFonts.nunito(
              textStyle: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
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
              height: MediaQuery.of(context).size.height * 0.88,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CustomCardWrapper(
                        child: Column(
                          children: [
                            LinearProgressIndicator(
                              value: _progressValue,
                              backgroundColor: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber,
                            ),
                          ],
                        ),
                      ),
                      CustomCardWrapper(
                        child: Text(
                          step == 4
                              ? 'Finish the registration process. \n\n '
                              'Our team will review your answers and contact'
                              ' you to validate the information. \n\n '
                              ' Thank you for your trust in Helping Nexus'
                              : 'Give us some information about yourself.',

                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _formValidator,
                    child: Column(
                      children: [
                        Visibility(
                          visible: step == 0,
                          child: CustomCardWrapper(
                            child: TextFormField(
                              controller: _controllerCompanyName,
                              onEditingComplete: () => FocusScope.of(context).nextFocus(),
                              decoration: const InputDecoration(
                                labelText: 'Company Name',
                                hintText: 'Enter your Name',
                                prefixIcon: Icon(Icons.business_center_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              validator: (value) {
                                if(value == null || value.isEmpty){
                                  return 'The Company Name is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Visibility(
                          visible: step == 1,
                          child: CustomCardWrapper(
                            child: TextFormField(
                              controller: _controllerEmail,
                              onEditingComplete: () => FocusScope.of(context).nextFocus(),
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              validator: (value) => validateEmail(value),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: step == 2,
                          child: Column(
                            children: [
                              CustomCardWrapper(
                                child: TextFormField(
                                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                                  controller: _controllerPassword,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Enter your password',
                                    prefixIcon: Icon(Icons.password),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                  ),
                                  validator: (value) {
                                    if(value == null || value.isEmpty){
                                      return 'The Password is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              CustomCardWrapper(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _controllerConfirmPassword,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        labelText: 'Confirm Password',
                                        hintText: 'Confirm Password',
                                        prefixIcon: Icon(Icons.password),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'The Password is required';
                                        } else if (value != _controllerPassword.text) {
                                          return 'The Passwords do not match';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: step == 3,
                          child: CustomCardWrapper(
                            child: TextFormField(
                              controller: _controllerExplication,
                              maxLines: 6,
                              onEditingComplete: () => FocusScope.of(context).nextFocus(),
                              decoration: const InputDecoration(
                                labelText: 'Why do you need help?',
                                hintText: 'Enter your explanation',
                                prefixIcon: Icon(
                                  Icons.question_mark,
                                  color: Colors.red,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This Field is required';
                                  }
                                  return null;
                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor: Colors.indigo,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        onPressed: () {
                          if (_formValidator.currentState!.validate()) {
                            if (step == 4) {
                              //TODO: Implement Service
                            } else {
                              _incrementStep();
                              setState(() {
                                _progressValue + 0.25;
                              });
                            }
                          }
                        },
                        child: Text(
                            step == 4 ?  'Finish' : 'Continue',
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
}