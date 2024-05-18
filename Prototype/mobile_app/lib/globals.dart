library globals;

import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'model/profile_model.dart';

//number of async initialisation activities
const int initActivities = 6;
//counter to track the number of async initialisation activities.
//After all async init activities are done, check for user profile
int gInitCounter = 0;

void incrementInitCounter() async {
  gInitCounter++;
}

//async function that waits for all async init activities to complete
Future<void> waitForInit() async {
  while (gInitCounter < initActivities) {
    //TODO: improve the wait calculation logic so that it has small
    // wait time but could wait for longer if need be when DB grows
    await Future.delayed(const Duration(milliseconds: 300));
  }
}

//create a static class to hold the search text
class SearchModel {
  static String _searchText = '';

  static getSearchText() => _searchText;

  set searchText(String value) {
    _searchText = value;
  }
}

//create a static variable for userprofile
UserProfile gUserProfile = UserProfile(isVerified: 0);

//Map of all feedbacks
//Map<uid, Map<fid, feedback>>
Map<int, Map<int, BizFeedback>> gAllFeedbackMap =
    <int, Map<int, BizFeedback>>{};

/*
Friends
*/
//list of contacts shared by this user
List<UserContact> gSharedContacts = List<UserContact>.empty(growable: true);

int gUniqueUserID = 0;
int getUniqueUserID() {
  gUniqueUserID++;
  return gUniqueUserID;
}

Map<int, List<int>> gFriendsMap = <int, List<int>>{};
Map<int, List<int>> gUsedServicesMap = <int, List<int>>{};
/*
Businesses
*/
//list of business contacts shared by this user
List<BusinessContact> gSharedBizContacts =
    List<BusinessContact>.empty(growable: true);

int gUniqueBizID = 0;
int getUniqueBizID() {
  gUniqueBizID++;
  return gUniqueBizID;
}

Map<int, List<int>> gBizCustomerMap = <int, List<int>>{};

//list of contacts across the platform pooled together
List<UserContact> gAllUsers = List<UserContact>.empty(growable: true);

//list of business contacts  across the platform pooled together
List<BusinessContact> gAllBizContacts =
    List<BusinessContact>.empty(growable: true);

//list of business contacts  across the platform pooled together
List<AusPostcode> gAusPostCodes = List<AusPostcode>.empty(growable: true);

List<String> gCategories = [
  'arborist',
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
  'appliances',
  'aircon',
  'pest',
  'pest control',
  'removalist',
  'mover',
  'car mechanic',
  'decking',
  'pool',
  'pergola',
  'Gardening',
  'Lawn Mowing',
  'Equipment Repairs',
  'Snake Catcher',
  'Gyprock',
  'Dentist',
  'Builder Inspector',
  'Podiatrist',
];

/////////////////////////////////////////////////
////////////Geo location processing /////////////

List<double> getLatLonfromPostCode(int postcode) {
  for (var i = 0; i < gAusPostCodes.length; i++) {
    if (gAusPostCodes[i].postcode == postcode) {
      return [gAusPostCodes[i].latitude, gAusPostCodes[i].longitude];
    }
  }
  return [0, 0];
}

double getDistanceFromLatLonInKm(
    double lat1, double lon1, double lat2, double lon2) {
  var R = 6371; // Radius of the earth in km
  var dLat = deg2rad(lat2 - lat1); // deg2rad below
  var dLon = deg2rad(lon2 - lon1);
  var a = sin(dLat / 2) * sin(dLat / 2) +
      cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
  var c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double d = (R * c).toDouble(); // Distance in km
  return d;
}

double deg2rad(deg) {
  return deg * (pi / 180);
}

void getLatLonforPooledContacts() {
  for (var i = 0; i < gAllUsers.length; i++) {
    List<double> contactLatLon = getLatLonfromPostCode(gAllUsers[i].postcode);
    gAllUsers[i].lat = contactLatLon[0];
    gAllUsers[i].lon = contactLatLon[1];
  }
}

void getLatLonforBizContacts() {
  for (var i = 0; i < gAllBizContacts.length; i++) {
    List<double> contactLatLon =
        getLatLonfromPostCode(gAllBizContacts[i].postcode);
    gAllBizContacts[i].lat = contactLatLon[0];
    gAllBizContacts[i].lon = contactLatLon[1];
  }
}

//create function to read australian postcodes from csv file
void loadAustralianPostcodes() async {
  List<String> csvLines = [];
  List<String> csvLineCells = [];

  loadStringAsset('assets/db/australian_postcodes.csv').then((value) {
    csvLines = value.split("\n");
    //print('From loadasset invocation : $csvLines');

    if (csvLines.length > 1) {
      //loop through csvLines. Skip the first line as it contains headers
      for (var i = 1; i < csvLines.length; i++) {
        csvLineCells = csvLines[i].split(",");
        //print(csvLineCells[1]);

        if (csvLineCells.length > 1) {
          //create Auspostcode object
          AusPostcode ausPostcode = AusPostcode(
            id: int.parse(csvLineCells[0]),
            postcode: int.parse(csvLineCells[1]),
            locality: csvLineCells[2],
            state: csvLineCells[3],
            longitude: double.parse(csvLineCells[4]),
            latitude: double.parse(csvLineCells[5]),
          );

          gAusPostCodes.add(ausPostcode);
        }
      }
    }

    getLatLonforPooledContacts();
    getLatLonforBizContacts();
  }).onError((error, stackTrace) {
    //print(error);
  });

  incrementInitCounter();
}
/////////////////////////////////////////////////
/////////////////////////////////////////////////

/////////////////////////////////////////////////
////////////// Local Persistent Storage//////////
Future<String> loadStringAsset(String path) async {
  return await rootBundle.loadString(path);
}

Future<String> get getLocalAppDocPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get getFileUserProfile async {
  final path = await getLocalAppDocPath;
  return File('$path/userprofile.json');
}

Future<File> get getFileSharedContacts async {
  final path = await getLocalAppDocPath;
  return File('$path/sharedcontacts.json');
}

Future<File> get getFileSharedBizContacts async {
  final path = await getLocalAppDocPath;
  return File('$path/sharedbizcontacts.json');
}

bool findUIDforProfile(String mobile) {
  for (var i = 0; i < gAllUsers.length; i++) {
    if (gAllUsers[i].mobile == mobile) {
      gUserProfile.id = gAllUsers[i].id;
      return true;
    }
  }
  return false;
}

void saveUserProfile() {
  //save user profile to db
  UserProfile.saveUserProfileToFile(gUserProfile);
}

void saveSharedContacts() {
  //save user profile to db
  UserContact.saveSharedContactsToFile(gSharedContacts);
}

void saveSharedBizContacts() {
  //save user profile to db
  BusinessContact.saveSharedBizContactsToFile(gSharedBizContacts);
}

//create function to read friends data from csv file
void loadDBFriends() async {
  //read data from csv file

  List<String> csvLines = [];
  List<String> csvLineCells = [];
  Map<int, List<int>> fMap = {};

  loadStringAsset('assets/db/db-friends.csv').then((value) {
    csvLines = value.split("\n");
    //print('From loadasset invocation : $csvLines');

    //loop through csvLines. Skip the first line as it contains headers
    for (var i = 1; i < csvLines.length; i++) {
      csvLineCells = csvLines[i].split(",");
      //print(csvLineCells[1]);

      if (csvLineCells.length > 1) {
        int uid = int.parse(csvLineCells[0]);
        int fid = int.parse(csvLineCells[1]);

        //check if uid exists in friendsMap
        if (fMap.containsKey(uid)) {
          fMap[uid]?.add(fid);
        } else {
          fMap[uid] = [fid];
        }
      }
    }
  }).onError((error, stackTrace) {
    print(error);
  });

  gFriendsMap = fMap;
  incrementInitCounter();
}

//create function to read biz services used by users data from csv file
void loadDBUsedServices() async {
  //read data from csv file

  List<String> csvLines = [];
  List<String> csvLineCells = [];
  Map<int, List<int>> userConsumedMap = {};
  Map<int, List<int>> bizCustomerMap = {};

  loadStringAsset('assets/db/db-usedservices.csv').then((value) {
    csvLines = value.split("\n");
    //print('From loadasset invocation : $csvLines');

    //loop through csvLines. Skip the first line as it contains headers
    for (var i = 1; i < csvLines.length; i++) {
      csvLineCells = csvLines[i].split(",");
      //print(csvLineCells[1]);

      if (csvLineCells.length > 1) {
        int uid = int.parse(csvLineCells[0]);
        int bid = int.parse(csvLineCells[1]);

        //check if uid exists in userConsumedMap
        if (userConsumedMap.containsKey(uid)) {
          userConsumedMap[uid]?.add(bid);
        } else {
          userConsumedMap[uid] = [bid];
        }

        //check if bid exists in bizCustomerMap
        if (bizCustomerMap.containsKey(bid)) {
          bizCustomerMap[bid]?.add(uid);
        } else {
          bizCustomerMap[bid] = [uid];
        }
      }
    }
  }).onError((error, stackTrace) {
    print(error);
  });

  gUsedServicesMap = userConsumedMap;
  gBizCustomerMap = bizCustomerMap;
  incrementInitCounter();
}

//create function to read tradies data from csv file
void loadDBAllTradies() async {
  //read data from csv file

  List<String> csvLines = [];
  List<String> csvLineCells = [];

  loadStringAsset('assets/db/db-alltradies.csv').then((value) {
    csvLines = value.split("\n");
    //print('From loadasset invocation : $csvLines');

    //loop through csvLines. Skip the first line as it contains headers
    for (var i = 1; i < csvLines.length; i++) {
      csvLineCells = csvLines[i].split(",");
      //print(csvLineCells[1]);

      if (csvLineCells.length > 1) {
        //create BusinessContact object
        BusinessContact bizContact = BusinessContact(
          id: int.parse(csvLineCells[0]),
          bizName: csvLineCells[1],
          bizContactName: csvLineCells[2],
          bizPhone: csvLineCells[3],
          bizCategory: csvLineCells[4],
          //subcategory [5]
          postcode: int.parse(csvLineCells[6]),
          headOfficeAddress: csvLineCells[7],
          bizEmail: csvLineCells[8],
          //hours: csvLineCells[9],
          bizABN: csvLineCells[10],
          licenseNumber: csvLineCells[11],
          servicesTags: csvLineCells[12],
        );

        gAllBizContacts.add(bizContact);
      }
    }
  }).onError((error, stackTrace) {
    //print(error);
  });

  incrementInitCounter();
}

//create function to read all users data from csv file
void loadDBAllUsers() async {
  //read data from csv file

  List<String> csvLines = [];
  List<String> csvLineCells = [];

  loadStringAsset('assets/db/db-allusers.csv').then((value) {
    csvLines = value.split("\n");
    //print('From loadasset invocation : $csvLines');

    //loop through csvLines. Skip the first line as it contains headers
    for (var i = 1; i < csvLines.length; i++) {
      csvLineCells = csvLines[i].split(",");
      //print(csvLineCells[1]);
      if (csvLineCells.length > 1) {
        //create BusinessContact object
        UserContact userContact = UserContact(
          id: int.parse(csvLineCells[0]),
          fName: csvLineCells[1],
          fullName: csvLineCells[2],
          mobile: csvLineCells[3],
          //email: int.parse(csvLineCells[4]),
          postcode: int.parse(csvLineCells[5]),
          //gender: int.parse(csvLineCells[6]),
        );

        gAllUsers.add(userContact);
      }
    }
  }).onError((error, stackTrace) {
    //print(error);
  });

  incrementInitCounter();
}
/////////////////////////////////////////////////
/////////////////////////////////////////////////

//Map<int, List<int>> gFriendsMap = <int, List<int>>{};

int getLevel(
  int uid,
  int fid,
) {
  int level = 0;

  if (null == gFriendsMap[uid]) return level;

  List<int> friends = gFriendsMap[uid]!;
  if (uid == fid) return 0;

  if (friends.contains(fid)) {
    level++;
  } else {
    if (friends.isNotEmpty) {
      level++;
      Set<int> friends3 = <int>{};
      for (var i = 0; i < friends.length; i++) {
        if (uid == friends[i]) {
          continue;
        }
        List<int> friends2 = gFriendsMap[friends[i]]!;

        if (friends2.contains(fid)) {
          return ++level;
        }

        friends2.remove(uid);
        //add only unique friends to queue
        for (var j = 0; j < friends2.length; j++) {
          if (!friends3.contains(friends2[j])) {
            friends3.add(friends2[j]);
          }
        }
      }

      if (friends3.isNotEmpty) {
        level++;
        Set<int> friends5 = <int>{};
        for (var j = 0; j < friends3.length; j++) {
          List<int> friends4 = gFriendsMap[friends3.elementAt(j)]!;

          if (friends4.contains(fid)) {
            return ++level;
          }

          friends4.remove(uid);
          //add only unique friends to queue
          for (var j = 0; j < friends4.length; j++) {
            if (!friends5.contains(friends4[j])) {
              friends5.add(friends4[j]);
            }
          }
        }

        if (friends5.isNotEmpty) {
          level++;
          Set<int> friends7 = <int>{};
          for (var j = 0; j < friends5.length; j++) {
            List<int> friends6 = gFriendsMap[friends5.elementAt(j)]!;

            if (friends6.contains(fid)) {
              return ++level;
            }
            friends6.remove(uid);
            //add only unique friends to queue
            for (var j = 0; j < friends6.length; j++) {
              if (!friends7.contains(friends6[j])) {
                friends7.add(friends6[j]);
              }
            }
          }
        }
      }
    } else {
      level = 0;
    }
  }
  return level;
}
//LocationService globalLocationService = LocationService();
