import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../const/const.dart';
import '../uitil/http_error.dart';

class PaymentProvider with ChangeNotifier {
  // String remainingAmount = "";

  Future<void> addDeposit({
    required String token,
    required String accountId,
    required String amount,
    required String accountHolder,
    required String accountNumber,
    required String referenceNumber,
  }) async {
    String url = "${AppConst.appUrl}/payments";

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonEncode({
            "accountId": accountId,
            "amount": amount,
            "accountHolder": accountHolder,
            "accountNumber": accountNumber,
            "referenceNumber": referenceNumber,
          }));
      final decodedData = jsonDecode(response.body);

      if (response.statusCode != 201) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {}
    } catch (e) {
      rethrow;
    }
  }
}
