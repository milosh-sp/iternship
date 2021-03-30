import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iternship/authentication_service.dart';
import 'package:iternship/main.dart';
import 'package:iternship/utils/image_banner.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginButon = Container(
      width: MediaQuery.of(context).size.width * 1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          primary: Colors.black,
          padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            await context.read<AuthenticationService>().signIn(
                email: emailController.text, password: passwordController.text);
            _formKey.currentState.reset();
          }
        },
        child: Text('Sign in'),
      ),
    );

    final registerButton = TextButton(
        onPressed: () => Navigator.pushNamed(context, RegisterRoute),
        child: Text(
          'Sign up',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ));

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Container(
                    child: Image.asset('assets/images/logo.png'),
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.10),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    controller: passwordController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  loginButon,
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  registerButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
