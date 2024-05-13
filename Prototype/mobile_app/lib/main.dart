import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pages/home.dart';
//import '../pages/login.dart';
import '../globals.dart';
import '../model/profile_model.dart';

//import 'package:location/location.dart';
//import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
//import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //create initialisation function
  void getInitInfo() {
    //initialise the app

    //gPooledBizContacts - read tradies data from csv file and populate global object
    gPooledBizContacts.clear();
    loadTradiesDb();
    //gPooledContacts - read pooled users data from csv file and populate global object
    gPooledContacts.clear();
    loadUsersDb();
    //read australian post codes from csv file and populate global object
    gAusPostCodes.clear();
    loadAustralianPostcodes();

    gUserProfile.name = 'Name';
    gUserProfile.email = 'name.l@test.com';
    gUserProfile.postcode = 2000;

    //gSharedContacts = getSharedContacts();
    //gSharedBizContacts = getSharedBizContacts();

    // if (io.Platform.isAndroid || io.Platform.isIOS) {
    //   gUserProfile.isLocationPermissionGranted =
    //       LocationService().requestPermission();
    // }

    //AndroidMapRenderer? globalMapRenderer = AndroidMapRenderer.platformDefault;

    // final GoogleMapsFlutterPlatform mapsImplementation =
    //     GoogleMapsFlutterPlatform.instance;
    // if (mapsImplementation is GoogleMapsFlutterAndroid) {
    //   WidgetsFlutterBinding.ensureInitialized();
    //   mapsImplementation.initializeWithRenderer(AndroidMapRenderer.latest);
    // }
  }

  Future<String> loadStringAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  void getLatLonforPooledContacts() {
    for (var i = 0; i < gPooledContacts.length; i++) {
      List<double> contactLatLon =
          getLatLonfromPostCode(gPooledContacts[i].postcode);
      gPooledContacts[i].lat = contactLatLon[0];
      gPooledContacts[i].lon = contactLatLon[1];
    }
  }

  void getLatLonforBizContacts() {
    for (var i = 0; i < gPooledBizContacts.length; i++) {
      List<double> contactLatLon =
          getLatLonfromPostCode(gPooledBizContacts[i].postcode);
      gPooledBizContacts[i].lat = contactLatLon[0];
      gPooledBizContacts[i].lon = contactLatLon[1];
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
      print(error);
    });
  }

  //create function to read tradies data from csv file
  void loadTradiesDb() async {
    //read data from csv file

    List<String> csvLines = [];
    List<String> csvLineCells = [];

    loadStringAsset('assets/db/db-tradies.csv').then((value) {
      csvLines = value.split("\n");
      //print('From loadasset invocation : $csvLines');

      //loop through csvLines. Skip the first line as it contains headers
      for (var i = 1; i < csvLines.length; i++) {
        csvLineCells = csvLines[i].split(",");
        //print(csvLineCells[1]);

        if (csvLineCells.length > 1) {
          //create BusinessContact object
          BusinessContact bizContact = BusinessContact(
            //id: int.parse(csvLineCells[0]),
            bizName: csvLineCells[1],
            bizPhone: csvLineCells[2],
            bizCategory: csvLineCells[3],
            //subcategory [4]
            postcode: int.parse(csvLineCells[5]),
            headOfficeAddress: csvLineCells[6],
            bizEmail: csvLineCells[7],
            //hours: csvLineCells[8],
            bizABN: csvLineCells[9],
            licenseNumber: csvLineCells[10],
            servicesTags: csvLineCells[11],
          );

          gPooledBizContacts.add(bizContact);
        }
      }
    }).onError((error, stackTrace) {
      //print(error);
    });
  }

  //create function to read tradies data from csv file
  void loadUsersDb() async {
    //read data from csv file

    List<String> csvLines = [];
    List<String> csvLineCells = [];

    loadStringAsset('assets/db/db-users.csv').then((value) {
      csvLines = value.split("\n");
      //print('From loadasset invocation : $csvLines');

      //loop through csvLines. Skip the first line as it contains headers
      for (var i = 1; i < csvLines.length; i++) {
        csvLineCells = csvLines[i].split(",");
        //print(csvLineCells[1]);
        if (csvLineCells.length > 1) {
          //create BusinessContact object
          UserContact userContact = UserContact(
            //id: int.parse(csvLineCells[0]),
            fName: csvLineCells[1],
            fullName: csvLineCells[2],
            mobile: csvLineCells[3],
            //email: int.parse(csvLineCells[4]),
            postcode: int.parse(csvLineCells[5]),
            //gender: int.parse(csvLineCells[6]),
          );

          gPooledContacts.add(userContact);
        }
      }
    }).onError((error, stackTrace) {
      //print(error);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    getInitInfo();

    return MaterialApp(
      title: 'Pickeze',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      //home: const HomePage(title: 'TrustNet - word of friends!'),
      //home: const LoginPage(title: 'TrustNet - word of friends!'),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the Create Account widget.
        //'/': (context) => const LoginPage(title: 'TrustNet'),
        '/': (context) => const HomePage(title: 'Pickeze - word of friends!'),
        '/myappname': (context) =>
            const HomePage(title: 'Pickeze - word of friends!'),
      },
    );
  }
}

// class LocationService {
//   late Location location;

//   Future<bool> requestPermission() async {
//     final PermissionStatus permission;
//     if (io.Platform.isAndroid || io.Platform.isIOS) {
//       location = Location();
//       permission = await location.requestPermission();
//     } else {
//       permission = PermissionStatus.deniedForever;
//     }

//     return permission == PermissionStatus.denied;
//   }

//   Future<LocationData> getCurrentLocation() async {
//     final bool serviceEnabled;
//     if (io.Platform.isAndroid || io.Platform.isIOS) {
//       serviceEnabled = await location.serviceEnabled();
//       if (!serviceEnabled) {
//         final result = location.requestService;
//         // ignore: unrelated_type_equality_checks
//         if (result == true) {
//           if (kDebugMode) print('Service has been enabled');
//         } else {
//           throw Exception('GPS service not enabled');
//         }
//       }
//     }

//     final locationData = await location.getLocation();
//     return locationData;
//   }
// }
