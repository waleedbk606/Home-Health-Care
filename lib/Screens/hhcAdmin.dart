import 'package:flutter/material.dart';
import 'package:hhc/Screens/OrgRequest.dart';
import 'dart:async';
import 'dart:convert';
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

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
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

class hhcAdmin extends StatefulWidget {
  const hhcAdmin({Key? key}) : super(key: key);

  @override
  _hhcAdminState createState() => _hhcAdminState();
}

class _hhcAdminState extends State<hhcAdmin> {
  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    if (search == "empty") return [];
    if (search == "error") throw Error();
    return List.generate(search.length, (int index) {
      return Post(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }

  Future<List<org>> fetchorg() async {
    final response = await http
        .get(Uri.parse('http://192.168.10.4/HhcApi/api/Login/acceptedorg'));
    if (response.statusCode == 200) {
      List paresd = jsonDecode(response.body);

      return paresd.map((emp) => org.fromJson(emp)).toList();
      // return org.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<org>> futureorg;

  @override
  void initState() {
    super.initState();
    futureorg = fetchorg();
  }

  var selectiteam;
  Color colorCard = Colors.white;
  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.0,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'HHC Admin',
                  style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w900,
                      fontSize: 50),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 140,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'View Requests',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrgRequest()));
                      },
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    height: 60,
                    width: 150,
                    padding: EdgeInsets.all(10),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Delete',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onPressed: () {
                        Deletorg(selectiteam);
                        //showAlertDialog(context);
                      },
                    ),
                  ),
                ],
              ),
              Container(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search by Name or City",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none),
                    fillColor: Color(0xffe6e6ec),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
              FutureBuilder<List<org>>(
                future: futureorg,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              GestureDetector(
                                onLongPress: () {
                                  setState(() {});
                                },
                                onTap: () {
                                  setState(() {
                                    selectiteam = snapshot.data![index];
                                    _onSelected(index);
                                    print(snapshot.data![index].name);
                                  });
                                },
                                child: Card(
                                  color: (_selectedIndex != null &&
                                          _selectedIndex == index)
                                      ? Colors.red[300]
                                      : Colors.white,
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
                                            color: Colors.lightBlueAccent,
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
                                              width: 85,
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
        ),
      ),
    );
  }
}
