//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mobile_app/pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        // title: Text(widget.title),
        // ),
        body:
            //create standard login page with 2 text fields and a button and oauth providers
            Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 20),
            //add text field widget
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              //validate format of email
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            //add text field widget
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20),
            //add button widget
            ElevatedButton(
              //decorate the button
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigoAccent.withOpacity(0.5),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                //navigate to home page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePage(title: 'TrustNet')),
                );
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),
            const Divider(),
            //add oauth providers
            const Text('Or login with:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                )),
            //add row widget
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //add icon button widget
                IconButton(
                  icon: const Image(
                    image: AssetImage('assets/images/logoMicrosoft.png'),
                    width: 72,
                    //height: 24,
                  ),
                  onPressed: () {
                    //navigate to home page

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const HomePage(title: 'TrustNet')),
                    );
                  },
                ),
                //add icon button widget
                IconButton(
                  icon: const Image(
                    image: AssetImage('assets/images/logoG.png'),
                    width: 72,
                    //height: 24,
                  ),
                  onPressed: () {
                    //navigate to home page
                    //Navigator.pushNamed(context, '/home');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
