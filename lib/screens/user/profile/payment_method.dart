
import '../../../provider/auth.dart';
import 'package:provider/provider.dart';

import '../../../uitil/toast.dart';
import 'deposit.dart';
import 'package:flutter/material.dart';

import '../../../const/const.dart';

class PaymentMethodScreen extends StatelessWidget {
  // final String remainingAmount;
  const PaymentMethodScreen({super.key});

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Provider.of<AuthProvider>(context).amount != "null"
                ? Container(
                    height: 100,
                    width: screenSize.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            spreadRadius: 2.0,
                            color: AppColor.primaryColor.withOpacity(0.1),
                            offset: const Offset(3, 3),
                          ),
                          BoxShadow(
                            blurRadius: 3.0,
                            spreadRadius: 1.0,
                            color: Colors.grey.withOpacity(0.2),
                            offset: const Offset(-1, -1),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Your Current Balance"),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              Provider.of<AuthProvider>(context, listen: false)
                                  .amount,
                              style: const TextStyle(
                                  fontSize: 16.5, color: AppColor.primaryColor),
                            )
                          ]),
                    ),
                  )
                : Container(),

            //
            //
            //
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: screenSize.height * 0.015),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: pay.length,
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
                      if (pay[index].status == false) {
                        showScaffoldMessanger(
                            context: context,
                            errorMessage: "Comming Soon",
                            backgroundColor: Colors.green);
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DepositScreen(
                              name: pay[index].title, id: pay[index].id),
                        ));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.thirdColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          pay[index].title,
                          style: const TextStyle(
                              fontSize: 17.5, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<PaymentMethod> pay = [
  PaymentMethod(
      id: "9a53db19-9b3f-4cef-a3b0-1ef0a992f483", title: "CBE", status: true),
  PaymentMethod(
      id: "9a53db19-9ae7-4357-9215-33b9c689b3b9",
      title: "Tele Birr",
      status: true),
  PaymentMethod(id: "3", title: "Awash"),
  PaymentMethod(id: "3", title: "Dashen"),
  PaymentMethod(id: "3", title: "Buna"),
  PaymentMethod(id: "3", title: "Abyssinia"),
];

class PaymentMethod {
  final String title;
  final String id;
  final bool status;
PaymentMethod({required this.id, required this.title, this.status = false});
}
