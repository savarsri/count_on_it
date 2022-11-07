// ignore_for_file: prefer_const_constructors
import 'package:count_on_it/views/home.dart';
import 'package:count_on_it/views/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
          primaryColor: Colors.white,
          secondaryHeaderColor: Colors.black,
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 72.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            headline6: TextStyle(
              fontSize: 30,
            ),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
          iconTheme: IconThemeData(color: Colors.black)),
      darkTheme: ThemeData.dark(), // standard dark theme
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => MainState();
}

class MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong!'),
            );
          } else if (snapshot.hasData) {
            return Home();
          } else {
            return LoginPage();
          }
        }),
      ),
    );
  }
}
