import 'package:flutter/material.dart';
import 'package:pickeze/model/profile_model.dart';

//Busines Contact display page
class BizPage extends StatelessWidget {
  const BizPage({super.key, required this.cBizContact});

  final BusinessContact cBizContact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Details'),
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
            cBizContact.bizName,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 17, 221)),
          ),
        ),
        bizLineItem("Category", cBizContact.bizCategory),
        bizLineItem("Contact Name", cBizContact.bizContactName),
        bizLineItem("Contact Mobile", cBizContact.bizContactMobile),
        bizLineItem("Business Phone", cBizContact.bizPhone),
        bizLineItem("Email", cBizContact.bizEmail),
        bizLineItem("Postcode", cBizContact.postcode.toString()),
        bizLineItem("Address", cBizContact.headOfficeAddress),
        bizLineItem("ABN", cBizContact.bizABN),
        bizLineItem("Lincense", cBizContact.licenseNumber),
        bizLineItem("Services Provided", cBizContact.servicesTags),
      ]),
    );
  }

  Card bizLineItem(String cellTitle, String? cellValue) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            width: 125,
            child: Text(
              '$cellTitle : ',
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ),
          (cellValue != null)
              ? Expanded(
                  child: Text(cellValue,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                )
              : Expanded(
                  child: Text('No $cellTitle Provided',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
          (cellTitle.toLowerCase().contains('mobile'))
              ? Row(children: [
                  IconButton(
                    icon: const Icon(
                      Icons.phone,
                    ),
                    iconSize: 15,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.message,
                    ),
                    iconSize: 15,
                    onPressed: () {},
                  ),
                ])
              : const SizedBox(width: 0, height: 0),
        ],
      ),
    );
  }
}

//stateless page
class FriendContactPage extends StatelessWidget {
  const FriendContactPage({super.key, required this.cFriendContact});

  final UserContact cFriendContact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
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
            cFriendContact.fullName,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 17, 221)),
          ),
        ),
        // friendLineItem("Contact Mobile", cFriendContact.mobile),
        // friendLineItem("Contact Postcode", cFriendContact.postcode.toString()),
        friendLineItem("Contact Mobile", '+***********'),
        friendLineItem("Contact Postcode", '****'),
      ]),
    );
  }

  Card friendLineItem(String cellTitle, String? cellValue) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            width: 125,
            child: Text(
              '$cellTitle : ',
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ),
          (cellValue != null)
              ? Expanded(
                  child: Text(cellValue,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                )
              : Expanded(
                  child: Text('No $cellTitle Provided',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
          (cellTitle.toLowerCase().contains('mobile'))
              ? Row(children: [
                  IconButton(
                    icon: const Icon(
                      Icons.phone,
                    ),
                    iconSize: 15,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.message,
                    ),
                    iconSize: 15,
                    onPressed: () {},
                  ),
                ])
              : const SizedBox(width: 0, height: 0),
        ],
      ),
    );
  }
}
