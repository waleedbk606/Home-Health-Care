import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hhc/Models/DropDownModel.dart';
import 'package:hhc/Models/Organization.dart';
import 'package:hhc/Models/Services.dart';
import 'package:hhc/Models/Users.dart';
import 'package:hhc/Screens/Appointment.dart';
import 'package:hhc/Screens/NavDrawer.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../Urls.dart';

class hhcHome extends StatefulWidget {
  final String username, password;
  const hhcHome({Key? key, required this.username, required this.password})
      : super(key: key);

  @override
  _hhcHomeState createState() => _hhcHomeState();
}

class _hhcHomeState extends State<hhcHome> {
  List<Organization> locations = [];
  List<Welcome> _Staff = [];
  List<Services> _Service = [];
  var obj;
  String selectedName = "Pims";
  String selectedstaff = "Nurse";
  String selectedServices = "Wound Dressing";
  String selectedItration = 'Once';

  Future<User> fetchUserDetails(String Username, String Password) async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}/HhcApi/api/Login/GetUserDetails?Username=${Username}&Password=${Password}'));
    if (response.statusCode == 200) {
      User paresd = userFromJson(response.body);
      obj = paresd;
      print(paresd.fname);
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Organization>> fetchDropORG() async {
    final response = await http
        .get(Uri.parse('http://${Url.ip}/HhcApi/api/Login/GetDropOrg'));
    if (response.statusCode == 200) {
      List<Organization> Locations = organizationFromJson(response.body);
      setState(() {
        locations.addAll(Locations);
      });
      print(locations.elementAt(1));
      return locations;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Welcome>> fetchDepartment() async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}/HhcApi/api/Login/GetDepartments?Org=${selectedName}'));
    if (response.statusCode == 200) {
      List<Welcome> Staff = welcomeFromJson(response.body);
      setState(() {
        _Staff = [];
        selectedstaff = "Nurse";
        _Staff.addAll(Staff);
      });
      return _Staff;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Services>> fetchDropServices() async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}/HhcApi/api/Login/ViewServices?Org=${selectedName}&dep=${selectedstaff}'));
    if (response.statusCode == 200) {
      List<Services> services = servicesFromJson(response.body);
      setState(() {
        _Service = [];
        selectedServices = "Wound Dressing";
        _Service.addAll(services);
      });
      //print(_Service.elementAt(1));
      return _Service;
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDropORG();
    fetchUserDetails(widget.username, widget.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(obj: obj),
      appBar: AppBar(
        title: Text('Home Health Care'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        'Organizations',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                      DropdownButton(
                        autofocus: true,
                        hint: Text(
                          'Organizations',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 35,
                            color: Colors.teal,
                          ),
                        ),
                        value: selectedName,
                        onChanged: (String? newValue) {
                          setState(
                            () {
                              selectedName = newValue!;
                              fetchDepartment();
                            },
                          );
                        },
                        items: locations.map((item) {
                          return DropdownMenuItem(
                            child: new Text(item.name),
                            value: item.name,
                          );
                        }).toList(),
                        dropdownColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        'Medical Staff',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                      DropdownButton(
                        autofocus: true,
                        key: UniqueKey(),
                        value: selectedstaff,
                        onChanged: (String? newValue) {
                          setState(
                            () {
                              selectedstaff = newValue!;
                              fetchDropServices();
                            },
                          );
                        },
                        items: _Staff.map((location) {
                          return DropdownMenuItem(
                            child: new Text(location.department),
                            value: location.department,
                          );
                        }).toList(),
                        dropdownColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        'Type of Services',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      DropdownButton(
                        autofocus: true,
                        key: UniqueKey(),
                        value: selectedServices,
                        onChanged: (String? newValue) {
                          setState(
                            () {
                              selectedServices = newValue!;
                            },
                          );
                        },
                        items: _Service.map((item) {
                          return DropdownMenuItem(
                            child: new Text(item.name),
                            value: item.name,
                          );
                        }).toList(),
                        dropdownColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Container(
              //   child: Row(
              //     children: [
              //       Row(
              //         children: [
              //           SizedBox(
              //             width: 40,
              //           ),
              //           Text(
              //             'Once',
              //             style: TextStyle(
              //               fontSize: 20,
              //               color: Colors.teal,
              //             ),
              //           ),
              //           Radio(
              //             groupValue: selectedItration,
              //             value: 'Once',
              //             onChanged: (String? val) {
              //               setState(() {
              //                 selectedItration = val!;
              //                 print(selectedItration);
              //               });
              //             },
              //           ),
              //         ],
              //       ),
              //       SizedBox(
              //         width: 100,
              //       ),
              //       Row(
              //         children: [
              //           Text(
              //             'Repeted',
              //             style: TextStyle(
              //               fontSize: 20,
              //               color: Colors.teal,
              //             ),
              //           ),
              //           Radio(
              //             groupValue: selectedItration,
              //             value: 'Repeted',
              //             onChanged: (String? val) {
              //               setState(() {
              //                 selectedItration = val!;
              //                 print(selectedItration);
              //               });
              //             },
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 60,
              ),
              Container(
                width: 200,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Appointment(
                                  service: selectedServices,
                                  userObj: obj,
                                  org: selectedName,
                                  dep: selectedstaff,
                                )));
                  },
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(20),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
