import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          SharedBizContactsTile(),
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

class SharedBizContactsTile extends StatelessWidget {
  const SharedBizContactsTile({
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
            'Shared Business Contacts',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: ElevatedButton(
              onPressed: () {
                addBizContactDialogBuilder(context);
              },
              child: const Text(
                'Add Contact',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Container(
            height: 250,
            padding: const EdgeInsets.all(2),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              //physics: const AlwaysScrollableScrollPhysics(),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  sortColumnIndex: 0,
                  sortAscending: true,
                  //showCheckboxColumn: true,
                  headingTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    //color: Colors.white,
                  ),
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Mobile')),
                    DataColumn(label: Text('Category')),
                    DataColumn(label: Text('Postcode')),
                  ],
                  rows: [
                    for (var contact in globals.gSharedBizContacts)
                      DataRow(
                        cells: [
                          DataCell(Text(contact.bizName,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal))),
                          DataCell(Text(contact.bizContactMobile!,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal))),
                          DataCell(Text(contact.bizCategory!,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal))),
                          DataCell(Text(contact.postcode.toString(),
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal))),
                        ],
                        onSelectChanged: (newValue) {
                          //do something
                          if (newValue == true) {}
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 1),
        ],
      ),
    );
  }
}

Future<void> addBizContactDialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return const AlertDialog(
        title: Text('Add contact'),
        actions: <Widget>[
          FormAddBizContact(),
        ],
      );
    },
  );
}

class FormAddBizContact extends StatefulWidget {
  const FormAddBizContact({super.key});

  @override
  State<FormAddBizContact> createState() => FormAddBizContactState();
}

class FormAddBizContactState extends State<FormAddBizContact> {
  final GlobalKey<FormState> formKeyAddContact = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    BusinessContact newBizContact = BusinessContact(
      bizName: '',
      bizContactName: '',
      bizContactMobile: '',
      bizPhone: '',
      bizEmail: '',
      headOfficeAddress: '',
      bizABN: '',
      licenseNumber: '',
      servicesTags: '',
      postcode: 0,
    );

    return Form(
      key: formKeyAddContact,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Contact Name',
            ),
            onSaved: (newValue) {
              newBizContact.bizName = newValue!;
              newBizContact.bizContactName = newValue;
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter name';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Mobile',
            ),
            onSaved: (newValue) {
              newBizContact.bizContactMobile = newValue!;
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            ],
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter mobile number';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Business postcode',
            ),
            onSaved: (newValue) {
              newBizContact.postcode = int.parse(newValue!);
              newBizContact.headOfficeAddress = newValue;
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            ],
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter general postcode for business';
              }
              return null;
            },
          ),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              hintText: 'Business Category',
            ),
            items: globals.gCategories
                .map((String category) => DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    ))
                .toList(),
            validator: (value) =>
                value == null ? 'Please select a category' : null,
            onChanged: (String? value) {
              newBizContact.bizCategory = value!;
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
                      globals.gSharedBizContacts.add(newBizContact);
                      saveSharedBizContacts();

                      //navigate to profile page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()),
                      );
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
                    //Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()),
                    );
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
            'Friends Contacts',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: ElevatedButton(
              onPressed: () {
                addContactDialogBuilder(context);
              },
              child: const Text(
                'Add Contact',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Container(
            height: 250,
            padding: const EdgeInsets.all(2),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  sortColumnIndex: 0,
                  sortAscending: true,
                  //showCheckboxColumn: true,
                  headingTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
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
                          DataCell(Text(contact.fullName,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal))),
                          DataCell(Text(contact.mobile,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal))),
                        ],
                        onSelectChanged: (newValue) {
                          //do something
                          if (newValue == true) {}
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 1),
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
              newContact.lName = newValue!;
              newContact.fullName = '${newContact.fName} $newValue';
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
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            ],
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
                      saveSharedContacts();

                      //navigate to profile page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()),
                      );
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
                    //Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()),
                    );
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
        color: Colors.indigoAccent.withOpacity(0.3),
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
          if (cellValue != null)
            Expanded(
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
                  onSubmitted: (value) {
                    //save user profile to db
                    if (cellTitle == 'Name') {
                      gUserProfile.name = value;
                    } else if (cellTitle == 'Email') {
                      gUserProfile.email = value;
                    } else if (cellTitle == 'Postcode') {
                      gUserProfile.postcode = int.parse(value);
                    }
                    saveUserProfile();
                  },
                ),
              ),
            )
          else
            Expanded(
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
