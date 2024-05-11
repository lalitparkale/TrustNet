import 'package:pickeze/globals.dart';

class UserProfile {
  late String name = '';
  late String email = '';
  //String photoUrl;
  late int postcode = 0;
  double lat = 0;
  double lon = 0;

  int isVerified = 0;

  Future<bool> isLocationPermissionGranted = Future.value(false);

  UserProfile({required this.isVerified});
}

class UserContact {
  String fName;
  late String? lName;
  String fullName;
  String mobile;
  int postcode = 0;
  double lat;
  double lon;

  UserContact({
    required this.fName,
    required this.fullName,
    required this.mobile,
    this.lName,
    this.postcode = 0,
    this.lat = 0,
    this.lon = 0,
  });
}

class BusinessContact {
  late String headOfficeAddress;
  late String bizName;
  late String? bizABN;
  late String? bizPhone;
  late String? bizEmail;
  late String? licenseNumber;
  late String? bizContactName;
  late String? bizContactMobile;
  late int postcode = 0;
  late String? servicesTags;
  late String? bizCategory;
  double lat = 0;
  double lon = 0;

  BusinessContact({
    required this.headOfficeAddress,
    required this.bizName,
    this.bizABN,
    this.bizPhone,
    this.bizEmail,
    this.licenseNumber,
    this.bizContactName,
    this.bizContactMobile,
    this.postcode = 0,
    this.servicesTags,
    this.bizCategory,
  });
}

class AusPostcode {
  int id = 0;
  int postcode = 0;
  late String locality;
  late String state;
  double longitude = 0;
  double latitude = 0;

  AusPostcode({
    required this.id,
    required this.postcode,
    required this.locality,
    required this.state,
    required this.longitude,
    required this.latitude,
  });
}

//test data
//TODO: #7
//TODO: https://github.com/lalitparkale/TrustNet/issues/6

List<UserContact> getPooledContacts() {
  return gPooledContacts;

  // List<UserContact> contacts = <UserContact>[];

  // contacts.add(UserContact(
  //   fName: 'Jinendra',
  //   fullName: 'Jinendra C',
  //   mobile: '0478088663',
  //   postcode: 2769,
  // ));

  // contacts.add(UserContact(
  //   fName: 'Pooja',
  //   fullName: 'Pooja R',
  //   mobile: '0451056559',
  //   postcode: 2769,
  // ));

  // contacts.add(UserContact(
  //   fName: 'Nicole',
  //   fullName: 'Nicole T',
  //   mobile: '0497875674',
  //   postcode: 2769,
  // ));

  // contacts.add(UserContact(
  //   fName: 'Shraddha',
  //   fullName: 'Shraddha',
  //   mobile: '0402798778',
  //   postcode: 2769,
  // ));

  // contacts.add(UserContact(
  //   fName: 'Parth',
  //   fullName: 'Parth C',
  //   mobile: '046896248',
  //   postcode: 2769,
  // ));

  // contacts.add(UserContact(
  //   fName: 'Priyanshu',
  //   fullName: 'Priyanshu R',
  //   mobile: '0452304977',
  //   postcode: 2769,
  // ));

  // contacts.add(UserContact(
  //   fName: 'Ramya',
  //   fullName: 'Ramya B',
  //   mobile: '0481218536',
  //   postcode: 2769,
  // ));

  // contacts.add(UserContact(
  //   fName: 'Raj',
  //   fullName: 'Raj J',
  //   mobile: '+61 421 250 792',
  //   postcode: 2564,
  // ));

  // contacts.add(UserContact(
  //   fName: 'Ravi',
  //   fullName: 'Ravi G',
  //   mobile: '+61 428 465 061',
  //   postcode: 2173,
  // ));

  // contacts.add(UserContact(
  //   fName: 'Navneeth',
  //   fullName: 'Navneeth S',
  //   mobile: '+91 80874 59187',
  //   postcode: 2570,
  // ));

  // contacts.add(UserContact(
  //   fName: 'Geeta',
  //   fullName: 'Geeta P',
  //   mobile: '+61 497 229 885',
  //   postcode: 2173,
  // ));

  // contacts.add(UserContact(
  //   fName: 'Rajani',
  //   fullName: 'Rajani B',
  //   mobile: '+61 470 029 601',
  //   postcode: 2170,
  // ));

  // contacts.add(UserContact(
  //   fName: 'Pavan',
  //   fullName: 'Pavan G',
  //   mobile: '+61 405 252 763',
  //   postcode: 2173,
  // ));

  // contacts.add(UserContact(
  //   fName: 'Amaro',
  //   fullName: 'Amaro R',
  //   mobile: '0422354435',
  //   postcode: 2769,
  // ));

  // contacts.add(UserContact(
  //   fName: 'Cedric',
  //   fullName: 'Cedric de P',
  //   mobile: '0477318402',
  //   postcode: 2769,
  // ));

  // contacts.add(UserContact(
  //   fName: 'Stephen',
  //   fullName: 'Stephen L',
  //   mobile: '0405383818',
  //   postcode: 2769,
  // ));

  // contacts.add(UserContact(
  //   fName: 'Ben',
  //   fullName: 'Ben A',
  //   mobile: '0424100575',
  //   postcode: 2769,
  // ));

  // contacts.add(UserContact(
  //   fName: 'Veronika',
  //   fullName: 'Veronika C',
  //   mobile: '0433696906',
  //   postcode: 2769,
  // ));

  // return contacts;
}

List<BusinessContact> getPooledBizContacts() {
  return gPooledBizContacts;

  // List<BusinessContact> bizContacts = <BusinessContact>[];

  // bizContacts.add(BusinessContact(
  //     bizName: 'Hoppy\'s Plumbing',
  //     headOfficeAddress: 'Stratefield, NSW, 2328',
  //     bizABN: '50907943117',
  //     bizEmail: 'hello@hoppysplumbing.com',
  //     licenseNumber: '326759C',
  //     postcode: 2328,
  //     bizContactMobile: '0468461589',
  //     bizContactName: 'Hoppy Plumber',
  //     bizPhone: '',
  //     servicesTags:
  //         'Leak investigation, pumps installation and repair, water lines, dripping taps, burst and leaking pipe repairs, basement waterproofing, hot water tank replacement, leaking toliets, clearing blocked drians '));

  // bizContacts.add(BusinessContact(
  //     bizName: 'Proud Plumbing Pty Ltd.',
  //     headOfficeAddress: 'Padstow, NSW, 2211',
  //     bizABN: '97188954582',
  //     bizEmail: 'proudplumbing.au@gmail.com',
  //     licenseNumber: '334045C',
  //     postcode: 2211,
  //     bizContactMobile: '0431080798',
  //     bizContactName: 'Kris Maha',
  //     bizPhone: '',
  //     servicesTags:
  //         'Blockages, gas, general maintenance renovations, hot water service '));

  // bizContacts.add(BusinessContact(
  //     bizName: 'Super Acts Plumbing Solutions',
  //     headOfficeAddress: '40 Lancelot St, Blacktown, NSW 2148',
  //     bizABN: '19153072187',
  //     bizEmail: 'proudplumbing.au@gmail.com',
  //     licenseNumber: '341659C',
  //     postcode: 2148,
  //     bizContactMobile: '0415211583',
  //     bizContactName: 'Krishna Maha',
  //     bizPhone: '',
  //     servicesTags:
  //         'Grey Water systems, Blocked drains, new drains, drain repairs, general maintenance, grease traps, rain water tank installation, home renovations, hot water unit repairs, hot water unit installation, new homes, toilet installation, toilet repairs, backflow systems, solar hot water, plumbing installation'));

  // bizContacts.add(BusinessContact(
  //     bizName: 'Insight Plumbing Group Pty Ltd',
  //     headOfficeAddress: 'Saratogo, NSW 2251',
  //     bizABN: '86635766371',
  //     bizEmail: 'info@insightplumbinggroup.com.au',
  //     //licenseNumber: '341659C',
  //     postcode: 2251,
  //     bizContactMobile: '1300467448',
  //     bizContactName: 'Krishna Maha',
  //     bizPhone: '',
  //     servicesTags:
  //         'Commercial plumbing, sewer repair and cleaning, toilet repair, tap repair, gas plumbing, blocked drain, hot water repairs'));

  // bizContacts.add(BusinessContact(
  //     bizName: 'AJM Plumbing Solutions',
  //     headOfficeAddress: 'Rouse Hill NSW 2155',
  //     bizABN: '59 654 504 784',
  //     bizEmail: 'info@insightplumbinggroup.com.au',
  //     //licenseNumber: '341659C',
  //     postcode: 2155,
  //     bizContactMobile: '0483958132',
  //     bizContactName: 'Krishna Maha',
  //     bizPhone: '',
  //     servicesTags:
  //         'Blocked Drains, Burst pipes, Gas fitting, Hot water unit repairs/replacements, Ducted heater repairs/replacement, Leak detection, Leaking taps, Toilet repairs/installation, Roof plumbing '));

  // return bizContacts;
}
