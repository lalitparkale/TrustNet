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
          fName: 'Krishna',
          lName: 'Mahabharat',
          fullName: 'Krishna Mahabharat',
          mobile: '06098765432',
          businessContact: BusinessContact(
              businessName: 'Niti Pty Ltd.',
              headOfficeAddress: '123 Main St, Syndey, 2000')),
    );

    ret.add(rec1);
    ret.add(rec2);
    ret.add(rec3);

    //return <RecommendationModel>[rec1, rec2, rec3];
    return ret;
  }
}
