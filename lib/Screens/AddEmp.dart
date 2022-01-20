import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hhc/Models/Employee.dart';
import 'package:hhc/Models/Organization.dart';
import 'package:hhc/Screens/Login.dart';
import 'package:hhc/Screens/OrgAdmin.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Urls.dart';

class AddEmp extends StatefulWidget {
  final Organization obj;

  const AddEmp({Key? key, required this.obj}) : super(key: key);

  @override
  _AddEmpState createState() => _AddEmpState();
}

class _AddEmpState extends State<AddEmp> {
  late Organization obj = widget.obj;
  List<String> locations = [
    "Nurse",
    "Physio",
    "Vaccinator",
    "General Physician",
  ];
  String selectedName = "Nurse";
  TextEditingController FnameController = TextEditingController();
  TextEditingController LnameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
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
  Employee edata = null as Employee;

  String url = "http://${Url.ip}/HhcApi/api/Login/AddEmployee";

  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    super.initState();
  }

  Future<void> sendData() async {
    var res = await http.post(
      Uri.parse(url),
      body: {
        'Fname': FnameController.text,
        'Lname': LnameController.text,
        'Email': EmailController.text,
        'Department': selectedName,
        'OrgName': obj.name,
        'Username': UsernameController.text,
        'Password': PasswordController.text,
        'Status': "Details Required"
      },
    );

    if (res.statusCode == 200) {
      print(res.body);
      // var data = json.decode(res.body);
      // if (data["error"]) {
      //   setState(() {
      //     sending = false;
      //     error = true;
      //     msg = data["message"];
      //   });
      // }
    }
  }

  String urllog = "http://${Url.ip}/HhcApi/api/Login/AddLogin";

  Future<void> sendlogin() async {
    var res = await http.post(
      Uri.parse(urllog),
      body: {
        'Username': UsernameController.text,
        'Password': PasswordController.text,
        'Role': "Employee",
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

  // Future<Employee> fetchorg() async {
  //   final response = await http.get(Uri.parse(
  //       'http://${Url.ip}/HhcApi/api/Login/GetEmpByUsername?Username=${UsernameController.text}&Password=${PasswordController.text}'));
  //   if (response.statusCode == 200) {
  //     Employee paresd = EmployeeFromJson(response.body);
  //     edata = paresd;
  //     return paresd;
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }
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
                        print(selectedName);
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
                    // sendSchedule(edata);
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
                              setState(
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrgAdmin(
                                        OrgObj: obj,
                                      ),
                                    ),
                                  );
                                },
                              );
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
