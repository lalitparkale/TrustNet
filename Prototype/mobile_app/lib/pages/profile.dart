import 'package:flutter/material.dart';
import 'package:mobile_app/pages/login.dart';
import 'package:mobile_app/pages/screen_lib.dart';
import 'package:mobile_app/globals.dart' as globals;
import 'package:mobile_app/model/profile_model.dart';

//create profile screen
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            BasicProfileCard(),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            SharedContactsTile(),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ],
        ),
      ),
      bottomNavigationBar: navBar(context),
    );
  }
}

class SharedContactsTile extends StatelessWidget {
  const SharedContactsTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        //color: Colors.indigoAccent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contacts',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: DataTable(
              sortColumnIndex: 0,
              sortAscending: true,
              showCheckboxColumn: true,
              headingTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                //color: Colors.white,
              ),
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Mobile')),
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
          ),
          const SizedBox(height: 2),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                addContactDialogBuilder(context);
              },
              icon: const Icon(
                Icons.add_circle,
                color: Colors.blue,
              ),
              iconSize: 36,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> addContactDialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return const AlertDialog(
        title: Text('Add contact'),
        actions: <Widget>[
          FormAddContact(),
        ],
      );
    },
  );
}

class FormAddContact extends StatefulWidget {
  const FormAddContact({super.key});

  @override
  State<FormAddContact> createState() => FormAddContactState();
}

class FormAddContactState extends State<FormAddContact> {
  final GlobalKey<FormState> formKeyAddContact = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserContact newContact = UserContact(fName: '', fullName: '', mobile: '');

    return Form(
      key: formKeyAddContact,
      child: Column(
        children: [
          TextFormField(
            onSaved: (newValue) {
              newContact.fName = newValue!;
            },
            decoration: const InputDecoration(
              hintText: 'First Name',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter name';
              }
              return null;
            },
          ),
          TextFormField(
            onSaved: (newValue) {
              newContact.fullName = '${newContact.fName} ${newValue!}';
            },
            decoration: const InputDecoration(
              hintText: 'Last Name',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter last name';
              }
              return null;
            },
          ),
          TextFormField(
            onSaved: (newValue) {
              newContact.mobile = newValue!;
            },
            decoration: const InputDecoration(
              hintText: 'Mobile',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter mobile number';
              }
              return null;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent.withOpacity(0.5),
                  ),
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    formKeyAddContact.currentState!.save();
                    if (formKeyAddContact.currentState!.validate()) {
                      //add contact to the list
                      globals.globalSharedContacts.add(newContact);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Add'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  //decorate the button
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BasicProfileCard extends StatelessWidget {
  const BasicProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.indigoAccent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Profile',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${globals.globalUserProfile.name}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text('Email: ${globals.globalUserProfile.email}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text('Postcode: ${globals.globalUserProfile.postcode}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LoginPage(title: 'TrustNet')),
                        );
                      },
                      child: const Text('Log out')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
