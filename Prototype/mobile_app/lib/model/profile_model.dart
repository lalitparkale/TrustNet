class UserProfile {
  late String name = '';
  late String email = '';
  //String photoUrl;
  late int postcode = 0;

  int isVerified = 0;

  UserProfile({required this.isVerified});
}

class UserContact {
  String fName;
  late String lName;
  String fullName;
  String mobile;

  UserContact(
      {required this.fName, required this.fullName, required this.mobile});
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
      fName: 'Tom', fullName: 'Tom Builder', mobile: '07777777781'));

  return contacts;
}

class LabelledContact extends UserContact {
  String tradeCategory;

  LabelledContact(
      {required this.tradeCategory,
      required String fName,
      required String lName,
      required String fullName,
      required String mobile})
      : super(fName: fName, fullName: fullName, mobile: mobile);
}

List<LabelledContact> getLabelledContacts() {
  return <LabelledContact>[];
}
