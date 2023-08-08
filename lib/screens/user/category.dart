import 'package:ashewa_d/const/const.dart';
import 'package:flutter/material.dart';

import '../../uitil/toast.dart';
import 'home.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  List categoryList = [
    {
      "name": "Sand",
      "status": "1",
    },
    {
      "name": "Gravel",
      "status": "0",
    },
    {
      "name": "Marble",
      "status": "0",
    },
    {
      "name": "Granite",
      "status": "0",
    },
    {
      "name": "Limestone",
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
        title: const Text("Category"),
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
                  if (categoryList[index]["status"] == "0") {
                    showScaffoldMessanger(
                        context: context,
                        errorMessage: "Comming Soon",
                        backgroundColor: Colors.green);
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreenForUser(),
                    ));
                  }
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
