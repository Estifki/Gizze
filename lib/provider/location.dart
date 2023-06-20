import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  double? _userLong;
  double? _userLat;

  double? get userLong => _userLong;

  double? get userLat => _userLat;

  Future<Position> getUserCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      return await Geolocator.getCurrentPosition();
    } catch (_) {
      rethrow;
    }
  }

  Future getUserAddress() async {
    Position userPosition = await getUserCurrentPosition();
    _userLong = userPosition.longitude;
    _userLat = userPosition.latitude;
    notifyListeners();
  }

  addressFromUserSelected({required double lat, required double long}) {
    _userLat = lat;
    _userLong = long;
    notifyListeners();
  }
}
