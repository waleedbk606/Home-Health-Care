import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hhc/Models/Locations.dart';
import 'package:hhc/Screens/UpdateEmp.dart';

import '../Models/Employee.dart';

class EmpMap extends StatefulWidget {
  final Employee obj;
  final Locations locationsObj;
  const EmpMap({Key? key, required this.obj, required this.locationsObj})
      : super(key: key);

  @override
  State<EmpMap> createState() => _EmpMapState();
}

class _EmpMapState extends State<EmpMap> {
  late GoogleMapController _controller;
  double lat = 0.0;
  double long = 0.0;
  Locations locationsObj =
      new Locations(id: 0, orgName: "", lat: "", long: "", radius: "");
  List<Marker> MyMarker = [];
  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(33.7029293, 73.0529099),
    zoom: 12.0,
  );
  List<Circle> mCircle = [];
  //Set.from([
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

  TextEditingController RadiusController = TextEditingController();
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
              Container(
                width: 400,
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: RadiusController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter radius value in (km)',
                  ),
                ),
              ),
              Container(
                width: 400,
                height: 450,
                child: GoogleMap(
                  initialCameraPosition: _initialPosition,
                  mapType: MapType.normal,
                  onMapCreated: (controller) {
                    setState(() {
                      _controller = controller;
                    });
                  },
                  markers: Set.from(MyMarker),
                  circles: Set.from(mCircle),
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
                    print(RadiusController.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateEmp(
                                  obj: widget.obj,
                                  locationsObj: locationsObj,
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
    setState(() {
      MyMarker = [];
      mCircle = [];
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
      mCircle.add(
        Circle(
          circleId: CircleId(tappedPoint.toString()),
          center: LatLng(tappedPoint.latitude, tappedPoint.longitude),
          radius: double.parse(RadiusController.text + "000"),
        ),
      );
      lat = tappedPoint.latitude;
      long = tappedPoint.longitude;
      locationsObj.lat = tappedPoint.latitude.toString();
      locationsObj.long = tappedPoint.longitude.toString();
      locationsObj.radius = RadiusController.text;
    });
  }
}
