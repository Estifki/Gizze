import 'details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const/const.dart';
import '../../../provider/auth.dart';
import '../../../provider/sand_location.dart';

class MySandScreen extends StatefulWidget {
  const MySandScreen({super.key});

  @override
  State<MySandScreen> createState() => _MySandScreenState();
}

class _MySandScreenState extends State<MySandScreen> {
  bool isInit = true;
  late Future _sandData;

  @override
  void didChangeDependencies() {
    if (isInit) {
      _sandData = Provider.of<SandLocationProvider>(context, listen: false)
          .getMySandLocation(Provider.of<AuthProvider>(context).token!);
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text("My Sands"),
        centerTitle: true,
      ),
      body: Provider.of<SandLocationProvider>(context).mySandData.isNotEmpty
          ? const MySandWidget()
          : FutureBuilder(
              future: _sandData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                  // return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Unknown Error"));
                } else {
                  // return HomeShimmer();
                  return const MySandWidget();
                }
              }),
    );
  }
}

class MySandWidget extends StatelessWidget {
  const MySandWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Consumer<SandLocationProvider>(
        builder: (context, value, _) {
          if (value.mySandData.isEmpty) {
            return const Center(
              child: Text("No sand"),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: value.mySandData.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 15.0, bottom: 10),
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(top: 15.0, right: 15),
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  height: screenSize.height * 0.18,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //
                      //Image
                      //
                      const SizedBox(width: 8),
                      Image.network(value.mySandData[index].sand.sandImage,
                          width: screenSize.width * 0.43),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //
                                //Product Name
                                //
                                Text(
                                  value.mySandData[index].sand.name,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 3),
                                //
                                //Product Descrption
                                //
                                Text(
                                  value.mySandData[index].sand.description,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.black),
                                ),

                                //
                                //Add Sand Button
                                //
                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateMySandScreen(
                                                sandID:
                                                    value.mySandData[index].id,
                                                sandName: value
                                                    .mySandData[index]
                                                    .sand
                                                    .name,
                                                sandPrice: value
                                                    .mySandData[index].price,
                                              ))),
                                  child: Container(
                                    width: screenSize.width,
                                    height: screenSize.height * 0.044,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(right: 5.0),
                                    decoration: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(6.0)),
                                    child: const Text("Update Sand",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white),
                                        textAlign: TextAlign.center),
                                  ),
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        // child:
      ),
    );
  }
}
