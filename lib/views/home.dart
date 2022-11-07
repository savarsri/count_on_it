// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:count_on_it/functions/UserDatabase.dart';
import 'package:count_on_it/views/NavigationDrawerApp.dart';
import 'package:count_on_it/views/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black, fontSize: width * 0.06),
        ),
      ),
    );
  }
}
