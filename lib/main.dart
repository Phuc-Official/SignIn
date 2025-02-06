import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/home.dart';
import 'package:todoapp/screens/login.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: const FirebaseOptions(
      apiKey: "AIzaSyDm23k4eZorK_XXpBeuuoohf2km0KsDjEg",
      appId: "1:683424407898:android:674e45320d85e15240d363",
      messagingSenderId: "683424407898",
      projectId: "apptodo-61e08",
    ),
  );
  await FirebaseAppCheck.instance.activate();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodoApp',
      home: Login(),
    );
  }
}

