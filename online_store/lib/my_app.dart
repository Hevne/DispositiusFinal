import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_store/main_screen.dart';
import 'package:online_store/sign_in_flow/screens/sign_in_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      title: 'My App which needs login',
      home: user != null
          ? MainScreen()
          : SignInScreen(),
    );
  }
}
