//import 'package:mobile_app/model/profile_model.dart';
//import package profile_model.dart
import 'package:pickeze/globals.dart';
import '../model/profile_model.dart';

class RecommendationModel {
  BusinessContact tradie;
  UserContact recommendedBy;

  RecommendationModel({required this.tradie, required this.recommendedBy});

  static Map<double, BusinessContact> getNearestBizContacts() {
    //1. get LatLon for all pooled contacts
    //2. get distance from user's postcode for each pooled contact
    //3. sort the contacts by distance
    //4. return the sorted list

    Map<double, BusinessContact> distMap = <double, BusinessContact>{};

    for (var i = 0; i < gPooledBizContacts.length; i++) {
      double dist = getDistanceFromLatLonInKm(
          gUserProfile.lat,
          gUserProfile.lon,
          gPooledBizContacts[i].lat,
          gPooledBizContacts[i].lon);

      distMap[dist] = gPooledBizContacts[i];
    }

    //var sortedKeys = distMap.values.toList()..sort();
    final sortedMap = Map.fromEntries(
      distMap.entries.toList()
        ..sort(
          (e1, e2) => e1.key.compareTo(e2.key),
        ),
    );

    return sortedMap;
  }

  static List<RecommendationModel> getRecommendations() {
    List<RecommendationModel> ret = <RecommendationModel>[];

    List<double> userLatLon = getLatLonfromPostCode(gUserProfile.postcode);
    gUserProfile.lat = userLatLon[0];
    gUserProfile.lon = userLatLon[1];

    Map<double, BusinessContact> bizContactMap = getNearestBizContacts();

    // if bizContactMap.length > 25, then limit to 25
    var len = (bizContactMap.length > 25) ? 25 : bizContactMap.length;
    var bizcontacts = bizContactMap.values.toList();
    for (var i = 0; i < len; i++) {
      ret.add(RecommendationModel(
          tradie: bizcontacts[i],
          recommendedBy: gPooledContacts[i % gPooledContacts.length]));
    }

    // RecommendationModel rec1 = RecommendationModel(
    //   recommender: UserContact(
    //       fName: 'John',
    //       lName: 'Doe',
    //       fullName: 'John Doe',
    //       mobile: '08012345678'),
    //   referee: UserContact(
    //       fName: 'Jane',
    //       lName: 'Doe',
    //       fullName: 'Jane Doe',
    //       mobile: '08012345678'),
    // );

    // RecommendationModel rec2 = RecommendationModel(
    //   recommender: UserContact(
    //       fName: 'Ocean',
    //       lName: 'Mcdonald',
    //       fullName: 'Ocean Mcdonald',
    //       mobile: '0912345678'),
    //   referee: UserContact(
    //       fName: 'Ace',
    //       lName: 'Able',
    //       fullName: 'Ace Able Trades',
    //       mobile: '07901234567'),
    // );

    // RecommendationModel rec3 = RecommendationModel(
    //   recommender: UserContact(
    //       fName: 'Ram',
    //       lName: 'Ramayan',
    //       fullName: 'Ram Ramayan',
    //       mobile: '06034567890'),
    //   referee: UserContact(
    //     fName: 'Hoppy',
    //     lName: 'Plumber',
    //     fullName: 'Hoppy\'s Plumbing',
    //     mobile: '0468461589',
    //   ),
    // );

    // RecommendationModel rec4 = RecommendationModel(
    //     recommender: UserContact(
    //         fName: 'Trina',
    //         lName: 'McDonald',
    //         fullName: 'Trina McDonald',
    //         mobile: '06034567890'),
    //     referee: UserContact(
    //       fName: 'Krishna',
    //       lName: 'Mahabharat',
    //       fullName: 'Proud Plumbing',
    //       mobile: '0431080798',
    //     ));

    // RecommendationModel rec5 = RecommendationModel(
    //   recommender: UserContact(
    //       fName: 'Luke',
    //       lName: 'Parcel',
    //       fullName: 'Luke Parcel',
    //       mobile: '06034567890'),
    //   referee: UserContact(
    //     fName: 'Krishna',
    //     lName: 'Mahabharat',
    //     fullName: 'Super Acts Plumbing',
    //     mobile: '0415211583',
    //   ),
    // );

    // RecommendationModel rec6 = RecommendationModel(
    //   recommender: UserContact(
    //       fName: 'Rob',
    //       lName: 'Rake',
    //       fullName: 'Rob Rake',
    //       mobile: '06034567890'),
    //   referee: UserContact(
    //     fName: 'Krishna',
    //     lName: 'Mahabharat',
    //     fullName: 'Insight Plumbing',
    //     mobile: '1300467448',
    //   ),
    // );

    // RecommendationModel rec7 = RecommendationModel(
    //   recommender: UserContact(
    //       fName: 'Rob',
    //       lName: 'Rake',
    //       fullName: 'Rob Rake',
    //       mobile: '06034567890'),
    //   referee: UserContact(
    //     fName: 'Krishna',
    //     lName: 'Mahabharat',
    //     fullName: 'Insight Plumbing',
    //     mobile: '1300467448',
    //   ),
    // );

    // ret.add(rec1);
    // ret.add(rec2);
    // ret.add(rec3);
    // ret.add(rec4);
    // ret.add(rec5);
    // ret.add(rec6);
    // ret.add(rec7);

    //return <RecommendationModel>[rec1, rec2, rec3];
    return ret;
  }
}
