//import 'package:mobile_app/model/profile_model.dart';
//import package profile_model.dart
import 'package:pickeze/globals.dart';
import '../model/profile_model.dart';

Map<BusinessContact, double> getNearestBizContacts() {
  //1. get LatLon for all pooled contacts
  //2. get distance from user's postcode for each pooled contact
  //3. sort the contacts by distance
  //4. return the sorted list

  Map<BusinessContact, double> distMap = <BusinessContact, double>{};

  var latlon = getLatLonfromPostCode(gUserProfile.postcode);
  gUserProfile.lat = latlon[0];
  gUserProfile.lon = latlon[1];

  for (var i = 0; i < gAllBizContacts.length; i++) {
    double dist = getDistanceFromLatLonInKm(gUserProfile.lat, gUserProfile.lon,
        gAllBizContacts[i].lat, gAllBizContacts[i].lon);

    distMap.addEntries([MapEntry(gAllBizContacts[i], dist)]);
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

List<RecommendationModel> getRecommendations() {
  List<RecommendationModel> ret = <RecommendationModel>[];

  // extract the trade category from search string
  List<String> searchedCategories = [];
  for (var i = 0; i < gCategories.length; i++) {
    String cat = gCategories[i].toLowerCase();
    if (SearchModel.getSearchText().toLowerCase().contains(cat)) {
      searchedCategories.add(cat);
    }
  }
  if (searchedCategories.isEmpty) return ret;

  List<double> userLatLon = getLatLonfromPostCode(gUserProfile.postcode);
  gUserProfile.lat = userLatLon[0];
  gUserProfile.lon = userLatLon[1];

  Map<BusinessContact, double> bizContactMap = getNearestBizContacts();

  // if bizContactMap.length > 25, then limit to 25
  var len = (bizContactMap.length > 20) ? 20 : bizContactMap.length;
  var bizcontacts = bizContactMap.keys.toList();
  int i = 0;
  for (var keyT in bizcontacts) {
    if (i >= len) {
      break;
    }

    List<int>? uids;
    List<UserContact> users = [];
    UserContact user = UserContact(id: 0, fName: '', fullName: '', mobile: '');
    //include as recommendation only if the trade category matches
    for (var j = 0; j < searchedCategories.length; j++) {
      uids?.clear();

      if (keyT.bizCategory!.toLowerCase().contains(searchedCategories[j])) {
        uids = gBizCustomerMap[keyT.id];

        if (null != uids) {
          for (var uid in uids) {
            user = gAllUsers.where((element) => element.id == uid).first;
            users.add(user);
          }
        } else {
          //assign a random user
          //user = gAllUsers[i % gAllUsers.length];
        }

        ret.add(RecommendationModel(tradie: keyT, fofs: users));
        i++;
        break;
      }
    }
  }

  return ret;
}

class RecommendationModel {
  BusinessContact tradie;
  List<UserContact>? fofs;
  int level = 0;
  List<UserContact>? hierarchy;

  RecommendationModel(
      {required this.tradie, this.fofs, this.level = 0, this.hierarchy});
}

/*
New recommendation algorithm

*/

class Node {
  UserContact user;
  List<UserContact> friends = [];

  Node(this.user, this.friends);
}

class RecoAlgo {
  final int maxRecommendations = 50;
  final int maxLevel = 6;

  List<UserContact> toExplore = <UserContact>[];
  List<UserContact> explored = <UserContact>[];
  List<RecommendationModel> retRecommendations = <RecommendationModel>[];

  void getTrustedTradies(int level, Node node, String searchCategory) {
    if (level > maxLevel) return;

    //loop through friends
    for (var friend in node.friends) {
      if (explored.contains(friend)) return;

      //add to exploration list
      toExplore.add(friend);
      explored.add(friend);
    }

    //loop through exploration list
    //  get this friend's tradies matching the search category
    //    if (found)
    //      add to retRecommendations
    //      add this friend to hierarchy
    //    add this friend to explored list
    //    remove from exploration list

    //if (retRecommendations.length == maxRecommendations) return;
    //else
    //  loop through friends
    //    get friends of friends
    //      //getTrustedTradies
    return;
  }
}
