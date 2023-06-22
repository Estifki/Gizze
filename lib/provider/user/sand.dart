import 'dart:convert';
import 'dart:io';

import 'package:ashewa_d/const/const.dart';
import 'package:ashewa_d/uitil/http_error.dart';
import 'package:flutter/material.dart';

import '../../model/user/sand.dart';
import 'package:http/http.dart' as http;

import '../../model/user/sand_details.dart';

class SandProvider with ChangeNotifier {
  final List<Favorite> _favSand = [];
  final List<Favorite> _sand = [];

  final List<SandData> _sandLocationData = [];

  List<Favorite> get favoriteSand => [..._favSand];
  List<Favorite> get featuredSand => [..._sand];
  List<SandData> get sandLocationData => [..._sandLocationData];

  cleanSandDetails() {
    _sandLocationData.clear();
  }

  Future<void> getSand(String token) async {
    String url = "${AppConst.appUrl}/home-sands";

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      print(response.body);
      final decodedData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {
        _favSand.clear();
        _sand.clear();
        final data = sandModelFromJson(response.body);

        _favSand.addAll(data.data.favorite);
        _sand.addAll(data.data.sands.data);
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getSandDetails(String token, String sandID) async {
    String url = "${AppConst.appUrl}/home-sands/$sandID";

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
        // _sandLocationData.clear();
        final data = sandDetailsModelFromJson(response.body);

        _sandLocationData.addAll([data.data]);
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }
}
