import 'package:flutter/material.dart';
import 'package:pickeze/model/profile_model.dart';

//stateless page
class BizPage extends StatelessWidget {
  const BizPage({super.key, required this.bizUserContact});

  final UserContact bizUserContact;

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
            bizUserContact.businessContact?.businessName != null
                ? bizUserContact.businessContact!.businessName
                : 'No Business Name Provided',
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 17, 221)),
          ),
        ),
        bizLineItem("Contact Name", bizUserContact.fullName),
        bizLineItem("Contact Mobile", bizUserContact.mobile),
        bizLineItem(
            "Business Phone", bizUserContact.businessContact?.businessPhone),
        bizLineItem("Email", bizUserContact.businessContact?.email),
        bizLineItem(
            "Address", bizUserContact.businessContact?.headOfficeAddress),
        bizLineItem("ABN", bizUserContact.businessContact?.businessABN),
        bizLineItem("Lincense", bizUserContact.businessContact?.licenseNumber),
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
                )
        ],
      ),
    );
  }
}
