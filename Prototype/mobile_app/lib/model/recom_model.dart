//import 'package:mobile_app/model/profile_model.dart';
//import package profile_model.dart
import '../model/profile_model.dart';

// class TrustedContactModel {
//   String fName;
//   String lName;
//   String fullName;
//   String mobile;
//   late BusinessContact? businessContact;

//   TrustedContactModel(
//       {required this.fName,
//       required this.lName,
//       required this.fullName,
//       required this.mobile,
//       this.businessContact});

//   TrustedContactModel.fromJson(Map<String, dynamic> json)
//       : fName = json['fName'] as String,
//         lName = json['lName'] as String,
//         fullName = json['fullName'] as String,
//         mobile = json['mobile'] as String;

//   Map<String, dynamic> toJson() => {
//         'fName': fName,
//         'lName': lName,
//         'fullName': fullName,
//         'mobile': mobile,
//       };
// }

class RecommendationModel {
  UserContact recommender;
  UserContact referee;

  RecommendationModel({required this.recommender, required this.referee});

  static List<RecommendationModel> getRecommendations() {
    List<RecommendationModel> ret = <RecommendationModel>[];

    RecommendationModel rec1 = RecommendationModel(
      recommender: UserContact(
          fName: 'John',
          lName: 'Doe',
          fullName: 'John Doe',
          mobile: '08012345678'),
      referee: UserContact(
          fName: 'Jane',
          lName: 'Doe',
          fullName: 'Jane Doe',
          mobile: '08012345678'),
    );

    RecommendationModel rec2 = RecommendationModel(
      recommender: UserContact(
          fName: 'Ocean',
          lName: 'Mcdonald',
          fullName: 'Ocean Mcdonald',
          mobile: '0912345678'),
      referee: UserContact(
          fName: 'Ace',
          lName: 'Able',
          fullName: 'Ace Able Trades',
          mobile: '07901234567'),
    );

    RecommendationModel rec3 = RecommendationModel(
      recommender: UserContact(
          fName: 'Ram',
          lName: 'Ramayan',
          fullName: 'Ram Ramayan',
          mobile: '06034567890'),
      referee: UserContact(
          fName: 'Hoppy',
          lName: 'Plumber',
          fullName: 'Hoppy\'s Plumbing',
          mobile: '0468461589',
          businessContact: BusinessContact(
            businessName: 'Hoppy\'s Plumbing',
            headOfficeAddress: 'Stratefield, NSW, 2328',
            businessABN: '50907943117',
            email: 'hello@hoppysplumbing.com',
            licenseNumber: '326759C',
          )),
    );

    RecommendationModel rec4 = RecommendationModel(
      recommender: UserContact(
          fName: 'Trina',
          lName: 'McDonald',
          fullName: 'Trina McDonald',
          mobile: '06034567890'),
      referee: UserContact(
          fName: 'Krishna',
          lName: 'Mahabharat',
          fullName: 'Proud Plumbing',
          mobile: '0431080798',
          businessContact: BusinessContact(
              businessName: 'Proud Plumbing Pty Ltd.',
              headOfficeAddress: 'Padstow, NSW, 2211',
              businessABN: '97188954582',
              email: 'proudplumbing.au@gmail.com',
              licenseNumber: '334045C')),
    );

    RecommendationModel rec5 = RecommendationModel(
      recommender: UserContact(
          fName: 'Luke',
          lName: 'Parcel',
          fullName: 'Luke Parcel',
          mobile: '06034567890'),
      referee: UserContact(
          fName: 'Krishna',
          lName: 'Mahabharat',
          fullName: 'Super Acts Plumbing',
          mobile: '0415211583',
          businessContact: BusinessContact(
              businessName: 'Super Acts Plumbing Solutions',
              headOfficeAddress: '40 Lancelot St, Blacktown, NSW 2148',
              businessABN: '19153072187',
              email: 'proudplumbing.au@gmail.com',
              licenseNumber: '341659C')),
    );

    RecommendationModel rec6 = RecommendationModel(
      recommender: UserContact(
          fName: 'Rob',
          lName: 'Rake',
          fullName: 'Rob Rake',
          mobile: '06034567890'),
      referee: UserContact(
          fName: 'Krishna',
          lName: 'Mahabharat',
          fullName: 'Insight Plumbing',
          mobile: '1300467448',
          businessContact: BusinessContact(
            businessName: 'Insight Plumbing Group Pty Ltd',
            headOfficeAddress: 'Saratogo, NSW 2251',
            businessABN: '86635766371',
            email: 'info@insightplumbinggroup.com.au',
          )),
    );

    RecommendationModel rec7 = RecommendationModel(
      recommender: UserContact(
          fName: 'Rob',
          lName: 'Rake',
          fullName: 'Rob Rake',
          mobile: '06034567890'),
      referee: UserContact(
          fName: 'Krishna',
          lName: 'Mahabharat',
          fullName: 'Insight Plumbing',
          mobile: '1300467448',
          businessContact: BusinessContact(
            businessName: 'Insight Plumbing Group Pty Ltd',
            headOfficeAddress: 'Saratogo, NSW 2251',
            businessABN: '86635766371',
            email: 'info@insightplumbinggroup.com.au',
          )),
    );

    ret.add(rec1);
    ret.add(rec2);
    ret.add(rec3);
    ret.add(rec4);
    ret.add(rec5);
    ret.add(rec6);
    ret.add(rec7);

    //return <RecommendationModel>[rec1, rec2, rec3];
    return ret;
  }
}
