import 'package:flutter/material.dart';
import 'package:pickeze/globals.dart';
import '../pages/login.dart';
import '../pages/screen_lib.dart';
import '../globals.dart' as globals;
import '../model/profile_model.dart';

//create profile screen
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        children: const [
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
                for (var contact in globals.gSharedContacts)
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
                      globals.gSharedContacts.add(newContact);
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
        children: [
          //display user profile
          const Icon(
            Icons.person,
            size: 64,
            color: Colors.indigo,
            shadows: [Shadow(color: Colors.blue, blurRadius: 10)],
          ),
          profileLineItem('Name', globals.gUserProfile.name),
          profileLineItem('Email', globals.gUserProfile.email),
          profileLineItem('Postcode', globals.gUserProfile.postcode.toString()),
          // Text('Name: ${globals.gUserProfile.name}',
          //     style: const TextStyle(fontSize: 16)),
          // const SizedBox(
          //   height: 4,
          // ),
          // Text('Email: ${globals.gUserProfile.email}',
          //     style: const TextStyle(fontSize: 16)),
          // const SizedBox(
          //   height: 4,
          // ),
          // const Text('Postcode: ', style: TextStyle(fontSize: 16)),
          // TextField(
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(),
          //     labelText: globals.gUserProfile.postcode.toString(),
          //   ),
          // ),
          const SizedBox(height: 10),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginPage(title: 'Pickeze')),
                );
              },
              child: const Text('Log out')),
        ],
      ),
    );
  }

  Card profileLineItem(String cellTitle, String? cellValue) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          // Text(
          //   '$cellTitle : ',
          //   style: const TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
          // ),
          (cellValue != null)
              ? Expanded(
                  // child: Text(cellValue,
                  //     style: const TextStyle(
                  //         fontSize: 14, fontWeight: FontWeight.bold)),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal),
                      controller: TextEditingController()..text = cellValue,
                      decoration: InputDecoration(
                        labelText: cellTitle,
                        //helperText: cellTitle,
                        labelStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),

                        enabledBorder: InputBorder.none,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                      onSubmitted: (value) => (cellTitle == 'Name')
                          ? gUserProfile.name = value
                          : (cellTitle == 'Email')
                              ? gUserProfile.email = value
                              : (cellTitle == 'Postcode')
                                  ? gUserProfile.postcode = int.parse(value)
                                  : gUserProfile.postcode,
                    ),
                  ),
                )
              : Expanded(
                  child: Text('No $cellTitle Provided',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
        ],
      ),
    );
  }
}
