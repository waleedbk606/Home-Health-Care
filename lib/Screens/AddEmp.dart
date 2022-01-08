import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hhc/Models/Organization.dart';
import 'package:hhc/Screens/Login.dart';
import 'package:hhc/Screens/OrgAdmin.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Urls.dart';

class AddEmp extends StatefulWidget {
  final String dep;
  final String org;
  final Organization obj;

  const AddEmp(
      {Key? key, required this.dep, required this.org, required this.obj})
      : super(key: key);

  @override
  _AddEmpState createState() => _AddEmpState();
}

class _AddEmpState extends State<AddEmp> {
  late Organization obj = widget.obj;
  TextEditingController FnameController = TextEditingController();
  TextEditingController LnameController = TextEditingController();
  TextEditingController AgeController = TextEditingController();
  TextEditingController CNICController = TextEditingController();
  TextEditingController GenderController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController QualificationController = TextEditingController();
  TextEditingController ExperienceController = TextEditingController();
  TextEditingController UsernameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController OrgNameController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void validate() {
    if (_formkey.currentState!.validate()) {
      print('ok');
    }
  }

  Object? _value = 'user';
  late bool error, sending, success;
  late String msg;

  String url = "http://${Url.ip}/HhcApi/api/Login/AddEmployee";

  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    super.initState();
  }

  Future<void> sendData() async {
    if (widget.org == "Independent") {
      var res = await http.post(
        Uri.parse(url),
        body: {
          'Oid': "8010",
          'Fname': FnameController.text,
          'Lname': LnameController.text,
          'Age': AgeController.text,
          'CNIC': CNICController.text,
          'Gender': GenderController.text,
          'Phone': PhoneController.text,
          'Email': EmailController.text,
          'Qualification': QualificationController.text,
          'Experience': ExperienceController.text,
          'Department': widget.dep,
          'OrgName': widget.org,
          'Username': UsernameController.text,
          'Password': PasswordController.text,
          'Status': "Pending",
        },
      );

      if (res.statusCode == 200) {
        print(res.body);
        var data = json.decode(res.body);
        if (data["error"]) {
          setState(() {
            sending = false;
            error = true;
            msg = data["message"];
          });
        }
      }
    } else {
      var res = await http.post(
        Uri.parse(url),
        body: {
          'Fname': FnameController.text,
          'Lname': LnameController.text,
          'Age': AgeController.text,
          'CNIC': CNICController.text,
          'Gender': GenderController.text,
          'Phone': PhoneController.text,
          'Email': EmailController.text,
          'Qualification': QualificationController.text,
          'Experience': ExperienceController.text,
          'Department': widget.dep,
          'OrgName': widget.org,
          'Username': UsernameController.text,
          'Password': PasswordController.text,
          'Status': "Accepted",
        },
      );

      if (res.statusCode == 200) {
        print(res.body);
        var data = json.decode(res.body);
        if (data["error"]) {
          setState(() {
            sending = false;
            error = true;
            msg = data["message"];
          });
        }
      }
    }
  }

  String urllog = "http://${Url.ip}/HhcApi/api/Login/AddLogin";

  Future<void> sendlogin() async {
    var res = await http.post(
      Uri.parse(urllog),
      body: {
        'Username': UsernameController.text,
        'Password': PasswordController.text,
        'Role': widget.dep,
      },
    );
    if (res.statusCode == 200) {
      print(res.body);
      var data = json.decode(res.body);
      print(data);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Add Employees")),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: FnameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: LnameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: AgeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: GenderController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Gender',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: CNICController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CNIC',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: PhoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone#',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: EmailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: QualificationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Qualification',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: ExperienceController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Experience',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: UsernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: PasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
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
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    sendData();
                    sendlogin();
                    //showAlertDialog(context);
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(
                          "Employee Added",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        content: Text("Please Refresh the list"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              "OK",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.teal,
                              ),
                            ),
                            onPressed: () {
                              if (widget.org == "Independent") {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                });
                              } else {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OrgAdmin(
                                                OrgObj: obj,
                                              )));
                                });
                              }
                            },
                          ),
                        ],
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
}
