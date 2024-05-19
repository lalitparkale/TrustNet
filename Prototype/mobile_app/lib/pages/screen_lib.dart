library screen_lib;

import 'package:flutter/material.dart';
import 'package:pickeze/globals.dart';
import 'package:pickeze/pages/network.dart';
import 'package:pickeze/pages/recommendation.dart';
import '../pages/home.dart';
import '../pages/profile.dart';

Container searchBar(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
    child: TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        labelText: 'Search',
        hintText: 'search for tradies, like plumber to fix leaking pipe',
        hintStyle: const TextStyle(
            fontSize: 11, color: Colors.grey, fontStyle: FontStyle.italic),

        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            //invoke textfield onsubmitted event
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RecommendationPage()),
            );
          },
        ),
        //on change event to set the search text
      ),
      onChanged: (value) => SearchModel().searchText = value,
      onSubmitted: (value) {
        SearchModel().searchText = value;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RecommendationPage()),
        );
      },
    ),
  );
}

BottomNavigationBar navBar(BuildContext context) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Profile',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
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
                builder: (context) => const NetworkPage(title: 'Network')),
          )
        }
    },
  );
}
