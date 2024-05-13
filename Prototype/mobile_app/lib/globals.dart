library globals;

import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';

//import 'package:mobile_app/main.dart';
//import 'package:mobile_app/lib/model/profile_model.dart';
import 'model/profile_model.dart';

//create a static variable for userprofile
UserProfile gUserProfile = UserProfile(isVerified: 0);

//list of contacts shared by this user
List<UserContact> gSharedContacts = List<UserContact>.empty(growable: true);

//list of business contacts shared by this user
List<BusinessContact> gSharedBizContacts =
    List<BusinessContact>.empty(growable: true);

//list of contacts across the platform pooled together
List<UserContact> gPooledContacts = List<UserContact>.empty(growable: true);

//list of business contacts  across the platform pooled together
List<BusinessContact> gPooledBizContacts =
    List<BusinessContact>.empty(growable: true);

//list of business contacts  across the platform pooled together
List<AusPostcode> gAusPostCodes = List<AusPostcode>.empty(growable: true);

List<String> gCategories = [
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
  'mechanic',
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
/////////////////////////////////////////////////
/////////////////////////////////////////////////

/////////////////////////////////////////////////
////////////// Local Persistent Storage//////////

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
/////////////////////////////////////////////////
/////////////////////////////////////////////////

//LocationService globalLocationService = LocationService();
