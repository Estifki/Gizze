import 'package:flutter/material.dart';

showScaffoldMessanger(
    {required BuildContext context,
    required String errorMessage,
    Color? backgroundColor = Colors.red,
    double? width = 180.0}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width: width,
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      content: Text(
        errorMessage,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      duration: const Duration(milliseconds: 2000),
      padding: const EdgeInsets.all(16),
    ),
  );
}
