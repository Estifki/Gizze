import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final double leftcontentPadding;
  final bool isObsquired;
  const CustomTextFieldWidget(
      {super.key,
      required this.hint,
      required this.controller,
      this.isObsquired = false,
      this.leftcontentPadding = 10.0});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.26),
          borderRadius: BorderRadius.circular(6)),
      child: TextField(
        controller: controller,
        obscureText: isObsquired,
        // keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: hint,
            contentPadding: EdgeInsets.only(left: leftcontentPadding)),
      ),
    );
  }
}
