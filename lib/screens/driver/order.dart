import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderScreenForDriver extends StatefulWidget {
  const OrderScreenForDriver({super.key});

  @override
  State<OrderScreenForDriver> createState() => _OrderScreenForDriverState();
}

class _OrderScreenForDriverState extends State<OrderScreenForDriver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMapsItem(),
    );
  }
}

class GoogleMaps {
  static CameraPosition getPropertyLocation(var lat, var long) {
    return CameraPosition(
      target: LatLng(lat, long),
      zoom: 14,
    );
  }
}

// ignore: must_be_immutable
class GoogleMapsItem extends StatelessWidget {
  double latitude; //9.0044,38.7680
  double lontitude;

  GoogleMapsItem({super.key, this.latitude = 9.0044, this.lontitude = 38.7680});
  final Completer<GoogleMapController> _controller = Completer();

  List<Marker> marker = [];

  @override
  Widget build(BuildContext context) {
    marker.add(Marker(
      draggable: true,
      markerId: MarkerId(""),
      infoWindow: InfoWindow(title: ""),
      position: LatLng(latitude, lontitude),
    ));
    return GoogleMap(
      mapType: MapType.satellite,
      indoorViewEnabled: true,
      // trafficEnabled: true,
      // liteModeEnabled: true,
      myLocationEnabled: true,
      initialCameraPosition:
          GoogleMaps.getPropertyLocation(latitude, lontitude),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: Set.from(marker),
    );
  }
}
