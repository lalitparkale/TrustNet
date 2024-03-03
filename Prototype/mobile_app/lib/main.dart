import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:mobile_app/pages/login.dart';
import 'package:mobile_app/globals.dart';
import 'package:mobile_app/model/profile_model.dart';
import 'package:location/location.dart';

import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //create initialisation function
  void getInitInfo() {
    //initialise the app

    globalUserProfile.name = 'Test Name';
    globalUserProfile.email = 'name.l@test.com';

    globalSharedContacts = getSharedContacts();

    globalUserProfile.isLocationPermissionGranted =
        LocationService().requestPermission();

    //AndroidMapRenderer? globalMapRenderer = AndroidMapRenderer.platformDefault;

    final GoogleMapsFlutterPlatform mapsImplementation =
        GoogleMapsFlutterPlatform.instance;
    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      WidgetsFlutterBinding.ensureInitialized();
      mapsImplementation.initializeWithRenderer(AndroidMapRenderer.latest);
    }
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
      home: const LoginPage(title: 'TrustNet - word of friends!'),
    );
  }
}

class LocationService {
  static Location? _location;

  Future<bool> requestPermission() async {
    _location ??= Location();
    final permission = await _location?.requestPermission();
    return permission == PermissionStatus.granted;
  }

  Future<LocationData?> getCurrentLocation() async {
    final serviceEnabled = await _location?.serviceEnabled();
    if (!serviceEnabled!) {
      final result = _location?.requestService;
      if (result == true) {
        if (kDebugMode) {
          print('Service has been enabled');
        }
      } else {
        throw Exception('GPS service not enabled');
      }
    }

    final locationData = await _location?.getLocation();
    return locationData;
  }
}
