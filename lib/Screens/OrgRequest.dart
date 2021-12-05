import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class OrgRequest extends StatefulWidget {
  const OrgRequest({Key? key}) : super(key: key);

  @override
  _OrgRequestState createState() => _OrgRequestState();
}

class _OrgRequestState extends State<OrgRequest> {
  Future<List<org>> fetchorg() async {
    final response = await http
        .get(Uri.parse('http://192.168.10.4/HhcApi/api/Login/GetOrg'));
    if (response.statusCode == 200) {
      List paresd = jsonDecode(response.body);

      return paresd.map((emp) => org.fromJson(emp)).toList();
      // return org.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<org> Deletorg(int id) async {
    final response = await http.delete(
        Uri.parse('http://192.168.43.37/HhcApi/api/Login/DeleteOrg/${id}'));
    if (response.statusCode == 200) {
      return org.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<org> UpdateOrg(int id) async {
    final response = await http.patch(
        Uri.parse('http://192.168.10.4/HhcApi/api/Login/UpdateStatus/${id}'));
    if (response.statusCode == 200) {
      return org.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
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

  late Future<List<org>> futureorg;
  @override
  void initState() {
    super.initState();
    futureorg = fetchorg();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Panel'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder<List<org>>(
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
                          key: Key(snapshot.data![index].id),
                          background: slideRightBackground(),
                          secondaryBackground: slideLeftBackground(),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              final bool res = await showDialog(
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
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrgRequest()));
                                        },
                                      ),
                                      FlatButton(
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          Deletorg(
                                            int.parse(snapshot.data![index].id),
                                          );
                                          setState(
                                            () {
                                              snapshot.data!.removeAt(index);
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
                              if (direction == DismissDirection.startToEnd) {
                                final bool res = await showDialog(
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
                                              int.parse(
                                                  snapshot.data![index].id),
                                            );
                                            setState(
                                              () {
                                                snapshot.data!.removeAt(index);
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
                                    Text(
                                      snapshot.data![index].address,
                                      textAlign: TextAlign.right,
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
                                          width: 75,
                                        ),
                                        Text(
                                          snapshot.data![index].phone,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          " | ",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data![index].city,
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
    );
  }
}