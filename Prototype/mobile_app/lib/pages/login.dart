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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
          //add text field widget
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          //add text field widget
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          //add button widget
          ElevatedButton(
            onPressed: () {
              //navigate to home page
              //Navigator.pushNamed(context, '/home');
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomePage(title: 'TrustNet')),
              );
            },
            child: const Text('Login'),
          ),
          //add oauth providers
          const Text('Or login with:'),
          //add row widget
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //add icon button widget
              IconButton(
                icon: const Icon(Icons.facebook),
                onPressed: () {
                  //navigate to home page
                  //Navigator.pushNamed(context, '/home');
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
                icon: const Icon(Icons.facebook),
                onPressed: () {
                  //navigate to home page
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
