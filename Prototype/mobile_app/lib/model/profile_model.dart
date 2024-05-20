import 'dart:convert';
import 'dart:io';
import 'package:pickeze/globals.dart';

class UserProfile {
  int id = 0;
  late String name = '';
  late String email = '';
  String mobile = '';
  //String photoUrl;
  late int postcode = 0;
  double lat = 0;
  double lon = 0;
  int isVerified = 0;
  Future<bool> isLocationPermissionGranted = Future.value(false);

  UserProfile({required this.isVerified});

  UserProfile.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String,
        email = json['email'] as String,
        mobile = json['mobile'] as String,
        postcode = json['postcode'] as int,
        lat = json['lat'] as double,
        lon = json['lon'] as double,
        isVerified = json['isVerified'] as int;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mobile': mobile,
        'email': email,
        'postcode': postcode,
        'lat': lat,
        'lon': lon,
        'isVerified': isVerified,
      };

  static Future<File> saveUserProfileToFile(UserProfile up) async {
    final file = await getFileUserProfile;

    String json = jsonEncode(up);

    // Write the file
    return file.writeAsString(json);
  }

  static Future<UserProfile> loadUserProfileFromFile() async {
    UserProfile up;
    try {
      final file = await getFileUserProfile;

      // Read the file
      final contents = await file.readAsString();
      final userMap = jsonDecode(contents) as Map<String, dynamic>;
      up = UserProfile.fromJson(userMap);
    } catch (e) {
      //TODO: post the init errors to a queue and show them in the UI later
      // If encountering an error, return 0
      up = UserProfile(isVerified: 0);
    }
    return up;
  }
}

class UserContact {
  int id = 0;
  String fName;
  late String? lName;
  String fullName;
  String mobile;
  int postcode = 0;
  double lat;
  double lon;

  UserContact({
    required this.id,
    required this.fName,
    required this.fullName,
    required this.mobile,
    this.lName,
    this.postcode = 0,
    this.lat = 0,
    this.lon = 0,
  });

  UserContact.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        fName = json['fName'] as String,
        lName = json['lName'] as String,
        fullName = json['fullName'] as String,
        mobile = json['mobile'] as String,
        postcode = json['postcode'] as int,
        lat = json['lat'] as double,
        lon = json['lon'] as double;

  Map<String, dynamic> toJson() => {
        'id': id,
        'fName': fName,
        'lName': lName,
        'fullName': fullName,
        'mobile': mobile,
        'postcode': postcode,
        'lat': lat,
        'lon': lon,
      };

  static Future<File> saveSharedContactsToFile(List<UserContact> sc) async {
    final file = await getFileSharedContacts;

    String json = '';
    StringBuffer sb = StringBuffer();
    sb.write('[');
    for (var i = 0; i < sc.length; i++) {
      json = jsonEncode(sc[i]);
      sb.write(json);
      if (i < sc.length - 1) sb.write(',');
    }
    sb.write(']');

    // Write the file
    return file.writeAsString(sb.toString());
  }

  static Future<List<UserContact>> loadSharedContactsFromFile() async {
    List<UserContact> uc = <UserContact>[];
    try {
      final file = await getFileSharedContacts;

      // Read the file
      final contents = await file.readAsString();
      final userMap = jsonDecode(contents) as List<dynamic>;
      //var v = UserContact.fromJson(userMap);
      for (var item in userMap) {
        uc.add(UserContact.fromJson(item));
      }
    } catch (e) {
      //TODO: post the init errors to a queue and show them in the UI later
      // If encountering an error, return 0
      //print(e);
    }
    return uc;
  }
}

enum FeedbackSentiment { na, bad, good, awesome }

enum FeedbackCriteria {
  quality,
  price,
  professionalism,
  commitment,
  communication,
  transparency
}

const String labelQuality = 'Quality';
const String labelPrice = 'Price';
const String labelProfessionalism = 'Professionalism';
const String labelCommitment = 'Commitment';
const String labelCommunication = 'Communication';
const String labelTransparency = 'Transparency';

class BizFeedback {
  int id = 0;
  String? comments;
  String? workType;
  FeedbackSentiment workQuality;
  FeedbackSentiment workPrice;
  FeedbackSentiment workProfessionalism;
  FeedbackSentiment workTimeCommitment;
  FeedbackSentiment workCommunication;
  FeedbackSentiment workTransparency;
  //DateTime? workDate;
  DateTime? feedbackDate;

  BizFeedback({
    required this.id,
    this.comments,
    this.workType,
    this.workQuality = FeedbackSentiment.na,
    this.workPrice = FeedbackSentiment.na,
    this.workProfessionalism = FeedbackSentiment.na,
    this.workTimeCommitment = FeedbackSentiment.na,
    this.workCommunication = FeedbackSentiment.na,
    this.workTransparency = FeedbackSentiment.na,
    this.feedbackDate,
  });

  BizFeedback.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        comments = json['comments'] as String,
        workType = json['workType'] as String,
        workQuality = json['workQuality'] as FeedbackSentiment,
        workPrice = json['workPrice'] as FeedbackSentiment,
        workProfessionalism = json['workProfessionalism'] as FeedbackSentiment,
        workTimeCommitment = json['workTimeCommitment'] as FeedbackSentiment,
        workCommunication = json['workCommunication'] as FeedbackSentiment,
        workTransparency = json['workTransparency'] as FeedbackSentiment,
        //workDate = json['workDate'] as DateTime,
        feedbackDate = json['feedbackDate'] as DateTime;

  Map<String, dynamic> toJson() => {
        'id': id,
        'comments': comments,
        'workType': workType,
        'workQuality': workQuality,
        'workPrice': workPrice,
        'workProfessionalism': workProfessionalism,
        'workTimeCommitment': workTimeCommitment,
        'workCommunication': workCommunication,
        'workTransparency': workTransparency,
        //'workDate': workDate,
        'feedbackDate': feedbackDate,
      };
}

class BusinessContact {
  int id;
  late String? headOfficeAddress;
  late String bizName;
  late String? bizABN;
  late String? bizPhone;
  late String? bizEmail;
  late String? licenseNumber;
  late String? bizContactName;
  late String? bizContactMobile;
  late int postcode = 0;
  late String? servicesTags;
  late String? bizCategory;
  double lat = 0;
  double lon = 0;

  BusinessContact({
    required this.id,
    required this.bizName,
    this.headOfficeAddress,
    this.bizABN,
    this.bizPhone,
    this.bizEmail,
    this.licenseNumber,
    this.bizContactName,
    this.bizContactMobile,
    this.postcode = 0,
    this.servicesTags,
    this.bizCategory,
  });

  BusinessContact.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        headOfficeAddress = json['headOfficeAddress'] as String,
        bizName = json['bizName'] as String,
        bizABN = json['bizABN'] as String,
        bizPhone = json['bizPhone'] as String,
        bizEmail = json['bizEmail'] as String,
        licenseNumber = json['licenseNumber'] as String,
        bizContactName = json['bizContactName'] as String,
        bizContactMobile = json['bizContactMobile'] as String,
        postcode = json['postcode'] as int,
        servicesTags = json['servicesTags'] as String,
        bizCategory = json['bizCategory'] as String,
        lat = json['lat'] as double,
        lon = json['lon'] as double;
  //feedback = json['feedback'] as BizFeedback;

  Map<String, dynamic> toJson() => {
        'id': id,
        'headOfficeAddress': headOfficeAddress,
        'bizName': bizName,
        'bizABN': bizABN,
        'bizPhone': bizPhone,
        'bizEmail': bizEmail,
        'licenseNumber': licenseNumber,
        'bizContactName': bizContactName,
        'bizContactMobile': bizContactMobile,
        'postcode': postcode,
        'servicesTags': servicesTags,
        'bizCategory': bizCategory,
        'lat': lat,
        'lon': lon,
      };

  static Future<File> saveSharedBizContactsToFile(
      List<BusinessContact> sc) async {
    final file = await getFileSharedBizContacts;

    String json = '';
    StringBuffer sb = StringBuffer();
    sb.write('[');
    for (var i = 0; i < sc.length; i++) {
      json = jsonEncode(sc[i]);
      sb.write(json);
      if (i < sc.length - 1) sb.write(',');
    }
    sb.write(']');

    // Write the file
    return file.writeAsString(sb.toString());
  }

  static Future<List<BusinessContact>> loadSharedBizContactsFromFile() async {
    List<BusinessContact> bc = <BusinessContact>[];
    try {
      final file = await getFileSharedBizContacts;

      // Read the file
      final contents = await file.readAsString();
      final userMap = jsonDecode(contents) as List<dynamic>;

      for (var item in userMap) {
        bc.add(BusinessContact.fromJson(item));
      }
    } catch (e) {
      //TODO: post the init errors to a queue and show them in the UI later
      // If encountering an error, return 0
      //print(e);
    }
    return bc;
  }
}

class AusPostcode {
  int id = 0;
  int postcode = 0;
  late String locality;
  late String state;
  double longitude = 0;
  double latitude = 0;

  AusPostcode({
    required this.id,
    required this.postcode,
    required this.locality,
    required this.state,
    required this.longitude,
    required this.latitude,
  });
}

//test data
//TODO: #7
//TODO: https://github.com/lalitparkale/TrustNet/issues/6

