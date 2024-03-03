class UserProfile {
  late String name = '';
  late String email = '';
  //String photoUrl;
  late int postcode = 0;

  int isVerified = 0;

  Future<bool> isLocationPermissionGranted = Future.value(false);

  UserProfile({required this.isVerified});
}

class UserContact {
  String fName;
  late String? lName;
  String fullName;
  String mobile;
  late BusinessContact? businessContact;

  UserContact(
      {required this.fName,
      required this.fullName,
      required this.mobile,
      this.lName,
      this.businessContact});
}

class BusinessContact {
  late String headOfficeAddress;
  late String businessName;
  late String? businessABN;

  BusinessContact(
      {required this.headOfficeAddress,
      required this.businessName,
      this.businessABN});
}

List<UserContact> getSharedContacts() {
  List<UserContact> contacts = <UserContact>[];

  contacts.add(UserContact(
      fName: 'John', fullName: 'John Smith', mobile: '07777777777'));
  contacts.add(
      UserContact(fName: 'Jane', fullName: 'Jane Doe', mobile: '07777777778'));
  contacts.add(UserContact(
      fName: 'Andy', fullName: 'Andy Plumber', mobile: '07777777779'));
  contacts.add(UserContact(
      fName: 'Sue', fullName: 'Sue Carpenter', mobile: '07777777780'));
  contacts.add(UserContact(
      fName: 'Tom',
      fullName: 'Tom Builder',
      mobile: '07777777781',
      businessContact: BusinessContact(
          businessName: 'Towering Aspirations Pty Ltd.',
          headOfficeAddress: '123 Main St, Syndey, 2000')));

  return contacts;
}

class LabelledContact extends UserContact {
  String tradeCategory;

  LabelledContact(
      {required this.tradeCategory,
      required super.fName,
      required String super.lName,
      required super.fullName,
      required super.mobile,
      super.businessContact});
}

List<LabelledContact> getLabelledContacts() {
  return <LabelledContact>[];
}
