import '../../../provider/auth.dart';
import '../../../provider/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/sand_location.dart';
import '../../../widget/orders_user.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  bool isinit = true;
  late Future _myOrders;

  @override
  void didChangeDependencies() {
    if (isinit) {
      Provider.of<SandLocationProvider>(context, listen: false).getSandAddress(
          Provider.of<AuthProvider>(context, listen: false).token!);
      _myOrders = Provider.of<OrderProvider>(context, listen: false).getPending(
          Provider.of<AuthProvider>(context, listen: false).token!, false);
      Provider.of<OrderProvider>(context, listen: false).getOnTheWayOrders(
          Provider.of<AuthProvider>(context, listen: false).token!, false);
      Provider.of<OrderProvider>(context, listen: false).getDelivered(
          Provider.of<AuthProvider>(context, listen: false).token!, false);
      // Provider.of<OrderProvider>(context, listen: false).getRejected(
      //     Provider.of<AuthProvider>(context, listen: false).token!, false);
      isinit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderProvider>(context, listen: false).getPending(
        Provider.of<AuthProvider>(context, listen: false).token!, false);
    Provider.of<OrderProvider>(context, listen: false).getOnTheWayOrders(
        Provider.of<AuthProvider>(context, listen: false).token!, false);
    Provider.of<OrderProvider>(context, listen: false).getDelivered(
        Provider.of<AuthProvider>(context, listen: false).token!, false);
    // Provider.of<OrderProvider>(context, listen: false).getRejected(
    //     Provider.of<AuthProvider>(context, listen: false).token!, false);
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
                  Tab(text: "On The Way"),
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
                            return MyOrdersWidgetUser(
                              orderID: value.pendingOrderData[index].id,
                              orderNo: value.pendingOrderData[index].orderNo,
                              totalPrice: (int.parse(value
                                          .pendingOrderData[index]
                                          .sandLocation!
                                          .price) *
                                      15)
                                  .toString(),
                              // value.pendingOrderData[index].totalPrice,
                              amount: value.pendingOrderData[index].totalAmount
                                  .toString(),
                              orderStatus: value
                                  .pendingOrderData[index].orderStatus.name,
                              pricePerCubic: value
                                  .pendingOrderData[index].sandLocation!.price,
                              sandName: value.pendingOrderData[index]
                                  .sandLocation!.sand.name,
                              sandImage: value.pendingOrderData[index]
                                  .sandLocation!.sand.sandImage,
                              sourceLat: value.pendingOrderData[index]
                                  .destinationLocation.latitude,
                              sourceLong: value.pendingOrderData[index]
                                  .destinationLocation.longitude,
                              deliveryManName: value.pendingOrderData[index]
                                  .sandLocation!.owner.name
                                  .toString(),
                              deliveryManPhone: value.pendingOrderData[index]
                                  .sandLocation!.owner.phone
                                  .toString(),
                              destinationLat: value.pendingOrderData[index]
                                  .destinationLocation.latitude,
                              destinationLong: value.pendingOrderData[index]
                                  .destinationLocation.latitude,
                              sourceLocationName: value.pendingOrderData[index]
                                  .sandLocation!.location.name,
                              destinationLocationName: value
                                  .pendingOrderData[index]
                                  .destinationLocation
                                  .locationName,
                              date: value.pendingOrderData[index].createdAt,
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
                    return MyOrdersWidgetUser(
                      orderID: value.onTheWayOrderData[index].id,
                      orderNo: value.onTheWayOrderData[index].orderNo,
                      totalPrice: (int.parse(value.onTheWayOrderData[index]
                                  .sandLocation!.price) *
                              15)
                          .toString(),
                      //value.onTheWayOrderData[index].totalPrice,
                      amount:
                          value.onTheWayOrderData[index].totalAmount.toString(),
                      orderStatus:
                          value.onTheWayOrderData[index].orderStatus.name,
                      pricePerCubic:
                          value.onTheWayOrderData[index].sandLocation!.price,
                      sandName: value
                          .onTheWayOrderData[index].sandLocation!.sand.name,
                      sandImage: value.onTheWayOrderData[index].sandLocation!
                          .sand.sandImage,
                      sourceLat: value.onTheWayOrderData[index]
                          .destinationLocation.latitude,
                      sourceLong: value.onTheWayOrderData[index]
                          .destinationLocation.longitude,
                      deliveryManName: value
                          .onTheWayOrderData[index].sandLocation!.owner.name
                          .toString(),
                      deliveryManPhone: value
                          .onTheWayOrderData[index].sandLocation!.owner.phone
                          .toString(),
                      destinationLat: value.onTheWayOrderData[index]
                          .destinationLocation.latitude,
                      destinationLong: value.onTheWayOrderData[index]
                          .destinationLocation.latitude,
                      sourceLocationName: value
                          .onTheWayOrderData[index].sandLocation!.location.name,
                      destinationLocationName: value.onTheWayOrderData[index]
                          .destinationLocation.locationName,
                      date: value.onTheWayOrderData[index].createdAt,
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
                    return MyOrdersWidgetUser(
                      orderID: value.deliveredOrderData[index].id,
                      orderNo: value.deliveredOrderData[index].orderNo,
                      totalPrice: (int.parse(value.deliveredOrderData[index]
                                  .sandLocation!.price) *
                              15)
                          .toString(),
                      amount: value.deliveredOrderData[index].totalAmount
                          .toString(),
                      orderStatus:
                          value.deliveredOrderData[index].orderStatus.name,
                      pricePerCubic:
                          value.deliveredOrderData[index].sandLocation!.price,
                      sandName: value
                          .deliveredOrderData[index].sandLocation!.sand.name,
                      sandImage: value.deliveredOrderData[index].sandLocation!
                          .sand.sandImage,
                      sourceLat: value.deliveredOrderData[index]
                          .destinationLocation.latitude,
                      sourceLong: value.deliveredOrderData[index]
                          .destinationLocation.longitude,
                      deliveryManName: value
                          .deliveredOrderData[index].sandLocation!.owner.name
                          .toString(),
                      deliveryManPhone: value
                          .deliveredOrderData[index].sandLocation!.owner.phone
                          .toString(),
                      destinationLat: value.deliveredOrderData[index]
                          .destinationLocation.latitude,
                      destinationLong: value.deliveredOrderData[index]
                          .destinationLocation.latitude,
                      sourceLocationName: value.deliveredOrderData[index]
                          .sandLocation!.location.name,
                      destinationLocationName: value.deliveredOrderData[index]
                          .destinationLocation.locationName,
                      date: value.deliveredOrderData[index].createdAt,
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
                  return const Center(child: Text("No Rejected Delivery"));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.rejectedOrderData.length,
                  padding: const EdgeInsets.only(top: 15),
                  itemBuilder: (context, index) {
                    return MyOrdersWidgetUser(
                      orderID: value.rejectedOrderData[index].id,
                      orderNo: value.rejectedOrderData[index].orderNo,
                      totalPrice: (int.parse(value.rejectedOrderData[index]
                                  .sandLocation!.price) *
                              15)
                          .toString(),
                      amount:
                          value.rejectedOrderData[index].totalAmount.toString(),
                      orderStatus:
                          value.rejectedOrderData[index].orderStatus.name,
                      pricePerCubic:
                          value.rejectedOrderData[index].sandLocation!.price,
                      sandName: value
                          .rejectedOrderData[index].sandLocation!.sand.name,
                      sandImage: value.rejectedOrderData[index].sandLocation!
                          .sand.sandImage,
                      sourceLat: value.rejectedOrderData[index]
                          .destinationLocation.latitude,
                      sourceLong: value.rejectedOrderData[index]
                          .destinationLocation.longitude,
                      deliveryManName: value
                          .rejectedOrderData[index].sandLocation!.owner.name,
                      deliveryManPhone: value
                          .rejectedOrderData[index].sandLocation!.owner.phone
                          .toString(),
                      destinationLat: value.rejectedOrderData[index]
                          .destinationLocation.latitude,
                      destinationLong: value.rejectedOrderData[index]
                          .destinationLocation.latitude,
                      sourceLocationName: value
                          .rejectedOrderData[index].sandLocation!.location.name,
                      destinationLocationName: value.rejectedOrderData[index]
                          .destinationLocation.locationName,
                      date: value.rejectedOrderData[index].createdAt,
                    );
                  },
                );
              },
            ),
          ]),
        ));
  }
}
