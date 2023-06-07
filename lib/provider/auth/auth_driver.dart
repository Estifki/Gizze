import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../const/const.dart';
import '../../uitil/http_error.dart';

class DriverAuthProvider with ChangeNotifier {
  String? userID;
  String? token;

  Future resgisterDriver(
      {required phone,
      required name,
      required email,
      required accountNumber,
      required accountholderName,
      required city,
      required bank,
      required password,
      required PlatformFile carOwnershipDocPath,
      required PlatformFile LicenceDocPath,
      required PlatformFile profileImage}) async {
    String url = "${AppConst.appUrl}/register";
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      // request.headers['Content-Type'] = 'multipart/form-data';
      request.fields["phone"] = phone.toInt().toString();
      request.fields["name"] = name;
      request.fields["password"] = password;
      request.fields["confirm_password"] = password;
      request.fields["account_number"] = accountNumber;
      request.fields["account_holder_name"] = accountholderName;
      request.fields["bank_name"] = bank;
      request.fields["city"] = city;
      request.fields["carOwnershipDoc"] = carOwnershipDocPath.path.toString();

      request.fields["LicenceDoc"] = LicenceDocPath.path.toString();

      request.fields["profile_image"] = profileImage.path.toString();
      final response = await request.send();
      var responseBody = await (response.stream.bytesToString());

      var decodedData = jsonDecode(responseBody);
      print(decodedData);
      if (response.statusCode != 201) {
        throw CustomHttpException(errorMessage: "Please Try Again Later!");
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  // Future registerUser(List<XFile> images) async {
  //   final url = Uri.parse("${AppConst.baseUrl}/auth/register");
  //   try {
  // final request = http.MultipartRequest('PUT', url);
  // // request.headers['Content-Type'] = 'multipart/form-data';
  // request.fields["phone"] = phoneNumber.toInt().toString();
  // request.fields["fullName"] = fullName;
  // request.fields["password"] = password;
  // request.fields["displayName"] = userName;
  // request.fields["birthDate"] = birthDay.toIso8601String();
  // request.fields["bio"] = bio;

  // // request.fields["location"] = jsonEncode([location]);
  // for (var i = 0; i < location.length; i++) {
  //   request.fields['location[$i]'] = location[i].toString();
  // }
  // for (var i = 0; i < interest.length; i++) {
  //   request.fields['interest[$i]'] = interest[i];
  // }
  // // request.fields["interest"] = interest.toList().toString();
  // request.fields["pets"] = pets;
  // request.fields["lookingFor"] = lookingFor;
  // request.fields["education"] = education;
  // request.fields["gender"] = gender;
  // request.fields["communication"] = communication;

  // for (var file in images) {
  //   request.files
  //       .add(await http.MultipartFile.fromPath('profile', file.path));
  // }

  // final response = await request.send();
  // var responseBody = await (response.stream.bytesToString());

  //     var decodedData = jsonDecode(responseBody);

  // if (response.statusCode != 201) {
  //   throw CustomHttpException(errorMessage: decodedData["message"]);
  // } else {
  //       var prefs = await SharedPreferences.getInstance();

  //       prefs.setString("userID", decodedData["result"]["_id"]);
  //       prefs.setString("token", decodedData["token"]);
  //       prefs.setDouble("long", decodedData["result"]["location"][0]);
  //       prefs.setDouble("lat", decodedData["result"]["location"][1]); //location
  //       userID = prefs.getString("userID");
  //       token = prefs.getString("token");
  //       long = prefs.getDouble("long");
  //       lat = prefs.getDouble("lat");
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
