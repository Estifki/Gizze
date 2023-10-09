import '../../../provider/auth.dart';
import '../../../provider/orders.dart';
import '../../../provider/sand_location.dart';
import '../../../widget/orders_driver.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOrdersScreenForDriver extends StatefulWidget {
  const MyOrdersScreenForDriver({super.key});

  @override
  State<MyOrdersScreenForDriver> createState() =>
      _MyOrdersScreenForDriverState();
}

class _MyOrdersScreenForDriverState extends State<MyOrdersScreenForDriver> {
  bool isinit = true;
  late Future _myOrders;

  @override
  void didChangeDependencies() {
    if (isinit) {
      Provider.of<SandLocationProvider>(context, listen: false).getSandAddress(
          // Provider.of<AuthProvider>(context, listen: false).token!
          );
      _myOrders = Provider.of<OrderProvider>(context, listen: false).getPending(
          Provider.of<AuthProvider>(context, listen: false).token!, true);
      Provider.of<OrderProvider>(context, listen: false).getOnTheWayOrders(
          Provider.of<AuthProvider>(context, listen: false).token!, true);
      Provider.of<OrderProvider>(context, listen: false).getDelivered(
          Provider.of<AuthProvider>(context, listen: false).token!, true);
      // Provider.of<OrderProvider>(context, listen: false).getRejected(
      //     Provider.of<AuthProvider>(context, listen: false).token!, true);
      isinit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderProvider>(context, listen: false).getPending(
        Provider.of<AuthProvider>(context, listen: false).token!, true);
    Provider.of<OrderProvider>(context, listen: false).getOnTheWayOrders(
        Provider.of<AuthProvider>(context, listen: false).token!, true);
    Provider.of<OrderProvider>(context, listen: false).getDelivered(
        Provider.of<AuthProvider>(context, listen: false).token!, true);
    // Provider.of<OrderProvider>(context, listen: false).getRejected(
    //     Provider.of<AuthProvider>(context, listen: false).token!, true);
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
                            return MyOrdersWidgetForDriver(
                                orderID: value.pendingOrderData[index].id,
                                orderStatus: value
                                    .pendingOrderData[index].orderStatus.name,
                                orderNo: value.pendingOrderData[index].orderNo,
                                totalPrice:
                                    value.pendingOrderData[index].totalPrice,
                                amount: value
                                    .pendingOrderData[index].totalAmount
                                    .toString(),
                                pricePerCubic: value.pendingOrderData[index]
                                    .sandLocation!.price,
                                sandName: value.pendingOrderData[index]
                                    .sandLocation!.sand.name,
                                sandImage: value.pendingOrderData[index]
                                    .sandLocation!.sand.sandImage,
                                sourceLat: value.pendingOrderData[index]
                                    .destinationLocation.latitude,
                                sourceLong: value.pendingOrderData[index]
                                    .destinationLocation.longitude,
                                orderedUserName: value
                                    .pendingOrderData[index].orderedBy.name,
                                orderedUserPhone: value
                                    .pendingOrderData[index].orderedBy.phone,
                                destinationLat: value.pendingOrderData[index]
                                    .destinationLocation.latitude,
                                destinationLong: value.pendingOrderData[index]
                                    .destinationLocation.latitude,
                                sourceLocationName: value
                                    .pendingOrderData[index]
                                    .sandLocation!
                                    .location
                                    .name,
                                destinationLocationName: value
                                    .pendingOrderData[index]
                                    .destinationLocation
                                    .locationName,
                                date: value.pendingOrderData[index].createdAt);
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
                    return MyOrdersWidgetForDriver(
                        orderID: value.onTheWayOrderData[index].id,
                        orderStatus:
                            value.onTheWayOrderData[index].orderStatus.name,
                        orderNo: value.onTheWayOrderData[index].orderNo,
                        totalPrice: value.onTheWayOrderData[index].totalPrice,
                        amount: value.onTheWayOrderData[index].totalAmount
                            .toString(),
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
                        orderedUserName:
                            value.onTheWayOrderData[index].orderedBy.name,
                        orderedUserPhone:
                            value.onTheWayOrderData[index].orderedBy.phone,
                        destinationLat: value.onTheWayOrderData[index]
                            .destinationLocation.latitude,
                        destinationLong: value.onTheWayOrderData[index]
                            .destinationLocation.latitude,
                        sourceLocationName: value.onTheWayOrderData[index]
                            .sandLocation!.location.name,
                        destinationLocationName: value.onTheWayOrderData[index]
                            .destinationLocation.locationName,
                        date: value.onTheWayOrderData[index].createdAt);
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
                    return MyOrdersWidgetForDriver(
                        orderID: value.deliveredOrderData[index].id,
                        orderStatus:
                            value.deliveredOrderData[index].orderStatus.name,
                        orderNo: value.deliveredOrderData[index].orderNo,
                        totalPrice: value.deliveredOrderData[index].totalPrice,
                        amount: value.deliveredOrderData[index].totalAmount
                            .toString(),
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
                        orderedUserName:
                            value.deliveredOrderData[index].orderedBy.name,
                        orderedUserPhone:
                            value.deliveredOrderData[index].orderedBy.phone,
                        destinationLat: value.deliveredOrderData[index]
                            .destinationLocation.latitude,
                        destinationLong: value.deliveredOrderData[index]
                            .destinationLocation.latitude,
                        sourceLocationName: value.deliveredOrderData[index]
                            .sandLocation!.location.name,
                        destinationLocationName: value.deliveredOrderData[index]
                            .destinationLocation.locationName,
                        date: value.deliveredOrderData[index].createdAt);
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
                    return MyOrdersWidgetForDriver(
                        orderID: value.rejectedOrderData[index].id,
                        orderStatus:
                            value.rejectedOrderData[index].orderStatus.name,
                        orderNo: value.rejectedOrderData[index].orderNo,
                        totalPrice: value.rejectedOrderData[index].totalPrice,
                        amount: value.rejectedOrderData[index].totalAmount
                            .toString(),
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
                        orderedUserName:
                            value.rejectedOrderData[index].orderedBy.name,
                        orderedUserPhone:
                            value.rejectedOrderData[index].orderedBy.phone,
                        destinationLat: value.rejectedOrderData[index]
                            .destinationLocation.latitude,
                        destinationLong: value.rejectedOrderData[index]
                            .destinationLocation.latitude,
                        sourceLocationName: value.rejectedOrderData[index]
                            .sandLocation!.location.name,
                        destinationLocationName: value.rejectedOrderData[index]
                            .destinationLocation.locationName,
                        date: value.rejectedOrderData[index].createdAt);
                  },
                );
              },
            ),
          ]),
        ));
  }
}
