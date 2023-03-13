import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const/const.dart';

class OtpInputWidget extends StatelessWidget {
  final TextEditingController otpController;
  final bool isLast;

  const OtpInputWidget(
      {super.key, required this.otpController, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: AppColor.primaryColor)),
      child: TextField(
        controller: otpController,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.bottom,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.titleLarge,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (_) {
          if (otpController.text.trim().length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (isLast == true) {
            FocusScope.of(context).unfocus();
          }
        },
        decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent))),
      ),
    );
  }
}
