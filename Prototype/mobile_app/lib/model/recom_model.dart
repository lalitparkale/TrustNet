//import 'package:mobile_app/model/profile_model.dart';
//import package profile_model.dart
import 'package:pickeze/globals.dart';
import 'package:pickeze/model/search_model.dart';
import '../model/profile_model.dart';

class RecommendationModel {
  BusinessContact tradie;
  UserContact recommendedBy;

  RecommendationModel({required this.tradie, required this.recommendedBy});

  static Map<BusinessContact, double> getNearestBizContacts() {
    //1. get LatLon for all pooled contacts
    //2. get distance from user's postcode for each pooled contact
    //3. sort the contacts by distance
    //4. return the sorted list

    Map<BusinessContact, double> distMap = <BusinessContact, double>{};

    for (var i = 0; i < gPooledBizContacts.length; i++) {
      double dist = getDistanceFromLatLonInKm(
          gUserProfile.lat,
          gUserProfile.lon,
          gPooledBizContacts[i].lat,
          gPooledBizContacts[i].lon);

      distMap.addEntries([MapEntry(gPooledBizContacts[i], dist)]);
    }

    //var sortedKeys = distMap.values.toList()..sort();
    final sortedMap = Map.fromEntries(
      distMap.entries.toList()
        ..sort(
          //(e1, e2) => e1.key.compareTo(e2.key),
          (e1, e2) => e1.value.compareTo(e2.value),
        ),
    );

    return sortedMap;
  }

  static List<RecommendationModel> getRecommendations() {
    List<RecommendationModel> ret = <RecommendationModel>[];

    List<String> categories = [
      'plumber',
      'electrician',
      'carpenter',
      'painter',
      'gardener',
      'cleaner',
      'handyman',
      'builder',
      'tiler',
      'landscaper',
      'bricklayer',
      'concreter',
      'fencer',
      'glazier',
      'kitchen',
      'bathroom',
      'laundry',
      'roofing',
      'security',
      'solar',
      'windows',
      'doors',
      'awnings',
      'blinds',
      'curtains',
      'shutters',
      'furniture',
      'appliances',
      'aircon',
      'pest',
      'removalist',
      'mover',
      'mechanic'
    ];

    // extract the trade category from search string
    List<String> searchedCategories = [];
    for (var i = 0; i < categories.length; i++) {
      if (SearchModel.getSearchText().toLowerCase().contains(categories[i])) {
        searchedCategories.add(categories[i]);
      }
    }

    List<double> userLatLon = getLatLonfromPostCode(gUserProfile.postcode);
    gUserProfile.lat = userLatLon[0];
    gUserProfile.lon = userLatLon[1];

    Map<BusinessContact, double> bizContactMap = getNearestBizContacts();

    // if bizContactMap.length > 25, then limit to 25
    var len = (bizContactMap.length > 10) ? 10 : bizContactMap.length;
    var bizcontacts = bizContactMap.keys.toList();
    int i = 0;
    for (var keyT in bizcontacts) {
      if (i >= len) {
        break;
      }
      //include as recommendation only if the trade category matches
      for (var j = 0; j < searchedCategories.length; j++) {
        if (keyT.bizCategory!.toLowerCase().contains(searchedCategories[j])) {
          ret.add(RecommendationModel(
              tradie: keyT,
              recommendedBy: gPooledContacts[i % gPooledContacts.length]));
          i++;
          break;
        }
      }
    }

    return ret;
  }
}
