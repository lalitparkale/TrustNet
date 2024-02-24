import 'package:flutter/material.dart';
import 'package:mobile_app/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //create initialisation function
  void getInitInfo() {
    //initialise the app
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrustNet',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      //home: const HomePage(title: 'TrustNet - word of friends!'),
      home: const LoginPage(title: 'TrustNet - word of friends!'),
    );
  }
}
