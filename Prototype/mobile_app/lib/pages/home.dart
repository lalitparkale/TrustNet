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
    getCurrentPosition().then((value) {
      setState(() {
        //rebuild the widget
        print('initState() called');
        if ((gUserProfile.name == 'Awesome') ||
            (gUserProfile.name == '') ||
            (gUserProfile.postcode == 0) ||
            (gUserProfile.mobile == '')) {
          initMessageDialogBuilder(context);
        }
      });
    });
    super.initState();
  }

  Future<void> initMessageDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Welcome to Pickeze!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please update your profile to continue.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getCurrentPosition() async {
    await waitForInit();

    return;
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
