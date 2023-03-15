import 'dart:convert';
import 'dart:io';

import 'package:ashewa_d/const/const.dart';
import 'package:ashewa_d/uitil/http_error.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? token;
  String? userID;
  String? phoneNumber;

  setPhoneNumber(String phone) {
    phoneNumber = "251$phone";
  }
  //
  //Login
  //

  Future<void> signIn(String phone, String password) async {
    String url = "${BaseUrl.appUrl}/login";

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: jsonEncode({"phone": phone, "password": password}));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode != 200) {
        throw CustomHttpException(errorMessage: "Please Try Again Later");
      } else {}
    } catch (_) {
      rethrow;
    }
  }

  Future<void> phoneRegister({required String phone}) async {
    String url = "${BaseUrl.appUrl}/register";
    try {
      http.Response response =
          await http.post(Uri.parse(url), body: jsonEncode({"phone": phone}));

      print(response.body);
      if (response.statusCode != 201) {
        //throw
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyOtp({required String code}) async {
    String url = "${BaseUrl.appUrl}/verify-otp";
    print(phoneNumber);
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode({"phone": phoneNumber, "password": code}));

      print(response.body);
      final decodedData = jsonDecode(response.body);
      if (response.statusCode != 201) {
        //throw
      } else {
        token = decodedData['data']["token"];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(
      {required String name,
      required String email,
      required String password}) async {
    String url = "${BaseUrl.appUrl}/finish-register";
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonEncode({
            "name": name,
            "email": email,
            "password": password,
            "confirm_password": password
          }));
      print(response.body);
      final decodedData = jsonDecode(response.body);
      if (response.statusCode != 201) {
        //throw
      } else {
        userID = decodedData['data']["user"]["id"];
      }
    } catch (e) {
      rethrow;
    }
  }
}
