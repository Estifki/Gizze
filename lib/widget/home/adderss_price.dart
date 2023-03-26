import 'package:flutter/material.dart';

import '../../const/const.dart';

class AddressAndPriceWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  const AddressAndPriceWidget(
      {super.key, required this.title, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColor.primaryColor,
            size: 17,
          ),
          const SizedBox(width: 3),
          Text(
            title,
            maxLines: 1,
            style: const TextStyle(
                fontSize: 13,
                color: Colors.black,
                overflow: TextOverflow.ellipsis),
          ),
        ]);
  }
}
