import 'package:flutter/material.dart';
import 'package:hhc/Models/Organization.dart';
import 'package:hhc/Screens/AddOrg.dart';
import 'AddEmp.dart';
import 'Login.dart';
import '../Urls.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  final Organization OrgObj;

  const Signup({Key? key, required this.OrgObj}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController FnameController = TextEditingController();
  TextEditingController LnameController = TextEditingController();
  TextEditingController DobController = TextEditingController();
  TextEditingController GenderController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PhonenumController = TextEditingController();
  TextEditingController UsernameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void validate() {
    if (_formkey.currentState!.validate()) {
      print('ok');
    }
  }

  Object? _value = 'user';
  late bool error, sending, success;
  late String msg;
  String selectedName = "User";
  List<String> locations = [
    "User",
    "Nurse",
    "Physio",
    "Vaccinator",
    "General Physician",
    "Organization",
  ];
  String OrgCheck = "";
  String urllog = "http://${Url.ip}/HhcApi/api/Login/AddLogin";
  String url = "http://${Url.ip}/HhcApi/api/Login/AddRegister";
  String urlemp = "http://${Url.ip}/HhcApi/api/Login/AddEmployee";

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
        'Username': UsernameController.text,
        'Password': PasswordController.text,
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
      } else {
        FnameController.text = '';
        LnameController.text = '';
        EmailController.text = '';
        UsernameController.text = '';
        PasswordController.text = '';
        _value = '';

        setState(() {
          sending = false;
          success = true;
        });
      }
    } else {
      setState(() {
        error = true;
        msg = "Error during sending data";
        sending = false;
      });
    }
  }

  Future<void> sendlogin() async {
    if (OrgCheck == "User") {
      var res = await http.post(
        Uri.parse(urllog),
        body: {
          'Username': UsernameController.text,
          'Password': PasswordController.text,
          'Role': "User",
        },
      );
      if (res.statusCode == 200) {
        print(res.body);
        var data = json.decode(res.body);
        if (data["error"]) {
          setState(
            () {
              sending = false;
              error = true;
              msg = data["message"];
            },
          );
        }
      }
    }
    if (OrgCheck == "Organization") {
      var res = await http.post(
        Uri.parse(urllog),
        body: {
          'Username': UsernameController.text,
          'Password': PasswordController.text,
          'Role': "OrgAdmin",
        },
      );
      if (res.statusCode == 200) {
        print(res.body);
        var data = json.decode(res.body);
        if (data["error"]) {
          setState(
            () {
              sending = false;
              error = true;
              msg = data["message"];
            },
          );
        }
      }
    } else {
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
        var data = json.decode(res.body);
        if (data["error"]) {
          setState(
            () {
              sending = false;
              error = true;
              msg = data["message"];
            },
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign UP'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    "Sign Up as:",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    child: DropdownButton(
                      autofocus: true,
                      focusColor: Colors.white,
                      isExpanded: true,
                      onChanged: (String? value) {
                        setState(
                          () {
                            this.selectedName = value!;
                            OrgCheck = selectedName;
                            print(OrgCheck);
                            if (OrgCheck == "Organization") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddOrg()));
                            }
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
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                          value: item,
                        );
                      }).toList(),
                      dropdownColor: Colors.white,
                    ),
                  ),
                ],
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
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (OrgCheck == "User") {
                      sendData();
                      sendlogin();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    } else if (OrgCheck == "Organization") {
                      print("Please reselect something from dropdown");
                    } else {
                      EmployeeSignUp();
                      sendlogin();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  },
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Text('Already have a account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Log in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> EmployeeSignUp() async {
    var res = await http.post(
      Uri.parse(urlemp),
      body: {
        'Oid': "8010",
        'Fname': FnameController.text,
        'Lname': LnameController.text,
        'Email': EmailController.text,
        'Department': OrgCheck.toString(),
        'OrgName': "Independent",
        'Username': UsernameController.text,
        'Password': PasswordController.text,
        'Status': "Details Required",
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
