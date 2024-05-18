import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickeze/globals.dart';
import '../pages/screen_lib.dart';
import '../globals.dart' as globals;
import '../model/profile_model.dart';

//create profile screen
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void init() {
    //load all my friends contacts from already loaded gAllBizContacts from gUsedServicesMap
    gFriendsMap[gUserProfile.id]?.forEach((fid) {
      try {
        gSharedContacts
            .add(gAllUsers.where((element) => element.id == fid).first);
      } catch (e) {
        print('Error: $e');
      }
    });

    //load all shared Business contacts from already loaded gAllBizContacts from gUsedServicesMap
    gUsedServicesMap[gUserProfile.id]?.forEach((bid) {
      try {
        gSharedBizContacts
            .add(gAllBizContacts.where((element) => element.id == bid).first);
      } catch (e) {
        print('Error: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    init();
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
            'Shared Tradies Contacts',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigoAccent.withOpacity(0.5),
              ),
              onPressed: () {
                addBizContactDialogBuilder(context);
              },
              child: const Text(
                'Add Contact',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
                  sortColumnIndex: 1,
                  sortAscending: true,
                  showCheckboxColumn: false,
                  headingTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    //color: Colors.white,
                  ),
                  columns: const [
                    DataColumn(label: Text('Feedback')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Mobile')),
                    DataColumn(label: Text('Category')),
                    DataColumn(label: Text('Postcode')),
                  ],
                  rows: [
                    for (var contact in globals.gSharedBizContacts)
                      DataRow(
                        cells: [
                          DataCell(IconButton(
                            icon: const Icon(Icons.feedback),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FeedbackPage(
                                        bid: contact.id, uid: gUserProfile.id)),
                              );
                            },
                          )),
                          DataCell(Text(contact.bizName,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal))),
                          DataCell(Text(contact.bizContactMobile ?? '',
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
      id: 0,
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
              hintStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic),
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
                hintText: 'Mobile number',
                hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic)),
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
              hintStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic),
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
              hintText: 'Select Business Category',
              hintStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic),
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
                      newBizContact.id = getUniqueBizID();
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
                  child: const Text('Add',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
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
                  child: const Text('Cancel',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
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
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigoAccent.withOpacity(0.5),
              ),
              onPressed: () {
                addContactDialogBuilder(context);
              },
              child: const Text(
                'Add Contact',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
                  showCheckboxColumn: false,
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
    UserContact newContact =
        UserContact(id: 0, fName: '', fullName: '', mobile: '');

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
              hintStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic),
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
              hintStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic),
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
              hintStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic),
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
                      newContact.id = getUniqueUserID();
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
                  child: const Text('Add',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
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
                  child: const Text('Cancel',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
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
      child: const Column(
        children: [
          //display user profile
          Icon(
            Icons.person,
            size: 64,
            color: Colors.indigo,
            shadows: [Shadow(color: Colors.blue, blurRadius: 10)],
          ),

          FormUserProfile(),

          //SizedBox(height: 10),
          //
          // TextButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) =>
          //                 const LoginPage(title: 'Pickeze Login')),
          //       );
          //     },
          //     child: const Text('Log out')),
        ],
      ),
    );
  }
}

class FormUserProfile extends StatefulWidget {
  const FormUserProfile({super.key});

  @override
  State<FormUserProfile> createState() => FormUserProfileState();
}

class FormUserProfileState extends State<FormUserProfile> {
  final GlobalKey<FormState> formKeyProfile = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //UserContact newContact = UserContact(fName: '', fullName: '', mobile: '');

    return Form(
      key: formKeyProfile,
      child: Column(
        children: [
          TextFormField(
            controller: TextEditingController()..text = gUserProfile.name,
            onSaved: (newValue) {
              gUserProfile.name = newValue!;
            },
            decoration: const InputDecoration(
              hintText: 'Full Name',
              hintStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic),
              labelText: 'Full Name',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter full name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: TextEditingController()..text = gUserProfile.mobile,
            onSaved: (newValue) {
              gUserProfile.mobile = newValue!;
            },
            decoration: const InputDecoration(
              hintText: 'Enter mobile number as 04*******',
              hintStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic),
              labelText: 'Mobile',
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[+0-9]')),
            ],
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter mobile number';
              }
              return null;
            },
          ),
          TextFormField(
            controller: TextEditingController()
              ..text = gUserProfile.postcode.toString(),
            onSaved: (newValue) {
              if ((newValue != null) && (newValue.isNotEmpty)) {
                gUserProfile.postcode = int.parse(newValue);
              }
            },
            decoration: const InputDecoration(
              hintText: 'Postcode',
              hintStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic),
              labelText: 'Postcode',
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            ],
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your post code';
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
                    formKeyProfile.currentState!.save();
                    if (formKeyProfile.currentState!.validate()) {
                      //before saving the profile check if the user is already
                      //in the db based on the mobile number as key
                      bool ret = findUIDforProfile(gUserProfile.mobile);
                      if (ret == false) {
                        //if not found then assign a new ID
                        gUserProfile.id = getUniqueUserID();
                      }
                      //save user profile to db
                      saveUserProfile();

                      //if ID has not found then notify user what it means
                      if (ret == false) {
                        //show user message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'It seems your mobile number is not registered for this pilot. Please ensure mobile is entered starting with a \'0\', like 04********',
                            ),
                            backgroundColor: Colors.black.withOpacity(1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            showCloseIcon: true,
                            duration: const Duration(seconds: 10),
                          ),
                        );
                      }

                      //show user message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'Profile saved',
                          ),
                          backgroundColor: Colors.indigoAccent.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          showCloseIcon: true,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//Feedback display page
class FeedbackPage extends StatelessWidget {
  FeedbackPage({super.key, required this.bid, required this.uid});

  final int bid;
  final int uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback for Business'),
      ),
      body: ListView(children: [
        Container(
          height: 50,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.indigoAccent.withOpacity(0.6),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            //bc!.bizName,
            gAllBizContacts.where((element) => element.id == bid).first.bizName,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 17, 221)),
          ),
        ),
        FormFeedback(
          bid: bid,
          uid: gUserProfile.id,
        ),
      ]),
    );
  }
}

//stateful form widget to get and display feedback
class FormFeedback extends StatefulWidget {
  FormFeedback({super.key, required this.bid, required this.uid});

  final int bid;
  final int uid;

  @override
  State<FormFeedback> createState() => FormFeedbackState();
} //FormFeedback

class FormFeedbackState extends State<FormFeedback> {
  final GlobalKey<FormState> formKeyFeedback = GlobalKey<FormState>();

  BusinessContact? bc;
  UserContact? uc;
  BizFeedback? fb;

  //set state
  void setFeedbackState() {
    setState(() {
      //fb = gAllFeedbackMap[widget.uid]?[widget.bid];
    });
  }

  //init function
  @override
  void initState() {
    //get Business contact from bid
    bc = gAllBizContacts.where((element) => element.id == widget.bid).first;

    //get User contact from uid
    uc = gAllUsers.where((element) => element.id == widget.uid).first;

    fb = (gAllFeedbackMap[widget.uid] == null)
        ? fb = BizFeedback(
            id: 1, comments: '', workType: '', workDate: DateTime.now())
        : (gAllFeedbackMap[widget.uid]?[widget.bid] == null)
            ? fb = BizFeedback(
                id: 1, comments: '', workType: '', workDate: DateTime.now())
            : gAllFeedbackMap[widget.uid]?[widget.bid];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyFeedback,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: TextEditingController()..text = fb!.comments!,
              onSaved: (newValue) {
                fb!.comments = newValue!;
              },
              keyboardType: TextInputType.multiline,
              style: const TextStyle(fontSize: 12),
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Feedback that will help your friends...',
                hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic),
                labelText: 'Comments',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your comments';
                }
                return null;
              },
            ),
            TextFormField(
              controller: TextEditingController()..text = fb!.workType!,
              onSaved: (newValue) {
                fb!.workType = newValue!;
              },
              style: const TextStyle(fontSize: 12),
              decoration: const InputDecoration(
                hintText: 'e.g. fixed plumbing, indoor tilings, etc.',
                hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic),
                labelText: 'Type of work done',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter type of work done';
                }
                return null;
              },
            ),
            TextFormField(
              controller: TextEditingController()
                ..text = (fb!.workDate != null)
                    ? '${fb!.workDate!.month}\\${fb!.workDate!.year.toString()}'
                    : '',
              onSaved: (newValue) {
                (newValue != '')
                    ? (() {
                        DateTime dt;
                        try {
                          dt = DateTime.parse(newValue!);
                        } catch (e) {
                          print('Error: $e');
                          dt = DateTime.now();
                        }
                        fb!.workDate = DateTime(dt.year, dt.month, dt.day);
                      })
                    : null;
              },
              inputFormatters: [
                FilteringTextInputFormatter(RegExp('[0-9\\0-9]'), allow: true)
              ],
              style: const TextStyle(fontSize: 12),
              decoration: const InputDecoration(
                hintText: 'e.g. 04/2024 etc.',
                hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic),
                labelText: 'Month and year of work done',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty || value == 'null') {
                  return 'Please enter date of work done';
                }
                return null;
              },
            ),
            LineItem(
                label: labelQuality,
                fbs: fb!.workQuality,
                bid: widget.bid,
                uid: widget.uid),
            LineItem(
                label: labelPrice,
                fbs: fb!.workPrice,
                bid: widget.bid,
                uid: widget.uid),
            LineItem(
                label: labelProfessionalism,
                fbs: fb!.workProfessionalism,
                bid: widget.bid,
                uid: widget.uid),
            LineItem(
                label: labelCommitment,
                fbs: fb!.workTimeCommitment,
                bid: widget.bid,
                uid: widget.uid),
            LineItem(
                label: labelCommunication,
                fbs: fb!.workCommunication,
                bid: widget.bid,
                uid: widget.uid),
            LineItem(
                label: labelTransparency,
                fbs: fb!.workTransparency,
                bid: widget.bid,
                uid: widget.uid),
            Text('Feedback Date: ${fb!.feedbackDate}'),
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
                      formKeyFeedback.currentState!.save();
                      if (formKeyFeedback.currentState!.validate()) {
                        //save user profile to db
                        //saveUserProfile();

                        //show user message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Feedback saved',
                            ),
                            backgroundColor: Colors.blueAccent.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            showCloseIcon: true,
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.indigo),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget sentimentItemWidget(
  //     String label, FeedbackSentiment fb, int bid, int uid) {
  //   return
  // }
}

//stateful class for lineitem
class LineItem extends StatefulWidget {
  LineItem(
      {super.key,
      required this.label,
      required this.fbs,
      required this.bid,
      required this.uid});

  final String label;
  FeedbackSentiment fbs;
  int bid;
  int uid;

  @override
  State<LineItem> createState() => LineItemState();
}

class LineItemState extends State<LineItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            width: 100,
            child: Text(
              widget.label,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            )),
        IconButton(
          icon: Icon(Icons.favorite,
              color: (widget.fbs == FeedbackSentiment.awesome)
                  ? Colors.green
                  : Colors.grey),
          onPressed: () {
            widget.fbs = FeedbackSentiment.awesome;
            if (gAllFeedbackMap[widget.uid] == null) {
              gAllFeedbackMap[widget.uid] = {};
            }
            if (gAllFeedbackMap[widget.uid]![widget.bid] == null) {
              gAllFeedbackMap[widget.uid]![widget.bid] = BizFeedback(
                  id: 1, comments: '', workType: '', workDate: DateTime.now());
            }
            switch (widget.label) {
              case labelQuality:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workQuality =
                    widget.fbs;
                break;
              case labelPrice:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workPrice =
                    widget.fbs;
                break;
              case labelProfessionalism:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workProfessionalism =
                    widget.fbs;
                break;
              case labelCommitment:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workTimeCommitment =
                    widget.fbs;
                break;
              case labelCommunication:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workCommunication =
                    widget.fbs;
                break;
              case labelTransparency:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workTransparency =
                    widget.fbs;
                break;
            }
            setState(() {
              widget.fbs = FeedbackSentiment.awesome;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.thumb_up,
              color: (widget.fbs == FeedbackSentiment.good)
                  ? Colors.yellow
                  : Colors.grey),
          onPressed: () {
            widget.fbs = FeedbackSentiment.good;
            if (gAllFeedbackMap[widget.uid] == null) {
              gAllFeedbackMap[widget.uid] = {};
            }
            if (gAllFeedbackMap[widget.uid]![widget.bid] == null) {
              gAllFeedbackMap[widget.uid]![widget.bid] = BizFeedback(
                  id: 1, comments: '', workType: '', workDate: DateTime.now());
            }
            switch (widget.label) {
              case labelQuality:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workQuality =
                    widget.fbs;
                break;
              case labelPrice:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workPrice =
                    widget.fbs;
                break;
              case labelProfessionalism:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workProfessionalism =
                    widget.fbs;
                break;
              case labelCommitment:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workTimeCommitment =
                    widget.fbs;
                break;
              case labelCommunication:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workCommunication =
                    widget.fbs;
                break;
              case labelTransparency:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workTransparency =
                    widget.fbs;
                break;
            }
            setState(() {
              widget.fbs = FeedbackSentiment.good;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.thumb_down,
              color: (widget.fbs == FeedbackSentiment.bad)
                  ? Colors.red
                  : Colors.grey),
          onPressed: () {
            widget.fbs = FeedbackSentiment.bad;
            if (gAllFeedbackMap[widget.uid] == null) {
              gAllFeedbackMap[widget.uid] = {};
            }
            if (gAllFeedbackMap[widget.uid]![widget.bid] == null) {
              gAllFeedbackMap[widget.uid]![widget.bid] = BizFeedback(
                  id: 1, comments: '', workType: '', workDate: DateTime.now());
            }
            switch (widget.label) {
              case labelQuality:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workQuality =
                    widget.fbs;
                break;
              case labelPrice:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workPrice =
                    widget.fbs;
                break;
              case labelProfessionalism:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workProfessionalism =
                    widget.fbs;
                break;
              case labelCommitment:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workTimeCommitment =
                    widget.fbs;
                break;
              case labelCommunication:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workCommunication =
                    widget.fbs;
                break;
              case labelTransparency:
                gAllFeedbackMap[widget.uid]![widget.bid]!.workTransparency =
                    widget.fbs;
                break;
            }
            setState(() {
              widget.fbs = FeedbackSentiment.bad;
            });
          },
        ),
      ],
    );
  }
}
