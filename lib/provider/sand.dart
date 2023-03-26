import 'dart:convert';
import 'dart:io';

import 'package:ashewa_d/const/const.dart';
import 'package:ashewa_d/uitil/http_error.dart';
import 'package:flutter/material.dart';

import '../model/sand.dart';
import 'package:http/http.dart' as http;

class SandProvider with ChangeNotifier {
final  List<Favorite> _favSand = [];
final  List<Favorite> _sand = [];

  List<Favorite> get favoriteSand => [..._favSand];
  List<Favorite> get featuredSand => [..._sand];

  Future<void> getSand() async {
    String url = "${AppConst.appUrl}/home-sands";

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          HttpHeaders.authorizationHeader:
              "Bearer 25|xTWjlkVIjOQPu5AeGshsEMZriIv7z1ijmtdXC0el"
        },
      );
      final decodedData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {
        final data = sandModelFromJson(response.body);
        _favSand.addAll(data.data.favorite);
        _sand.addAll(data.data.sands.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
