library screen_lib;

import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../pages/profile.dart';

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
      if (value == 0)
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          ),
        }
      else if (value == 1)
        {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HomePage(title: 'TrustNet')),
          ),
        }
      else if (value == 2)
        {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HomePage(title: 'Network')),
          )
        }
    },
  );
}
