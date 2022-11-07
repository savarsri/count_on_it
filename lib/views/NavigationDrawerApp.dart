// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:count_on_it/functions/UserDatabase.dart';
import 'package:count_on_it/main.dart';
import 'package:count_on_it/views/loginPage.dart';
import 'package:count_on_it/views/profilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({super.key});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Drawer(
      child: Material(
        color: Colors.white60,
        child: Container(
          padding: EdgeInsets.all(width * 0.015),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * 0.04,
                  ),
                  Icon(Icons.person),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(UserDatabase().getUserName().toString()),
                      Text(FirebaseAuth.instance.currentUser!.email.toString()),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.012,
              ),
              Divider(
                color: Colors.grey,
                thickness: height * 0.0005,
              ),
              SizedBox(
                height: height * 0.012,
              ),
              Card(
                color: Colors.orange[50],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 4,
                child: ListTile(
                  title: Text('Statistics'),
                  leading: Icon(Icons.stacked_bar_chart_rounded),
                  minLeadingWidth: width * 0.005,
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: height * 0.012,
              ),
              Card(
                color: Colors.orange[50],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 4,
                child: ListTile(
                  title: Text('Profile'),
                  leading: Icon(Icons.person_rounded),
                  minLeadingWidth: width * 0.005,
                  onTap: profile,
                ),
              ),
              SizedBox(
                height: height * 0.012,
              ),
              Divider(
                color: Colors.grey,
                thickness: height * 0.0005,
              ),
              SizedBox(
                height: height * 0.012,
              ),
              Card(
                color: Colors.orange[50],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 4,
                child: ListTile(
                  title: Text('Settings'),
                  leading: Icon(Icons.settings),
                  minLeadingWidth: width * 0.005,
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: height * 0.012,
              ),
              Card(
                color: Colors.orange[50],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 4,
                child: ListTile(
                  title: Text('Logout'),
                  leading: Icon(Icons.logout_rounded),
                  minLeadingWidth: width * 0.005,
                  onTap: signOut,
                ),
              ),
              SizedBox(
                height: height * 0.012,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void profile() {
    navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (BuildContext context) => const ProfilePage()),
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
