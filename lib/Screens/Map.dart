import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Models/Locations.dart';
import 'AddOrg.dart';

class Map extends StatefulWidget {
  const Map({
    Key? key,
  }) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  late GoogleMapController _controller;
  double lat = 0.0;
  double long = 0.0;
  List<Marker> MyMarker = [];
  List<Circle> mCircle = [];
  List<Locations> OrgLocations = [];
  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(33.7029293, 73.0529099),
    zoom: 12.0,
  );

  // Set.from([
  //   Circle(
  //     circleId: CircleId('1'),
  //     center: LatLng(33.7029293, 73.0529099),
  //     radius: 3000,
  //   ),
  // Circle(
  //   circleId: CircleId('2'),
  //   center: LatLng(33.6176001, 73.0529099),
  //   radius: 3000,
  // )
  //]);

  void Addlocation(List<Marker> Marker, List<Circle> Circle) {
    Locations obj =
        new Locations(id: 0, orgName: "", lat: "", long: "", radius: "");
    for (int i = 1; i <= Marker.length; i++) {
      obj.lat = Marker[i].position.latitude.toString();
      obj.long = Marker[i].position.longitude.toString();
      obj.radius = Circle[i].radius.toString();
      OrgLocations.add(obj);
    }
    for (int i = 1; i <= OrgLocations.length; i++) {
      print("${i}:Latitude" + OrgLocations[i].lat);
      print("${i}:Longitude" + OrgLocations[i].long);
      print("${i}:radius" + OrgLocations[i].radius);
    }
  }

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
                width: 300,
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
                height: 500,
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
                height: 15,
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
                    print(MyMarker.length);
                    print(mCircle.length);
                    print(OrgLocations.length);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddOrg(OrgList: OrgLocations),
                      ),
                    );
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
    });
    OrgLocations = [];
    for (int i = 0; i < MyMarker.length; i++) {
      print("${i + 1}st Circle" +
          "  ${mCircle[i].radius} " +
          "${MyMarker[i].position}");
      Locations obj = new Locations(
          id: i,
          orgName: "",
          lat: MyMarker[i].position.latitude.toString(),
          long: MyMarker[i].position.longitude.toString(),
          radius: mCircle[i].radius.toString());
      OrgLocations.add(obj);
      obj = new Locations(id: 0, orgName: "", lat: "", long: "", radius: "");
    }
    print(OrgLocations.length);
    for (int i = 0; i < OrgLocations.length; i++) {
      print("${i}:Id " + OrgLocations[i].id.toString());
      print("${i}:Latitude " + OrgLocations[i].lat);
      print("${i}:Longitude " + OrgLocations[i].long);
      print("${i}:radius " + OrgLocations[i].radius);
    }
  }
}
