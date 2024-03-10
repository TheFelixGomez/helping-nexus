import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../helpers/validate_email.dart';
import '../../../components/custom_card_wrapper.dart';

final stepProvider = StateProvider<int>((ref) => 0);

class RegisterVolunteerScreen extends ConsumerStatefulWidget {
  const RegisterVolunteerScreen({super.key});

  @override
  ConsumerState<RegisterVolunteerScreen> createState() => _RegisterVolunteerScreen();
}

class _RegisterVolunteerScreen extends ConsumerState<RegisterVolunteerScreen> {
  final GlobalKey<FormState> _formValidator = GlobalKey<FormState>();
  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerUserLastName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword = TextEditingController();
  final TextEditingController _controllerBirthday = TextEditingController();
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

  XFile? _selectedImage;

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
          'Register Step:  ${step + 1} of X',
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
                          step == 7
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
                              controller: _controllerEmail,
                              onEditingComplete: () => FocusScope.of(context).nextFocus(),
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                prefixIcon: Icon(Icons.email, color: Colors.indigo),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              validator: (value) => validateEmail(value),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: step == 1,
                          child: Column(
                            children: [
                              CustomCardWrapper(
                                child: TextFormField(
                                  controller: _controllerUserName,
                                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                                  decoration: const InputDecoration(
                                    labelText: 'First Name',
                                    hintText: 'Enter your First Name',
                                    prefixIcon: Icon(Icons.emoji_people, color: Colors.green),
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
                              const SizedBox(
                                height: 20.0,
                              ),
                              CustomCardWrapper(
                                child: TextFormField(
                                  controller: _controllerUserLastName,
                                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                                  decoration: const InputDecoration(
                                    labelText: 'Last Name',
                                    hintText: 'Enter your Last Name',
                                    prefixIcon: Icon(Icons.emoji_people, color: Colors.green),
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
                            ],
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
                            child: TextField(
                              controller: _controllerBirthday,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Fecha de nacimiento',
                                hintText: 'DD/MM/AAAA',
                                prefixIcon: const Icon(Icons.calendar_today),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900, 1, 1),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  _controllerBirthday.text = pickedDate.toIso8601String().split('T')[0];
                                }
                              },
                            ),
                          ),
                        ),
                        Visibility(
                          visible: step == 4,
                          child: CustomCardWrapper(
                            child: TextFormField(
                                controller: _controllerExplication,
                                maxLines: 6,
                                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                                decoration: const InputDecoration(
                                  labelText: 'Why you want to be a volunteer?',
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
                        Visibility(
                          visible: step == 5,
                          child: GestureDetector(
                            onTap: () async {
                              final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                              if (pickedFile != null) {
                                setState(() {
                                  _selectedImage = pickedFile;
                                });
                              }
                            },
                            // TODO: Implement Service
                            child: CustomCardWrapper(
                              child:  Column(
                                children: [
                                  SizedBox(
                                    height: 300,
                                    width: 300,
                                    child: _selectedImage != null
                                        ? Image.file(File(_selectedImage!.path))
                                        : const Column(
                                      children: [
                                        Text(
                                          'Please Upload a Profile Photo',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 20.0),
                                        Image(
                                          width: double.infinity,
                                          image: AssetImage('assets/upload_image.png'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                            if (step == 7) {
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
                            step == 7 ?  'Finish' : 'Continue',
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