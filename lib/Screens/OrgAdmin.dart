import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hhc/Models/Employee.dart';
import 'package:hhc/Models/Organization.dart';
import 'package:hhc/Screens/AddEmp.dart';
import 'package:hhc/Screens/AddService.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Urls.dart';

class service {
  String id;
  String Name;
  String Discription;
  String Staff;
  String Charges;
  String Organization;

  service({
    required this.id,
    required this.Name,
    required this.Discription,
    required this.Staff,
    required this.Charges,
    required this.Organization,
  });

  factory service.fromJson(Map<String, dynamic> json) {
    return service(
      id: json['id'].toString(),
      Name: json['Name'],
      Discription: json['Discription'],
      Staff: json['Staff'],
      Charges: json['Charges'],
      Organization: json['Organization'],
    );
  }
}

class OrgAdmin extends StatefulWidget {
  final Organization OrgObj;

  const OrgAdmin({Key? key, required this.OrgObj}) : super(key: key);

  @override
  _OrgAdminState createState() => _OrgAdminState();
}

class _OrgAdminState extends State<OrgAdmin> {
  late Organization obj = widget.OrgObj;
  List<String> locations = [
    "Nurse",
    "Physio",
    "Vaccinator",
    "General Physician",
  ];
  String selectedName = "Nurse";
  String Department = '';
  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  Future<Organization> fetchUserDetails(
      String Username, String Password) async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}/HhcApi/api/Login/GetOrgDetails?Username=${Username}&Password=${Password}'));
    if (response.statusCode == 200) {
      Organization paresd = OrganizationFromJson(response.body);
      print(paresd.name);
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Employee>> fetchEmpDep(String department, String OrgName) async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}/HhcApi/api/Login/DepDropOrg?Dep=${department}&Org=${OrgName}'));
    if (response.statusCode == 200) {
      List<Employee> paresd = employeeFromJson(response.body);
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  // Future<List<Welcome>> fetchDepartment() async {
  //   final response = await http
  //       .get(Uri.parse('http://${Url.ip}/HhcApi/api/Login/GetDepartments'));
  //   if (response.statusCode == 200) {
  //     List<Welcome> Locations = welcomeFromJson(response.body);
  //     setState(() {
  //       locations.addAll(Locations);
  //     });
  //     print(locations.elementAt(1));
  //     return locations;
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  Future<List<Employee>> DeleteEmp(int id) async {
    final response = await http.delete(
        Uri.parse('http://${Url.ip}/HhcApi/api/Login/DeleteService?id=${id}'));
    if (response.statusCode == 200) {
      List<Employee> data = employeeFromJson(response.body);
      return data;
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<Employee>> futureorg;

  //late Future<List<service>> futureService;

  @override
  void initState() {
    super.initState();
    // futureService = fetchServices(obj.name);
  }

  int selectiteam = 0;
  Color colorCard = Colors.white;
  var set;
  int eid = 0;
  int id = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(obj.name + " " + "Admin"),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.badge),
                  text: 'Employees',
                ),
                Tab(
                  icon: Icon(
                    Icons.medical_services,
                  ),
                  text: 'Services',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 200,
                            height: 50,
                            child: DropdownButton(
                              autofocus: true,
                              focusColor: Colors.white,
                              isExpanded: true,
                              hint: Text(
                                'Select Department',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                  color: Colors.teal,
                                ),
                              ),
                              onChanged: (String? value) {
                                setState(
                                  () {
                                    this.selectedName = value!;
                                    Department = selectedName;
                                    print(Department);
                                    // fetchEmpDep(Department);
                                  },
                                );
                              },
                              value: selectedName,
                              items: locations.map((item) {
                                return DropdownMenuItem(
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal,
                                    ),
                                  ),
                                  value: item,
                                );
                              }).toList(),
                              dropdownColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person_add_outlined,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                Text(
                                  "Add",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddEmp(
                                    obj: obj,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<List<Employee>>(
                        future: fetchEmpDep(Department, obj.name),
                        key: UniqueKey(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onLongPress: () {
                                    setState(() {});
                                  },
                                  onTap: () {
                                    setState(() {
                                      selectiteam = int.parse(
                                          snapshot.data![index].eid.toString());
                                      _onSelected(index);
                                      print(snapshot.data![index].fname);
                                      print(selectiteam);
                                    });
                                  },
                                  child: Card(
                                    // color: (_selectedIndex != null &&
                                    //         _selectedIndex == index)
                                    //     ? Colors.red[300]
                                    //     : Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 225,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Name:  ",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          snapshot.data![index]
                                                              .fname,
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors
                                                                .lightBlueAccent,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Text(
                                                          snapshot.data![index]
                                                              .lname,
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors
                                                                .lightBlueAccent,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Gender:  ",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          snapshot.data![index]
                                                              .gender,
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            //fontWeight: FontWeight.w500,
                                                            //color: Colors.teal,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Qulification:  ",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          snapshot.data![index]
                                                              .qualification,
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            //fontWeight: FontWeight.w500,
                                                            //color: Colors.teal,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Email:  ",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          snapshot.data![index]
                                                              .email,
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 100,
                                                height: 110,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      width: 30,
                                                    ),
                                                    // Container(
                                                    //   height: 30,
                                                    //   width: 60,
                                                    //   child: TextButton(
                                                    //     style: ButtonStyle(
                                                    //       backgroundColor:
                                                    //           MaterialStateProperty
                                                    //               .all<Color>(
                                                    //                   Colors
                                                    //                       .blue),
                                                    //       shape: MaterialStateProperty
                                                    //           .all<
                                                    //               RoundedRectangleBorder>(
                                                    //         RoundedRectangleBorder(
                                                    //           borderRadius:
                                                    //               BorderRadius
                                                    //                   .circular(
                                                    //                       30.0),
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //     child: Row(
                                                    //       children: [
                                                    //         Icon(
                                                    //           Icons
                                                    //               .manage_accounts_rounded,
                                                    //           color:
                                                    //               Colors.white,
                                                    //           size: 10,
                                                    //         ),
                                                    //         Text(
                                                    //           "Update",
                                                    //           style: TextStyle(
                                                    //             fontSize: 10,
                                                    //             color: Colors
                                                    //                 .white,
                                                    //           ),
                                                    //         ),
                                                    //       ],
                                                    //     ),
                                                    //     onPressed: () {
                                                    //       eid = snapshot
                                                    //           .data![index].eid;
                                                    //       print(eid);
                                                    //       if (eid != null) {
                                                    //         Navigator.push(
                                                    //           context,
                                                    //           MaterialPageRoute(
                                                    //             builder:
                                                    //                 (context) =>
                                                    //                     UpdateEmp(
                                                    //               id: eid,
                                                    //               OrgName: snapshot
                                                    //                   .data![
                                                    //                       index]
                                                    //                   .orgName,
                                                    //               Department: snapshot
                                                    //                   .data![
                                                    //                       index]
                                                    //                   .department,
                                                    //               Status: snapshot
                                                    //                   .data![
                                                    //                       index]
                                                    //                   .status,
                                                    //               obj: obj,
                                                    //             ),
                                                    //           ),
                                                    //         );
                                                    //       }
                                                    //     },
                                                    //   ),
                                                    // ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Container(
                                                      height: 30,
                                                      width: 60,
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      Colors
                                                                          .red),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                            ),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .delete_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 10,
                                                            ),
                                                            Text(
                                                              "Delete",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        onPressed: () {
                                                          eid = snapshot
                                                              .data![index].eid;
                                                          print(eid);
                                                          if (eid != null) {
                                                            setState(
                                                              () {
                                                                DeleteEmp(eid);
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            OrgAdmin(
                                                                      OrgObj:
                                                                          obj,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                            // Text(snapshot.data!.name);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Service screen

              Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.list_alt_outlined,
                            size: 35,
                            color: Colors.lightBlueAccent,
                          ),
                          Text(
                            'Services List',
                            style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                'Add Services',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddService(obj: obj)));
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<List<service>>(
                        future: fetchServices(obj.name),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onLongPress: () {
                                    setState(() {});
                                  },
                                  onTap: () {
                                    setState(() {
                                      selectiteam =
                                          int.parse(snapshot.data![index].id);
                                      _onSelected(index);
                                      print(snapshot.data![index].Name);
                                      print(selectiteam);
                                    });
                                  },
                                  child: Card(
                                    // color: (_selectedIndex != null &&
                                    //         _selectedIndex == index)
                                    //     ? Colors.red[300]
                                    //     : Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 250,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Name:  ",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      snapshot
                                                          .data![index].Name,
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors
                                                            .lightBlueAccent,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Description:  ",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      snapshot.data![index]
                                                          .Discription,
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        //fontWeight: FontWeight.w500,
                                                        //color: Colors.teal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Staff Required:  ",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      snapshot
                                                          .data![index].Staff,
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        //fontWeight: FontWeight.w500,
                                                        //color: Colors.teal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Charges:  ",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      snapshot
                                                          .data![index].Charges,
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 70,
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 60,
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.blue),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .manage_accounts_rounded,
                                                          color: Colors.white,
                                                          size: 10,
                                                        ),
                                                        Text(
                                                          "Update",
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      // id = int.parse(snapshot
                                                      //     .data![index].id);
                                                      // print(id);
                                                      // if (id != null) {
                                                      //   Navigator.push(
                                                      //       context,
                                                      //       MaterialPageRoute(
                                                      //           builder: (context) =>
                                                      //               UpdateEmp(
                                                      //                   id: id)));
                                                      // }
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  height: 30,
                                                  width: 60,
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.red),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.delete_rounded,
                                                          color: Colors.white,
                                                          size: 10,
                                                        ),
                                                        Text(
                                                          "Delete",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      id = int.parse(snapshot
                                                          .data![index].id);
                                                      print(id);
                                                      if (id != null) {
                                                        setState(() {
                                                          DeleteEmp(id);
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      OrgAdmin(
                                                                OrgObj: obj,
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                            // Text(snapshot.data!.name);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<service>> fetchServices(String org) async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}/HhcApi/api/Login/ViewServices?org=${obj.name}'));
    if (response.statusCode == 200) {
      List paresd = jsonDecode(response.body);
      print("acc");
      return paresd.map((emp) => service.fromJson(emp)).toList();
      // return org.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
