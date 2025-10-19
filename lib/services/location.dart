import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
late double longitude;
late double latitude;

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1️⃣ Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    // 2️⃣ Check permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('User denied location permission.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied. Please enable them in settings.');
      return;
    }

    // 3️⃣ Get the location
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low, // Low accuracy
      );


      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print('Error getting location: $e');
    }
  }
}
