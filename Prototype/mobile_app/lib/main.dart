import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../pages/home.dart';
//import '../pages/login.dart';
import '../globals.dart';
import '../model/profile_model.dart';

import 'package:location/location.dart';
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

    globalUserProfile.name = 'Name';
    globalUserProfile.email = 'name.l@test.com';

    globalSharedContacts = getSharedContacts();

    if (io.Platform.isAndroid || io.Platform.isIOS) {
      globalUserProfile.isLocationPermissionGranted =
          LocationService().requestPermission();
    }

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
      title: 'TrustNet',
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
        '/': (context) => const HomePage(title: 'TrustNet - word of friends!'),
        '/myappname': (context) =>
            const HomePage(title: 'TrustNet - word of friends!'),
      },
    );
  }
}

class LocationService {
  late Location location;

  Future<bool> requestPermission() async {
    final PermissionStatus permission;
    if (io.Platform.isAndroid || io.Platform.isIOS) {
      location = Location();
      permission = await location.requestPermission();
    } else {
      permission = PermissionStatus.deniedForever;
    }

    return permission == PermissionStatus.denied;
  }

  Future<LocationData> getCurrentLocation() async {
    final bool serviceEnabled;
    if (io.Platform.isAndroid || io.Platform.isIOS) {
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        final result = location.requestService;
        if (result == true) {
          if (kDebugMode) print('Service has been enabled');
        } else {
          throw Exception('GPS service not enabled');
        }
      }
    }

    final locationData = await location.getLocation();
    return locationData;
  }
}
