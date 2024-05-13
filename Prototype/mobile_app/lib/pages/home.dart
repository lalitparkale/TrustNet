import 'package:flutter/material.dart';

import 'screen_lib.dart';

import '../globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome ${gUserProfile.name}!'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(40),
                child: Image(
                  image: AssetImage('assets/logo.png'),
                  width: 112,
                ),
              ),
              const Text('Tap into the power of your friends network',
                  style: TextStyle(
                    fontSize: 12,
                    //fontWeight: FontWeight.bold,
                  )),
              searchBar(context),
            ],
          ),
        ),
        bottomNavigationBar: navBar(context));
  }
}
