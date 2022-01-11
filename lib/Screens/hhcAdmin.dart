import 'package:flutter/material.dart';
import 'package:hhc/Models/Employee.dart';
import 'package:hhc/Models/Organization.dart';
import 'package:hhc/Screens/OrgRequest.dart';
import 'package:hhc/Screens/UpdateEmp.dart';
import 'package:hhc/Urls.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

class hhcAdmin extends StatefulWidget {
  final Organization orgobj;
  const hhcAdmin({Key? key, required this.orgobj}) : super(key: key);

  @override
  _hhcAdminState createState() => _hhcAdminState();
}

class _hhcAdminState extends State<hhcAdmin> {
  late Organization orgobj = widget.orgobj;
  List<String> locations = [
    "Nurse",
    "Physio",
    "Vaccinator",
    "General Physician",
  ];
  String selectedName = "Nurse";
  String Department = '';
  int eid = 0;
  // Future<List<Post>> search(String search) async {
  //   await Future.delayed(Duration(seconds: 2));
  //   if (search == "empty") return [];
  //   if (search == "error") throw Error();
  //   return List.generate(search.length, (int index) {
  //     return Post(
  //       "Title : $search $index",
  //       "Description :$search $index",
  //     );
  //   });
  // }

  Future<Organization> DeleteEmp(int id) async {
    final response = await http.delete(
        Uri.parse('http://${Url.ip}/HhcApi/api/Login/DeleteService?id=${id}'));
    if (response.statusCode == 200) {
      Organization data = organizationFromJson(response.body) as Organization;
      return data;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Organization>> fetchorg() async {
    final response = await http
        .get(Uri.parse('http://${Url.ip}/HhcApi/api/Login/acceptedorg'));
    if (response.statusCode == 200) {
      List<Organization> paresd = organizationFromJson(response.body);
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Organization> Deletorg(int id) async {
    final response = await http
        .delete(Uri.parse('http://${Url.ip}/HhcApi/api/Login/DeleteOrg/${id}'));
    if (response.statusCode == 200) {
      Organization paresd = organizationFromJson(response.body) as Organization;
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Employee>> fetchEmpDep(String department) async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}/HhcApi/api/Login/IndEmphhc?Dep=${department}'));
    if (response.statusCode == 200) {
      List<Employee> paresd = employeeFromJson(response.body);
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<Organization>> futureorg;

  @override
  void initState() {
    super.initState();
    futureorg = fetchorg();
  }

  int selectiteam = 0;
  Color colorCard = Colors.white;
  int _selectedIndex = 0;
  var set;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("         HHC Admin")),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.person_add_alt_outlined,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrgRequest()));
                },
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.badge),
                  text: 'Employees',
                ),
                Tab(
                  icon: Icon(
                    Icons.add_business_outlined,
                    size: 30,
                  ),
                  text: 'Organizations',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(children: [
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
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<List<Employee>>(
                        future: fetchEmpDep(Department),
                        key: UniqueKey(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onLongPress: () {},
                                  onTap: () {
                                    setState(() {
                                      selectiteam = snapshot.data![index].eid;
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
                                                width: 270,
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
                                                          "Phone:  ",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          snapshot.data![index]
                                                              .phone,
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
                                                    //               obj: orgobj,
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
                                                            setState(() {
                                                              DeleteEmp(eid);
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          hhcAdmin(
                                                                            orgobj:
                                                                                orgobj,
                                                                          )));
                                                            });
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
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

              //Organizatons  Starts

              Padding(
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Container(
                      //   height: 50,
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //       prefixIcon: Icon(Icons.search),
                      //       hintText: "Search by Name or City",
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(15.0),
                      //           borderSide: BorderSide.none),
                      //       fillColor: Color(0xffe6e6ec),
                      //       filled: true,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Row(
                        children: [
                          Icon(
                            Icons.list_alt_outlined,
                            size: 35,
                            color: Colors.lightBlueAccent,
                          ),
                          Text(
                            'Organizations List',
                            style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.w500,
                              fontSize: 33,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          FutureBuilder<List<Organization>>(
                            future: futureorg,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          GestureDetector(
                                            onLongPress: () {
                                              setState(() {});
                                            },
                                            onTap: () {
                                              setState(() {
                                                selectiteam = int.parse(snapshot
                                                    .data![index].id
                                                    .toString());
                                                _onSelected(index);
                                                print(
                                                    snapshot.data![index].name);
                                                print(selectiteam);
                                              });
                                            },
                                            child: Card(
                                              color: (_selectedIndex != null &&
                                                      _selectedIndex == index)
                                                  ? Colors.blue[50]
                                                  : Colors.white,
                                              child: Container(
                                                height: 80,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data![index].name,
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      snapshot
                                                          .data![index].address,
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        //fontWeight: FontWeight.w500,
                                                        //color: Colors.teal,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 85,
                                                        ),
                                                        Text(
                                                          snapshot.data![index]
                                                              .phonenum,
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          " | ",
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          ),
                                                        ),
                                                        Text(
                                                          snapshot.data![index]
                                                              .city,
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
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

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text(
        "Yes",
        style: TextStyle(
          fontSize: 25,
          color: Colors.teal,
        ),
      ),
      onPressed: () {},
    );

    Widget noButton = TextButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => hhcAdmin(
                      orgobj: orgobj,
                    )));
      },
      child: Text(
        "No",
        style: TextStyle(
          fontSize: 25,
          color: Colors.black,
        ),
      ),
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Delete Request",
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
      content: Text("Are you sure to delete this Organization!"),
      actions: [
        okButton,
        noButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
