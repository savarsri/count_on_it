// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'loginPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(width * 0.1),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height * 0.3,
            width: height * 0.3,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            child: Icon(
              Icons.person,
              size: height * 0.3,
            ),
          ),
          ElevatedButton(onPressed: signOut, child: Text('Logout'))
        ],
      ),
    );
  }

  Future signOut() async {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signOut();
      navigatorKey.currentState!.push(
        MaterialPageRoute(builder: (BuildContext context) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
