//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mobile_app/pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //add icon button widget
                IconButton(
                  icon: const Icon(Icons.facebook,
                      color: Colors.blueAccent, size: 50),
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
                  icon: Image.network(
                    'https://lh3.googleusercontent.com/d_S5gxu_S1P6NR1gXeMthZeBzkrQMHdI5uvXrpn3nfJuXpCjlqhLQKH_hbOxTHxFhp5WugVOEcl4WDrv9rmKBDOMExhKU5KmmLFQVg',
                    //width: 100,
                    height: 50,
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