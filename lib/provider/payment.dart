// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ashewa_d/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../const/const.dart';
import '../uitil/http_error.dart';

class PaymentProvider with ChangeNotifier {
  double fineAmount = 500;
  double prePaymentPercentage = 40;
  double initialPrice = 200;
  double perKmPrice = 15;
  Future<void> addDeposit({
    required BuildContext context,
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
     
      if (response.statusCode != 200) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {
        await Provider.of<AuthProvider>(context, listen: false).getMyProfile();
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<void> priceSetting({required String token}) async {
    String url = "${AppConst.appUrl}/price-settings";

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      final decodedData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {
        // fineAmount = double.parse(decodedData["data"]["fine_amount"]);
        // prePaymentPercentage =
        //     double.parse(decodedData["data"]["pre_payment_percentage"]);
        // initialPrice = double.parse(decodedData["data"]["initial_price"]);
        // perKmPrice = double.parse(decodedData["data"]["per_km_price"]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
