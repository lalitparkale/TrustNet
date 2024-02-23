import 'package:flutter/material.dart';
import 'package:mobile_app/pages/home.dart';

BottomNavigationBar navBar(BuildContext context) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Profile',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.star),
        label: 'Network',
      ),
    ],
    onTap: (value) => {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HomePage(title: 'TrustNet')),
      ),
      //add switch case to navigate to different pages

      // switch (value) {

      //   case 0:
      //     //navigate to profile page
      //     break;
      //   case 1:
      //     //navigate to home page
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => HomePage(title: 'TrustNet')),
      //     ),
      //     break;
      //   case 2:
      //     //navigate to network page
      //     break;
      // }
    },
  );
}
