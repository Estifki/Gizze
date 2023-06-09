import 'dart:async';

import 'package:ashewa_d/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderScreenForDriver extends StatefulWidget {
  const OrderScreenForDriver({super.key});

  @override
  State<OrderScreenForDriver> createState() => _OrderScreenForDriverState();
}

class _OrderScreenForDriverState extends State<OrderScreenForDriver> {
  static const LatLng sourceLocation = LatLng(8.91327, 39.92061);
  static const LatLng destinationLocation = LatLng(8.9806, 38.7751);

  List<LatLng> polyLineCoordinate = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyDXGVyh9MTUKU38syRDuzyWD0SBmUFkp2M",
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(
            destinationLocation.latitude, destinationLocation.longitude));
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
    return Scaffold(
        body: GoogleMap(
      mapType: MapType.satellite,
      indoorViewEnabled: true,
      // trafficEnabled: true,
      // liteModeEnabled: true,
      myLocationEnabled: true,
      initialCameraPosition:
          const CameraPosition(target: sourceLocation, zoom: 12.5),
      markers: {
        const Marker(markerId: MarkerId("source"), position: sourceLocation),
        const Marker(
            markerId: MarkerId("destination"), position: destinationLocation),
      },
      polylines: {
        Polyline(
            polylineId: const PolylineId("Route"),
            points: polyLineCoordinate,
            color: AppColor.primaryColor,
            width: 6)
      },
    ));
  }
}

// class GoogleMaps {
//   static CameraPosition getPropertyLocation(var lat, var long) {
//     return CameraPosition(
//       target: LatLng(lat, long),
//       zoom: 14,
//     );
//   }
// }

// // ignore: must_be_immutable
// class GoogleMapsItem extends StatelessWidget {
//   double latitude; //9.0044,38.7680
//   double lontitude;

//   GoogleMapsItem({super.key, this.latitude = 9.0044, this.lontitude = 38.7680});
//   final Completer<GoogleMapController> _controller = Completer();

//   List<Marker> marker = [];

//   @override
//   Widget build(BuildContext context) {
//     marker.add(Marker(
//       draggable: true,
//       markerId: MarkerId(""),
//       infoWindow: InfoWindow(title: ""),
//       position: LatLng(latitude, lontitude),
//     ));
//     return GoogleMap(
//       mapType: MapType.satellite,
//       indoorViewEnabled: true,
//       // trafficEnabled: true,
//       // liteModeEnabled: true,
//       myLocationEnabled: true,
//       initialCameraPosition:
//           GoogleMaps.getPropertyLocation(latitude, lontitude),
//       onMapCreated: (GoogleMapController controller) {
//         _controller.complete(controller);
//       },
//       markers: Set.from(marker),
//     );
//   }
// }
