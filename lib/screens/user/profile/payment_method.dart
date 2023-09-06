import 'package:ashewa_d/screens/user/profile/deposit.dart';
import 'package:flutter/material.dart';

import '../../../const/const.dart';

class PaymentMethodScreen extends StatelessWidget {
  PaymentMethodScreen({super.key});

  final List categoryList = [
    {
      "name": "CBE",
      "status": "1",
    },
    {
      "name": "Tele Birr",
      "status": "0",
    },
    {
      "name": "Awash",
      "status": "0",
    }
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Deposit", style: TextStyle(fontSize: 18)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: categoryList.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              childAspectRatio: 1.4,
              maxCrossAxisExtent: screenSize.width * 0.5,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // if (categoryList[index]["status"] == "0") {
                  //   showScaffoldMessanger(
                  //       context: context,
                  //       errorMessage: "Comming Soon",
                  //       backgroundColor: Colors.green);
                  // } else {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DepositScreen(
                      name: categoryList[index]["name"],
                    ),
                  ));
                  // }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.thirdColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      categoryList[index]["name"],
                      style:
                          const TextStyle(fontSize: 17.5, color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
