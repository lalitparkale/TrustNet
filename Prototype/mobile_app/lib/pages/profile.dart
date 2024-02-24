import 'package:flutter/material.dart';
import 'package:mobile_app/pages/screen_lib.dart';
import 'package:mobile_app/globals.dart' as globals;

//create profile screen
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          BasicProfileCard(),
          //spacing
          const SizedBox(height: 20),

          DataTable(
            sortColumnIndex: 0,
            sortAscending: true,
            showCheckboxColumn: true,
            headingRowColor: MaterialStateProperty.all(Colors.blue[100]),
            columns: [
              DataColumn(label: const Text('Name')),
              DataColumn(label: const Text('Mobile')),
            ],
            rows: [
              for (var contact in globals.globalSharedContacts)
                DataRow(
                  cells: [
                    DataCell(Text(contact.fullName)),
                    DataCell(Text(contact.mobile)),
                  ],
                  onSelectChanged: (newValue) {
                    //do something
                    if (newValue == true) {}
                  },
                ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: navBar(context),
    );
  }
}

class BasicProfileCard extends StatelessWidget {
  const BasicProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Profile',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        //display user profile
        Row(
          children: [
            const Icon(
              Icons.person,
              size: 100,
              color: Colors.indigo,
              shadows: [Shadow(color: Colors.blue, blurRadius: 10)],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${globals.globalUserProfile.name}'),
                Text('Email: ${globals.globalUserProfile.email}'),
                Text('Postcode: ${globals.globalUserProfile.postcode}'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
