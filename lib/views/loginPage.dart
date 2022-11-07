// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:count_on_it/functions/UserDatabase.dart';
import 'package:count_on_it/functions/utils.dart';
import 'package:count_on_it/main.dart';
import 'package:count_on_it/views/home.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _newEmailController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  bool _signUpOpacity = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: height * 0.002,
                              color: _signUpOpacity
                                  ? Colors.grey
                                  : Colors.lightBlue.shade900),
                        ),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _signUpOpacity = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: width * 0.07,
                              color: Theme.of(context).secondaryHeaderColor),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: height * 0.002,
                              color: _signUpOpacity
                                  ? Colors.lightBlue.shade900
                                  : Colors.grey),
                        ),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _signUpOpacity = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          "Sign-up",
                          style: TextStyle(
                              fontSize: width * 0.07,
                              color: Theme.of(context).secondaryHeaderColor),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Stack(
                  children: [
                    Positioned(
                      child: AnimatedOpacity(
                        curve: Curves.easeIn,
                        opacity: _signUpOpacity ? 0.0 : 1.0,
                        duration: Duration(milliseconds: 200),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? 'Enter a valid E-mail'
                                  : null,
                              decoration: InputDecoration(
                                hintText: "E-mail",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline_rounded,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  value != null && value.length < 6
                                      ? "Enter minimun 6 characters"
                                      : null,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                prefixIcon: Icon(
                                  Icons.password_rounded,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            ElevatedButton(
                                onPressed: signIn, child: Text('Sign-in'))
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      child: Visibility(
                        visible: _signUpOpacity,
                        child: AnimatedOpacity(
                          curve: Curves.easeOut,
                          opacity: _signUpOpacity ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 200),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person_outline_rounded,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              TextFormField(
                                controller: _newEmailController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (email) => email != null &&
                                        !EmailValidator.validate(email)
                                    ? 'Enter a valid E-mail'
                                    : null,
                                decoration: InputDecoration(
                                  hintText: "E-mail",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person_outline_rounded,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              TextFormField(
                                controller: _newPasswordController,
                                obscureText: true,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    value != null && value.length < 6
                                        ? "Enter minimun 6 characters"
                                        : null,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.password_rounded,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              ElevatedButton(
                                  onPressed: signUp, child: Text('Sign-Up'))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      navigatorKey.currentState!.push(
        MaterialPageRoute(builder: (BuildContext context) => const Home()),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      //Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future signUp() async {
    print('hello');
    //final isValid = formKey.currentState!.validate();
    //if (!isValid) return;
    print('hello2');
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    print('hello3');
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _newEmailController.text.trim(),
          password: _newPasswordController.text.trim());

      await UserDatabase().createUserData(
          FirebaseAuth.instance.currentUser!.uid,
          _nameController.text.trim(),
          _newEmailController.text.trim(),
          '');
    } on FirebaseAuthException catch (e) {
      print(e);
      //Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
