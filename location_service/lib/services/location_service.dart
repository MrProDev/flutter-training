import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationService extends ChangeNotifier {
  double? _latitude;
  double? _longitude;

  double get latitude => _latitude ?? 0.0;
  double get longitude => _longitude ?? 0.0;

  Location location = Location();

  Future getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    _latitude = locationData.latitude;
    _longitude = locationData.longitude;

    notifyListeners();
  }
}
