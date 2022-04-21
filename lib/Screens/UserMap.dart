import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hhc/Screens/Appointment.dart';

import '../Models/Users.dart';

class UserMap extends StatefulWidget {
  final String service;
  final User userObj;
  final String org;
  final String dep;
  final double lat, lng;
  const UserMap(
      {Key? key,
      required this.service,
      required this.userObj,
      required this.org,
      required this.dep,
      required this.lat,
      required this.lng})
      : super(key: key);

  @override
  State<UserMap> createState() => _UserMapState();
}

class _UserMapState extends State<UserMap> {
  late GoogleMapController _controller;
  double lat = 0.0;
  double long = 0.0;
  List<Marker> MyMarker = [];
  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(33.7029293, 73.0529099),
    zoom: 12.0,
  );
  // Set<Circle> mCircle = Set.from([
  //   Circle(
  //     circleId: CircleId('1'),
  //     center: LatLng(33.7029293, 73.0529099),
  //     radius: 3000,
  //   ),
  //   // Circle(
  //   //   circleId: CircleId('2'),
  //   //   center: LatLng(33.6176001, 73.0529099),
  //   //   radius: 3000,
  //   // )
  // ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Mark Location")),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                width: 400,
                height: 550,
                child: GoogleMap(
                  initialCameraPosition: _initialPosition,
                  mapType: MapType.normal,
                  onMapCreated: (controller) {
                    setState(() {
                      _controller = controller;
                    });
                  },
                  markers: Set.from(MyMarker),
                  onTap: handelTap,
                  // circles: mCircle,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 60,
                width: 200,
                padding: EdgeInsets.all(10),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Done',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    print(lat);
                    print(long);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Appointment(
                                  service: widget.service,
                                  org: widget.org,
                                  dep: widget.dep,
                                  userObj: widget.userObj,
                                  lat: lat,
                                  lng: long,
                                )));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  handelTap(LatLng tappedPoint) {
    print(tappedPoint);
    setState(() {
      MyMarker = [];
      MyMarker.add(
        Marker(
            markerId: MarkerId(
              tappedPoint.toString(),
            ),
            position: tappedPoint,
            draggable: true,
            onDragEnd: (dragEndPossition) {
              print(dragEndPossition);
            }),
      );
      lat = tappedPoint.latitude;
      long = tappedPoint.longitude;
    });
  }
}
