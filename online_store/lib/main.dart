import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:online_store/sign_in_flow/screens/sign_in_screen.dart';

import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));
}
