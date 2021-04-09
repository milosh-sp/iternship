import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iternship/main.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../authentication_service.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final refDatabase = FirebaseDatabase.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ref = refDatabase.reference().child('userdetails');

    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                    ),
                    Text(
                      'Many internships await',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 50.0),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      controller: emailController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "First name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Lastname",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter lastname';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: universityController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "University",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your university';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: qualificationController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Qualification",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your qualification';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await context
                              .read<AuthenticationService>()
                              .signUp(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((String value) => ref
                                      .push()
                                      .child('users')
                                      .set(<String, Object>{
                                    "firstname": firstNameController.text,
                                    "lastname": lastNameController.text,
                                    "university": universityController.text,
                                    "qualification":
                                        qualificationController.text,
                                    "email": emailController.text
                                  }).asStream());

                          _openEmptyEmailPass(context);
                          _formKey.currentState.reset();
                        }
                      },
                      child: Text('Sign up'),
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                    ),
                    /*
                    ElevatedButton(
                        onPressed: () => _openEmptyEmailPass(context),
                        child: Text('lol')),

                     */
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _openEmptyEmailPass(context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Welcome to ITernship'),
        content: Text('Your registration was successful, you can now browse thousands of internships with custom tags'),
        actions: [
             Image.network(
              'https://webstockreview.net/images/jump-clipart-happy-man-9.png',
            ),
        ],
      ),
    );
  }
}
