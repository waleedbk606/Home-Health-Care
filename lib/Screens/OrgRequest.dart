import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hhc/Models/Organization.dart';
import 'package:http/http.dart' as http;

import '../Urls.dart';

class org {
  String id;
  String name;
  String address;
  String city;
  String phone;
  String email;
  String hoo;
  String discription;
  String username;
  String password;
  String status;

  org({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.phone,
    required this.email,
    required this.hoo,
    required this.discription,
    required this.username,
    required this.password,
    required this.status,
  });

  factory org.fromJson(Map<String, dynamic> json) {
    return org(
      id: json['id'].toString(),
      name: json['Name'],
      address: json['Address'],
      city: json['City'],
      phone: json['Phonenum'],
      email: json['Email'],
      hoo: json['HooName'],
      discription: json['Discription'],
      username: json['Username'],
      password: json['Password'],
      status: json['Status'],
    );
  }
}

class empl {
  String eid;
  String Fname;
  String Lname;
  String Age;
  String CNIC;
  String Gender;
  String Phone;
  String Email;
  String Qualification;
  String Experience;
  String Department;
  String Username;
  String Password;

  empl({
    required this.eid,
    required this.Fname,
    required this.Lname,
    required this.Age,
    required this.CNIC,
    required this.Gender,
    required this.Phone,
    required this.Email,
    required this.Qualification,
    required this.Experience,
    required this.Department,
    required this.Username,
    required this.Password,
  });

  factory empl.fromJson(Map<String, dynamic> json) {
    return empl(
      eid: json['eid'].toString(),
      Fname: json['Fname'],
      Lname: json['Lname'],
      Age: json['Age'],
      CNIC: json['CNIC'],
      Gender: json['Gender'],
      Phone: json['Phone'],
      Email: json['Email'],
      Qualification: json['Qualification'],
      Experience: json['Experience'],
      Department: json['Department'],
      Username: json['Username'],
      Password: json['Password'],
    );
  }
}

class OrgRequest extends StatefulWidget {
  const OrgRequest({Key? key}) : super(key: key);

  @override
  _OrgRequestState createState() => _OrgRequestState();
}

class _OrgRequestState extends State<OrgRequest> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void validate() {
    if (_formkey.currentState!.validate()) {
      print('ok');
    }
  }

  Object? _value = 'user';
  late bool error, sending, success;
  late String msg;
  String urllog = "http://${Url.ip}/HhcApi/api/Login/AddLogin";

  Future<List<Organization>> fetchorg() async {
    final response = await http
        .get(Uri.parse('http://${Url.ip}/HhcApi/api/HhcAdmin/GetOrg'));
    if (response.statusCode == 200) {
      List<Organization> paresd = organizationFromJson(response.body);
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<org> Deletorg(int id) async {
    final response = await http.delete(
        Uri.parse('http://${Url.ip}/HhcApi/api/HhcAdmin/DeleteOrg/${id}'));
    if (response.statusCode == 200) {
      return org.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<org> UpdateOrg(int id) async {
    final response = await http.patch(Uri.parse(
        'http://${Url.ip}/HhcApi/api/HhcAdmin/UpdateOrgStatus/${id}'));
    if (response.statusCode == 200) {
      return org.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<empl>> fetchEmp() async {
    final response = await http.get(
        Uri.parse('http://${Url.ip}/HhcApi/api/HhcAdmin/GetIndPendingEmp'));
    if (response.statusCode == 200) {
      List paresd = jsonDecode(response.body);

      return paresd.map((emp) => empl.fromJson(emp)).toList();
      // return org.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<empl> DeleteEmp(int id) async {
    final response = await http.delete(Uri.parse(
        'http://${Url.ip}/HhcApi/api/HhcAdmin/DeletePendingEmpl?id=${id}'));
    if (response.statusCode == 200) {
      return empl.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<empl> UpdateEmp(int id) async {
    final response = await http.patch(Uri.parse(
        'http://${Url.ip}/HhcApi/api/HhcAdmin/UpdateEpmlStatus?id=${id}'));
    if (response.statusCode == 200) {
      return empl.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> sendlogin(String username, String password) async {
    var res = await http.post(
      Uri.parse(urllog),
      body: {
        'Username': username,
        'Password': password,
        'Role': "OrgAdmin  ",
      },
    );
    if (res.statusCode == 200) {
      print(res.body);
    } else {
      setState(
        () {
          error = true;
          msg = "Error during sending data";
          sending = false;
        },
      );
    }
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.check_outlined,
              color: Colors.white,
            ),
            Text(
              " Accept",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  late Future<List<Organization>> futureorg;

  late Future<List<empl>> futureEmp;

  @override
  void initState() {
    super.initState();
    futureorg = fetchorg();
    futureEmp = fetchEmp();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("Request panel")),
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
          body: TabBarView(children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: FutureBuilder<List<empl>>(
                future: futureEmp,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Dismissible(
                                key: Key(snapshot.data![index].eid),
                                background: slideRightBackground(),
                                secondaryBackground: slideLeftBackground(),
                                confirmDismiss: (direction) async {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    final bool res = await showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text(
                                            "Are you sure you want to delete?",
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              OrgRequest()));
                                                });
                                              },
                                            ),
                                            FlatButton(
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                DeleteEmp(
                                                  int.parse(snapshot
                                                      .data![index].eid),
                                                );
                                                setState(
                                                  () {
                                                    snapshot.data!
                                                        .removeAt(index);
                                                  },
                                                );
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    return res;
                                  } else {
                                    if (direction ==
                                        DismissDirection.startToEnd) {
                                      final bool res = await showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Text(
                                              "${snapshot.data![index].Fname}  Added as an Independent Staff",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text(
                                                  "OK",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () {
                                                  UpdateEmp(
                                                    int.parse(snapshot
                                                        .data![index].eid),
                                                  );
                                                  sendlogin(
                                                    snapshot
                                                        .data![index].Username,
                                                    snapshot
                                                        .data![index].Password,
                                                  );

                                                  setState(
                                                    () {
                                                      snapshot.data!
                                                          .removeAt(index);
                                                    },
                                                  );
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      return res;
                                    }
                                    // TODO: Navigate to edit page;
                                  }
                                },
                                child: InkWell(
                                  onTap: () {},
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 380,
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
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data![index].Fname,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        Colors.lightBlueAccent,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  snapshot.data![index].Lname,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        Colors.lightBlueAccent,
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
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data![index].Gender,
                                                  textAlign: TextAlign.right,
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
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data![index]
                                                      .Qualification,
                                                  textAlign: TextAlign.right,
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
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data![index].Phone,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    fontSize: 15,
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
                                                  "Department: ",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot
                                                      .data![index].Department,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
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
            ),

            //Organization starts

            Padding(
              padding: EdgeInsets.all(8),
              child: FutureBuilder<List<Organization>>(
                future: futureorg,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Dismissible(
                                key: Key(snapshot.data![index].id.toString()),
                                background: slideRightBackground(),
                                secondaryBackground: slideLeftBackground(),
                                confirmDismiss: (direction) async {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    final bool res = await showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text(
                                            "Are you sure you want to delete?",
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              OrgRequest()));
                                                });
                                              },
                                            ),
                                            FlatButton(
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                Deletorg(
                                                  int.parse(snapshot
                                                      .data![index].id
                                                      .toString()),
                                                );
                                                setState(
                                                  () {
                                                    snapshot.data!
                                                        .removeAt(index);
                                                  },
                                                );
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    return res;
                                  } else {
                                    if (direction ==
                                        DismissDirection.startToEnd) {
                                      final bool res = await showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Text(
                                              "${snapshot.data![index].name}  Added as an Organization",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text(
                                                  "OK",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () {
                                                  UpdateOrg(
                                                    int.parse(snapshot
                                                        .data![index].id
                                                        .toString()),
                                                  );
                                                  sendlogin(
                                                    snapshot
                                                        .data![index].username,
                                                    snapshot
                                                        .data![index].password,
                                                  );

                                                  setState(
                                                    () {
                                                      snapshot.data!
                                                          .removeAt(index);
                                                    },
                                                  );
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      return res;
                                    }
                                    // TODO: Navigate to edit page;
                                  }
                                },
                                child: InkWell(
                                  onTap: () {},
                                  child: Card(
                                    child: Container(
                                      height: 80,
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot.data![index].name,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.teal,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          // Text(
                                          //   snapshot.data![index].address,
                                          //   textAlign: TextAlign.right,
                                          //   style: TextStyle(
                                          //     fontSize: 15,
                                          //     //fontWeight: FontWeight.w500,
                                          //     //color: Colors.teal,
                                          //   ),
                                          // ),
                                          // SizedBox(
                                          //   height: 5,
                                          // ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 50,
                                              ),
                                              Text(
                                                snapshot
                                                    .data![index].discription,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 100,
                                              ),
                                              Text(
                                                snapshot.data![index].hooName,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("|"),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                snapshot.data![index].phonenum,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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
            ),
          ]),
        ),
      ),
    );
  }
}
