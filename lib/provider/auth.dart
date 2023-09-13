import 'dart:convert';
import 'dart:io';

import '../const/const.dart';
import '../model/profile.dart';
import '../uitil/http_error.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? token;
  String? userID;
  String? role;

  String amount = "";

  final List<ProfileData> _profileData = [];

  List<ProfileData> get profileData => [..._profileData];

  Future<void> logOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove("LocalId");
    prefs.remove("LocalToken");
    prefs.remove("Role");
    userID = null;
    token = null;
    role = null;
  }

  Future getUserAndToken() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.getString("LocalToken") != null &&
        prefs.getString("LocalId") != null) {
      userID = prefs.getString("LocalId");
      token = prefs.getString("LocalToken");
      role = prefs.getString("Role");
    } else {
      prefs.remove("LocalId");
      prefs.remove("LocalToken");
      prefs.remove("Role");
      userID = null;
      token = null;
      role = null;
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
        role = decodedData['data']["user"]["role"]["name"];
        prefs.setString("LocalId", decodedData['data']["user"]["id"]);
        prefs.setString("LocalToken", decodedData['data']['token']);
        prefs.setString("Role", decodedData['data']["user"]["role"]["name"]);
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

  // Future<void> verifyOtp(
  //     {required bool isForRegister,
  //     required String phone,
  //     required String code}) async {
  //   String url = isForRegister
  //       ? "${AppConst.appUrl}/verify-otp"
  //       : "${AppConst.appUrl}/verify-password";

  //   try {
  //     http.Response response = await http.post(Uri.parse(url),
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Accept": "application/json"
  //         },
  //         body: jsonEncode({"phone": phone, "password": code}));

  //     final decodedData = jsonDecode(response.body);
  //     if (response.statusCode != 201) {
  //       throw CustomHttpException(errorMessage: decodedData["data"]);
  //     } else {
  //       token = decodedData['data']["token"];
  //     }
  //   } catch (_) {
  //     rethrow;
  //   }
  // }

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

  // Future<void> phoneRegisterUser({required String phone}) async {
  //   String url = "${AppConst.appUrl}/register";
  //   try {
  //     http.Response response = await http.post(Uri.parse(url),
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Accept": "application/json"
  //         },
  //         body: jsonEncode({"phone": phone}));

  //     final decodedData = jsonDecode(response.body);
  //     if (response.statusCode != 201) {
  //       throw CustomHttpException(errorMessage: decodedData["data"]);
  //     } else {}
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> registerUser(
      {required phone,
      required String name,
      required String email,
      required String password,
      required int isCorporate,
      required String corporatePhone,
      required String address}) async {
    String url = "${AppConst.appUrl}/register"; //finish-register
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            // HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonEncode({
            "phone": phone,
            "name": name,
            "email": email,
            "password": password,
            "is_corporate": isCorporate,

            if (corporatePhone != "") "corporate_phone": corporatePhone,

            if (address != "") "address": {"City": address},
            // "confirm_password": confirmPassword
          }));
      print(response.body);
      final decodedData = jsonDecode(response.body);
      if (response.statusCode != 201) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {
        var prefs = await SharedPreferences.getInstance();
        userID = decodedData['data']["user"]["id"];
        token = decodedData['data']['token'];
        role = decodedData['data']["user"]["role"]["name"];
        prefs.setString("LocalId", decodedData['data']["user"]["id"]);
        prefs.setString("LocalToken", decodedData['data']['token']);
        prefs.setString("Role", decodedData['data']["user"]["role"]["name"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future registerDriver(
      {required phone,
      required name,
      required email,
      required accountNumber,
      required accountholderName,
      required city,
      required bank,
      required password,
      required plateNumber,
      required color,
      required capacity,
      required sandLocation,
      required lat,
      required long,
      required PlatformFile carOwnershipDocPath,
      required PlatformFile licenceDocPath,
      required PlatformFile profileImage}) async {
    final url = Uri.parse("${AppConst.appUrl}/register-driver");
    try {
      print("object");
      final request = http.MultipartRequest('POST', url);
      request.fields['phone'] = phone;
      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['account_number'] = accountNumber;
      request.fields['account_holder_name'] = accountholderName;
      request.fields['city'] = city;
      request.fields['bank_name'] = bank;
      request.fields['plate_number'] = plateNumber;
      request.fields['color'] = color;
      request.fields['load_capacity'] = capacity;
      request.fields["locationId"] = sandLocation;
      request.fields["locationName"] = city;
      request.fields["latitude"] = lat;
      request.fields["longitude"] = long;
      request.fields['password'] = password;
      request.fields["confirm_password"] = password;
      // request.fields["carOwnershipDoc"] = carOwnershipDocPath.path!;
      // request.fields["LicenceDoc"] = licenceDocPath.path!;
      // request.fields["profile_image"] = profileImage.path!;

      request.files.add(await http.MultipartFile.fromPath(
        'carOwnershipDoc',
        carOwnershipDocPath.path!,
        // contentType: MediaType('application', 'pdf'),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'LicenceDoc',
        licenceDocPath.path!,
        // contentType: MediaType('application', 'pdf'),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'profile_image',
        profileImage.path!,
        // contentType: MediaType(
        //     'image', 'jpeg'), // Adjust the media type according to your file
      ));

      print("object 22");
      final response = await request.send();
      print(response.statusCode);

      var responseBody = await (response.stream.bytesToString());

      var decodedData = jsonDecode(responseBody);

      print(decodedData);
      if (response.statusCode != 201) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {
        var prefs = await SharedPreferences.getInstance();
        userID = decodedData['data']["user"]["id"];
        token = decodedData['data']['token'];
        role = decodedData['data']["user"]["role"]["name"];
        prefs.setString("LocalId", decodedData['data']["user"]["id"]);
        prefs.setString("LocalToken", decodedData['data']['token']);
        prefs.setString("Role", decodedData['data']["user"]["role"]["name"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getMyProfile() async {
    String url = "${AppConst.appUrl}/profile";

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      });

      final decodedData = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {
        _profileData.clear();
        final data = profileModelFromJson(response.body);
        _profileData.addAll([data.data]);
        amount = _profileData[0].deposit == null
            ? "null"
            : _profileData[0].deposit!.amount;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future updatePassword(
      {required String oldPassword, required String newPassword}) async {
    String url = "${AppConst.appUrl}/change-password";
    try {
      http.Response response = await http.patch(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
        body: jsonEncode({
          "current_password": oldPassword,
          "new_password": newPassword,
          "new_confirm_password": newPassword,
        }),
      );
      var decodedData = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode != 200) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  Future updateProfile({required String name, required String email}) async {
    String url = "${AppConst.appUrl}/update-profile";
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
        }),
      );
      var decodedData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {
        await getMyProfile();
      }
    } catch (e) {
      rethrow;
    }
  }
}
