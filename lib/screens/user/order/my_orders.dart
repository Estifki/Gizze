import 'package:ashewa_d/const/const.dart';
import 'package:ashewa_d/provider/auth/auth_user.dart';
import 'package:ashewa_d/provider/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widget/orders.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  bool _isinit = true;
  late Future _myOrders;

  @override
  void didChangeDependencies() {
    if (_isinit) {
      // Provider.of<OrderProvider>(context, listen: false).getSandAddress(
      //     Provider.of<UserAuthProvider>(context, listen: false).token!);
      _myOrders = Provider.of<OrderProvider>(context, listen: false).getPending(
          Provider.of<AuthProvider>(context, listen: false).token!, false);
      // Provider.of<OrderProvider>(context, listen: false).getOnTheWayOrders(
      //     Provider.of<AuthProvider>(context, listen: false).token!);
      // Provider.of<OrderProvider>(context, listen: false).getDelivered(
      //     Provider.of<AuthProvider>(context, listen: false).token!);
      Provider.of<OrderProvider>(context, listen: false).getRejected(
          Provider.of<AuthProvider>(context, listen: false).token!, false);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderProvider>(context, listen: false).getPending(
        Provider.of<AuthProvider>(context, listen: false).token!, false);
    // Provider.of<OrderProvider>(context, listen: false).getOnTheWayOrders(
    //     Provider.of<UserAuthProvider>(context, listen: false).token!);
    // Provider.of<OrderProvider>(context, listen: false).getDelivered(
    //     Provider.of<UserAuthProvider>(context, listen: false).token!);
    Provider.of<OrderProvider>(context, listen: false).getRejected(
        Provider.of<AuthProvider>(context, listen: false).token!, false);
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 10.0,
            bottom: const TabBar(
                labelColor: Colors.black,
                isScrollable: true,
                indicatorPadding: EdgeInsets.only(left: 25, right: 25),
                tabs: [
                  Tab(text: "Pending"),
                  Tab(text: "On the way"),
                  Tab(text: "Delivered"),
                  Tab(text: "Rejected"),
                ]),
          ),
          body: TabBarView(children: [
            FutureBuilder(
              future: _myOrders,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Error"));
                  } else {
                    return Consumer<OrderProvider>(
                      builder: (context, value, _) {
                        if (value.pendingOrderData.isEmpty) {
                          return const Center(
                              child: Text("No Pending Delivery"));
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.pendingOrderData.length,
                          padding: const EdgeInsets.only(top: 15),
                          itemBuilder: (context, index) {
                            return MyOrdersWidget(
                              orderID: value.pendingOrderData[index].id,
                              orderNo: value.pendingOrderData[index].orderNo,
                              totalPrice:
                                  value.pendingOrderData[index].totalPrice,
                              amount: value.pendingOrderData[index].amount,
                              pricePerCubic: value
                                  .pendingOrderData[index].sandLocation.price,
                              sandName: value.pendingOrderData[index]
                                  .sandLocation.sand.name,
                              sandImage: value.pendingOrderData[index]
                                  .sandLocation.sand.sandImage,
                              sourceLat: value.pendingOrderData[index]
                                  .sandLocation.destinationLocation.latitude,
                              sourceLong: value.pendingOrderData[index]
                                  .sandLocation.destinationLocation.longitude,
                              deliveryManName: value.pendingOrderData[index]
                                  .sandLocation.owner.name
                                  .toString(),
                              deliveryManPhone: value.pendingOrderData[index]
                                  .sandLocation.owner.phone
                                  .toString(),
                              destinationLat: value.pendingOrderData[index]
                                  .destinationLocation.latitude,
                              destinationLong: value.pendingOrderData[index]
                                  .destinationLocation.latitude,
                              sourceLocationName: value.pendingOrderData[index]
                                  .sandLocation.location.name,
                              destinationLocationName: value
                                  .pendingOrderData[index]
                                  .destinationLocation
                                  .locationName,
                            );
                          },
                        );
                      },
                    );
                  }
                }
              },
            ),
            //
            //On The way
            //

            Consumer<OrderProvider>(
              builder: (context, value, _) {
                if (value.onTheWayOrderData.isEmpty) {
                  return const Center(child: Text("No On The Way Delivery"));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.onTheWayOrderData.length,
                  padding: const EdgeInsets.only(top: 15),
                  itemBuilder: (context, index) {
                    return MyOrdersWidget(
                      orderID: value.onTheWayOrderData[index].id,
                      orderNo: value.onTheWayOrderData[index].orderNo,
                      totalPrice: value.onTheWayOrderData[index].totalPrice,
                      amount: value.onTheWayOrderData[index].amount,
                      pricePerCubic:
                          value.onTheWayOrderData[index].sandLocation.price,
                      sandName:
                          value.onTheWayOrderData[index].sandLocation.sand.name,
                      sandImage: value
                          .onTheWayOrderData[index].sandLocation.sand.sandImage,
                      sourceLat: value.onTheWayOrderData[index].sandLocation
                          .destinationLocation.latitude,
                      sourceLong: value.onTheWayOrderData[index].sandLocation
                          .destinationLocation.longitude,
                      deliveryManName: value
                          .onTheWayOrderData[index].sandLocation.owner.name
                          .toString(),
                      deliveryManPhone: value
                          .onTheWayOrderData[index].sandLocation.owner.phone
                          .toString(),
                      destinationLat: value.onTheWayOrderData[index]
                          .destinationLocation.latitude,
                      destinationLong: value.onTheWayOrderData[index]
                          .destinationLocation.latitude,
                      sourceLocationName: value
                          .onTheWayOrderData[index].sandLocation.location.name,
                      destinationLocationName: value.onTheWayOrderData[index]
                          .destinationLocation.locationName,
                    );
                  },
                );
              },
            ),

            //
            //On The way
            //
            Consumer<OrderProvider>(
              builder: (context, value, _) {
                if (value.deliveredOrderData.isEmpty) {
                  return const Center(
                      child: Text("Delivered Will Be Avaliable Here."));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.deliveredOrderData.length,
                  padding: const EdgeInsets.only(top: 15),
                  itemBuilder: (context, index) {
                    return MyOrdersWidget(
                      orderID: value.deliveredOrderData[index].id,
                      orderNo: value.deliveredOrderData[index].orderNo,
                      totalPrice: value.deliveredOrderData[index].totalPrice,
                      amount: value.deliveredOrderData[index].amount,
                      pricePerCubic:
                          value.deliveredOrderData[index].sandLocation.price,
                      sandName: value
                          .deliveredOrderData[index].sandLocation.sand.name,
                      sandImage: value.deliveredOrderData[index].sandLocation
                          .sand.sandImage,
                      sourceLat: value.deliveredOrderData[index].sandLocation
                          .destinationLocation.latitude,
                      sourceLong: value.deliveredOrderData[index].sandLocation
                          .destinationLocation.longitude,
                      deliveryManName: value
                          .deliveredOrderData[index].sandLocation.owner.name
                          .toString(),
                      deliveryManPhone: value
                          .deliveredOrderData[index].sandLocation.owner.phone
                          .toString(),
                      destinationLat: value.deliveredOrderData[index]
                          .destinationLocation.latitude,
                      destinationLong: value.deliveredOrderData[index]
                          .destinationLocation.latitude,
                      sourceLocationName: value
                          .deliveredOrderData[index].sandLocation.location.name,
                      destinationLocationName: value.deliveredOrderData[index]
                          .destinationLocation.locationName,
                    );
                  },
                );
              },
            ),

            //
            //Rejected Orders
            //

            Consumer<OrderProvider>(
              builder: (context, value, _) {
                if (value.rejectedOrderData.isEmpty) {
                  return const Center(child: Text("No On The Way Delivery"));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.rejectedOrderData.length,
                  padding: const EdgeInsets.only(top: 15),
                  itemBuilder: (context, index) {
                    return MyOrdersWidget(
                      orderID: value.rejectedOrderData[index].id,
                      orderNo: value.rejectedOrderData[index].orderNo,
                      totalPrice: value.rejectedOrderData[index].totalPrice,
                      amount: value.rejectedOrderData[index].amount,
                      pricePerCubic:
                          value.rejectedOrderData[index].sandLocation.price,
                      sandName:
                          value.rejectedOrderData[index].sandLocation.sand.name,
                      sandImage: value
                          .rejectedOrderData[index].sandLocation.sand.sandImage,
                      sourceLat: value.rejectedOrderData[index].sandLocation
                          .destinationLocation.latitude,
                      sourceLong: value.rejectedOrderData[index].sandLocation
                          .destinationLocation.longitude,
                      deliveryManName: value
                          .rejectedOrderData[index].sandLocation.owner.name,
                      deliveryManPhone: value
                          .rejectedOrderData[index].sandLocation.owner.phone
                          .toString(),
                      destinationLat: value.rejectedOrderData[index]
                          .destinationLocation.latitude,
                      destinationLong: value.rejectedOrderData[index]
                          .destinationLocation.latitude,
                      sourceLocationName: value
                          .rejectedOrderData[index].sandLocation.location.name,
                      destinationLocationName: value.rejectedOrderData[index]
                          .destinationLocation.locationName,
                    );
                  },
                );
              },
            ),
          ]),
        ));
  }
}
