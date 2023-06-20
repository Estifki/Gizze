import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../const/const.dart';
import '../model/sand_address.dart';
import '../uitil/http_error.dart';

class SandLocationProvider with ChangeNotifier {
  final List<SandAddressData> _sandAddressData = [];

  List<SandAddressData> get sandAddressData => [..._sandAddressData];

  //sand-locations

  Future<void> getSandAddress(String token) async {
    String url = "${AppConst.appUrl}/locations";

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      final decodedData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {
        _sandAddressData.clear();
        final data = sandAddressModelFromJson(response.body);
        _sandAddressData.addAll(data.data);
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addSandLocation(
      {required String token,
      required String sandID,
      required String price,
      required String locationID,
      required double lat,
      required double long}) async {
    String url = "${AppConst.appUrl}/sand-locations";

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonEncode({
            "sandId": sandID,
            "price": price,
            "locationId": locationID,
            "latitude": lat,
            "longitude": long
          }));
      final decodedData = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode != 201) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {}
    } catch (e) {
      rethrow;
    }
  }
}