import 'package:ashewa_d/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyOrdersDetailsScreen extends StatefulWidget {
  final String orderID;
  final String sandName;
  final String sandImage;

  final String amount;
  final String pricePerCubic;
  final String totalPrice;
  final double sourceLat;

  final String sourceName;
  final String destinationName;
  final double sourceLong;
  final double destinationLat;
  final double destinationLong;

  final String deliveryManName;

  final String deliveryManPhone;

  const MyOrdersDetailsScreen(
      {super.key,
      required this.orderID,
      required this.sandName,
      required this.sandImage,
      required this.sourceName,
      required this.destinationName,
      required this.amount,
      required this.pricePerCubic,
      required this.totalPrice,
      required this.sourceLat,
      required this.sourceLong,
      required this.destinationLat,
      required this.destinationLong,
      required this.deliveryManName,
      required this.deliveryManPhone});

  @override
  State<MyOrdersDetailsScreen> createState() => _MyOrdersDetailsScreenState();
}

class _MyOrdersDetailsScreenState extends State<MyOrdersDetailsScreen> {
  List<LatLng> polyLineCoordinate = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyDXGVyh9MTUKU38syRDuzyWD0SBmUFkp2M",
        PointLatLng(widget.sourceLat, widget.sourceLong),
        PointLatLng(widget.destinationLat, widget.destinationLong));
    if (result.points.isNotEmpty) {
      for (var points in result.points) {
        polyLineCoordinate.add(LatLng(points.latitude, points.longitude));
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(widget.sandName, style: const TextStyle(fontSize: 16)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(widget.sandImage, width: screenSize.width * 0.4),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Price /m²:  Br ${widget.pricePerCubic}",
                        style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 4),
                    Text("Ordered amount: ${widget.amount} m²",
                        style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 4),
                    Text("Total Price:  Br ${widget.totalPrice}",
                        style: const TextStyle(fontSize: 14)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            const Text("Delivery Man Info",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 5),
            Text("Name: ${widget.deliveryManName}",
                style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 5),
            Text("Phone: ${widget.deliveryManPhone}",
                style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            Text("${widget.sourceName} to ${widget.destinationName} ",
                style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 20),
            Container(
              height: screenSize.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: GoogleMap(
                  // mapType: MapType.satellite,
                  myLocationButtonEnabled: true,
                  indoorViewEnabled: true,
                  // trafficEnabled: true,
                  // liteModeEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(widget.sourceLat, widget.sourceLong),
                      zoom: 8),
                  markers: {
                    Marker(
                        markerId: const MarkerId("source"),
                        position: LatLng(widget.sourceLat, widget.sourceLong)),
                    Marker(
                        markerId: const MarkerId("destination"),
                        position: LatLng(
                            widget.destinationLat, widget.destinationLong)),
                  },
                  polylines: {
                    Polyline(
                        polylineId: const PolylineId("Route"),
                        points: polyLineCoordinate,
                        color: Colors.red.shade300,
                        width: 5)
                  },
                ),
              ),
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Scaffold(
                  body: SafeArea(
                    child: Stack(children: [
                      GoogleMapsFullScreen(
                        sourceLat: widget.sourceLat,
                        sourceLong: widget.sourceLong,
                        destinationLat: widget.destinationLat,
                        destinationLong: widget.destinationLong,
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.015,
                        left: MediaQuery.of(context).size.width * 0.05,
                        child: _navigatorPop(context),
                      ),
                    ]),
                  ),
                ),
              )),
              child: const Center(
                  child: Text(
                "View  Full-map",
                style: TextStyle(fontSize: 17, color: AppColor.primaryColor),
              )),
            ),
          ],
        ),
      ),
    );
  }

  _navigatorPop(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade100),
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
          size: 19,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class GoogleMapsFullScreen extends StatefulWidget {
  final double sourceLat;

  final double sourceLong;

  final double destinationLat;

  final double destinationLong;
  const GoogleMapsFullScreen(
      {super.key,
      required this.sourceLat,
      required this.sourceLong,
      required this.destinationLat,
      required this.destinationLong});
  @override
  State<GoogleMapsFullScreen> createState() => _GoogleMapsFullScreenState();
}

class _GoogleMapsFullScreenState extends State<GoogleMapsFullScreen> {
  List<LatLng> polyLineCoordinate = [];

  @override
  void initState() {
    getPolyPoints();
    super.initState();
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyDXGVyh9MTUKU38syRDuzyWD0SBmUFkp2M",
        PointLatLng(widget.sourceLat, widget.sourceLong),
        PointLatLng(widget.destinationLat, widget.destinationLong));
    if (result.points.isNotEmpty) {
      for (var points in result.points) {
        polyLineCoordinate.add(LatLng(points.latitude, points.longitude));
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: true,
      indoorViewEnabled: true,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
          target: LatLng(widget.sourceLat, widget.sourceLong), zoom: 6.5),
      markers: {
        Marker(
            markerId: const MarkerId("source"),
            position: LatLng(widget.sourceLat, widget.sourceLong)),
        Marker(
            markerId: const MarkerId("destination"),
            position: LatLng(widget.destinationLat, widget.destinationLong)),
      },
      polylines: {
        Polyline(
            polylineId: const PolylineId("Route"),
            points: polyLineCoordinate,
            color: Colors.red.shade300,
            width: 5)
      },
    );
  }
}
