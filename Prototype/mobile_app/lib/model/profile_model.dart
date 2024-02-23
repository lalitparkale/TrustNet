class UserProfile {
  String name;
  String email;
  //String photoUrl;

  UserProfile({required this.name, required this.email});
}

class UserContact {
  String fName;
  String lName;
  String fullName;
  String mobile;

  UserContact(
      {required this.fName,
      required this.lName,
      required this.fullName,
      required this.mobile});
}

List<UserContact> getContacts() {
  return <UserContact>[];
}

class LabelledContact extends UserContact {
  String tradeCategory;

  LabelledContact(
      {required this.tradeCategory,
      required String fName,
      required String lName,
      required String fullName,
      required String mobile})
      : super(fName: fName, lName: lName, fullName: fullName, mobile: mobile);
}

List<LabelledContact> getLabelledContacts() {
  return <LabelledContact>[];
}
