import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../const/const.dart';
import '../model/user/sand.dart';
import '../model/user/sand_details.dart';
import '../model/user/wish_list.dart';
import '../uitil/http_error.dart';

class SandProvider with ChangeNotifier {
  // final List<HomeSandData> _favSand = [];
  final List<HomeSandData> _sand = [];
  final List<SandData> _sandLocationData = [];
  final List<WishListData> _wishList = [];

  // List<HomeSandData> get favoriteSand => [..._favSand];
  List<HomeSandData> get featuredSand => [..._sand];
  List<SandData> get sandLocationData => [..._sandLocationData];
  List<WishListData> get wishListData => [..._wishList];

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
      final decodedData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {
        // _favSand.clear();
        _sand.clear();
        final data = sandModelFromJson(response.body);

        // _favSand.addAll(data.data.favorite);
        _sand.addAll(data.data);
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getMyWishList(String token) async {
    String url = "${AppConst.appUrl}/wishlist";

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
        _wishList.clear();

        final data = wishListModelFromJson(response.body);

        _wishList.addAll(data.data);
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

  Future<void> addRemoveMyWishList(
      {required String token,
      String? sandID,
      String? wishListID,
      bool isAdd = true}) async {
    String url = isAdd
        ? "${AppConst.appUrl}/wishlist"
        : "${AppConst.appUrl}/wishlist/$wishListID";

    try {
      isAdd
          ? await http.post(Uri.parse(url),
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
                HttpHeaders.authorizationHeader: "Bearer $token"
              },
              body: jsonEncode({"sandId": sandID}))
          : await http.delete(
              Uri.parse(url),
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
                HttpHeaders.authorizationHeader: "Bearer $token"
              },
            );
      // final decodedData = jsonDecode(response.body);
      // if (response.statusCode != 200 && response.statusCode != 201) {
      //   throw CustomHttpException(errorMessage: decodedData["data"]);
      // } else {
      // _wishList.clear();

      // final data = wishListModelFromJson(response.body);

      // _wishList.addAll(data.data);
      // notifyListeners();
      // }
    } catch (e) {
      rethrow;
    }
  }
}
