import 'package:flutter/material.dart';
import 'package:pickeze/pages/profile.dart';
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

    gUserProfile.name = 'Awesome';
    gUserProfile.email = '';
    gUserProfile.postcode = 0;

    //gPooledBizContacts - read tradies data from csv file and populate global object
    gAllBizContacts.clear();
    loadDBAllTradies();
    //gPooledContacts - read pooled users data from csv file and populate global object
    gAllUsers.clear();
    loadDBAllUsers();
    //gFriendsMap - read friends data from csv file and populate global object
    gFriendsMap.clear();
    loadDBFriends();
    //gUsedServicesMap - read used services data from csv file and populate global object
    gUsedServicesMap.clear();
    loadDBUsedServices();
    //read australian post codes from csv file and populate global object
    gAusPostCodes.clear();
    loadAustralianPostcodes();

    //Load user profile data from persistent file
    UserProfile.loadUserProfileFromFile().then((value) {
      gUserProfile = value;
      incrementInitCounter();
    });

    //Load all shared contacts from persistent file
    UserContact.loadSharedContactsFromFile().then((value) {
      gSharedContacts = value;
      gUniqueUserID = gSharedContacts.length + 1;
      incrementInitCounter();
    });

    //Load all shared Business contacts from persistent file
    BusinessContact.loadSharedBizContactsFromFile().then((value) {
      gSharedBizContacts = value;
      gUniqueBizID = gSharedBizContacts.length + 1;
      incrementInitCounter();
    });

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
        '/profile': (context) => const ProfilePage(),
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
