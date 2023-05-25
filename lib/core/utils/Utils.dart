import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../ui/toast.dart';

class Utils {
  static Future<String> getAddress(LatLng latLng, BuildContext context) async {
    try {
      List<Placemark> address =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      var data =
          "${address[0].country ?? ""}  ${address[0].locality ?? ""}  ${address[0].subLocality ?? ""}  ${address[0].street ?? ""}";
      print(data);
      return data;
    } catch (e) {
      return "";
    }
  }

  static Future<Position?> getCurrentLocation(context) async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Toast.show('error');
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Toast.show('error');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Toast.show(
          'Location permissions are permanently denied, we cannot request permissions');
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }
}
