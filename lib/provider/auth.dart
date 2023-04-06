import 'dart:convert';
import 'dart:io';

import 'package:ashewa_d/const/const.dart';
import 'package:ashewa_d/uitil/http_error.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? token;
  String? userID;

  Future<void> LogOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove("LocalUserId");
    prefs.remove("LocalToken");
    userID = null;
    token = null;
  }

  Future getUserAndToken() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.getString("LocalToken") != null &&
        prefs.getString("LocalUserId") != null) {
      userID = prefs.getString("LocalUserId");
      token = prefs.getString("LocalToken");
    } else {
      prefs.remove("LocalUserId");
      prefs.remove("LocalToken");
      userID = null;
      token = null;
    }
  }

  Future<void> signIn(String phone, String password) async {
    String url = "${AppConst.appUrl}/login";

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: jsonEncode({"phone": phone, "password": password}));
      final decodedData = jsonDecode(response.body);

      if (response.statusCode != 201) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {
        var prefs = await SharedPreferences.getInstance();
        userID = decodedData['data']["user"]["id"];
        token = decodedData['data']['token'];
        prefs.setString("LocalUserId", decodedData['data']["user"]["id"]);
        prefs.setString("LocalToken", decodedData['data']['token']);
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<void> resetPassword(String phone) async {
    String url = "${AppConst.appUrl}/reset-password";

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: jsonEncode({"phone": phone}));

      final decodedData = jsonDecode(response.body);
      if (response.statusCode != 201) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<void> verifyOtp(
      {required bool isForRegister,
      required String phone,
      required String code}) async {
    String url = isForRegister
        ? "${AppConst.appUrl}/verify-otp"
        : "${AppConst.appUrl}/verify-password";

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: jsonEncode({"phone": phone, "password": code}));

      final decodedData = jsonDecode(response.body);
      if (response.statusCode != 201) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {
        token = decodedData['data']["token"];
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<void> changePassword(
      {required newPassword, required confirmPassword}) async {
    String url = "${AppConst.appUrl}/create-password";
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonEncode({
            "new_password": newPassword,
            "new_confirm_password": confirmPassword
          }));
      final decodedData = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<void> phoneRegister({required String phone}) async {
    String url = "${AppConst.appUrl}/register";
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: jsonEncode({"phone": phone}));

      final decodedData = jsonDecode(response.body);
      if (response.statusCode != 201) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(
      {required String name,
      required String email,
      required String password,
      required String confirmPassword}) async {
    String url = "${AppConst.appUrl}/finish-register";
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonEncode({
            "name": name,
            "email": email,
            "password": password,
            "confirm_password": confirmPassword
          }));
      final decodedData = jsonDecode(response.body);
      if (response.statusCode != 201) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {
        userID = decodedData['data']["user"]["id"];
      }
    } catch (e) {
      rethrow;
    }
  }
}
