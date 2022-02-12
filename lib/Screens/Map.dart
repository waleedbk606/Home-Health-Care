import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  late GoogleMapController _controller;

  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(33.7029293, 73.0529099));
  Set<Circle> mCircle = Set.from([
    Circle(
      circleId: CircleId('1'),
      center: LatLng(33.7029293, 73.0529099),
      radius: 3000,
    ),
    // Circle(
    //   circleId: CircleId('2'),
    //   center: LatLng(33.7029293, 73.0529099),
    //   radius: 500,
    // )
  ]);
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _initialPosition,
      mapType: MapType.normal,
      onMapCreated: (controller) {
        setState(() {
          _controller = controller;
        });
      },
      circles: mCircle,
    );
  }
}
