import 'dart:convert';
import "package:flutter/material.dart";
import 'package:hhc/Models/Employee.dart';
import 'package:hhc/Models/Organization.dart';
import 'package:hhc/Screens/AddEmp.dart';
import 'package:hhc/Screens/AddOrg.dart';
import 'package:hhc/Screens/Employee.dart';
import '../Urls.dart';
import 'Home.dart';
import 'OrgAdmin.dart';
import 'Signup.dart';
import 'hhcAdmin.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<String> locations = [
    "Organization",
    "Nurse",
    "Physio",
    "Vaccinator",
    "General Physician",
  ];
  String selectedName = "Organization";
  String Department = '';
  late String username = usernameController.text;
  late String password = passwordController.text;
  late bool error, sending, success;
  late String msg;
  late String role;
  var OrgObj = null;
  var empobj = null;
  String url = "http://${Url.ip}/HhcApi/api/Login/verifylogin";

  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    super.initState();
    // fetchUserDetails(username, password);
  }

  Future<Organization> fetchUserDetails(
      String Username, String Password) async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}/HhcApi/api/Login/GetOrgDetails?Username=${Username}&Password=${Password}'));
    if (response.statusCode == 200) {
      Organization paresd = OrganizationFromJson(response.body);
      print(paresd.name);
      OrgObj = paresd;
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Employee> fetchEmpDetails(String Username, String Password) async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}/HhcApi/api/Login/GetEmpByUsername?Username=${Username}&Password=${Password}'));
    if (response.statusCode == 200) {
      Employee paresd = EmpFromJson(response.body);
      setState(() {
        empobj = paresd;
      });
      print(paresd.fname);
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> verifylogin() async {
    var res = await http.post(Uri.parse(url), body: {
      'UserName': usernameController.text,
      'Password': passwordController.text,
    });
    if (res.statusCode == 200) {
      print(res.body);
      var data = json.decode(res.body);
      //await FlutterSession().set('token', usernameController.text);
      role = data['Role'];
      print(role);
      if (role == 'User      ') {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  hhcHome(username: username, password: password),
            ),
          );
        });
      }
      if (data['Role'] == 'AppAdmin  ') {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => hhcAdmin(
                orgobj: OrgObj,
              ),
            ),
          );
        });
      }
      if (data['Role'] == 'OrgAdmin  ') {
        await fetchUserDetails(username, password);
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrgAdmin(OrgObj: OrgObj),
            ),
          );
        });
      }
      if (data['Role'] == 'Employee  ') {
        await fetchEmpDetails(username, password);
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeeHome(
                obj: empobj,
              ),
            ),
          );
        });
      }
    } else {
      print('faild To load ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 150.0,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'LOG IN',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w900,
                        fontSize: 50),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  height: 60,
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                      'Login',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    onPressed: () {
                      verifylogin();
                    },
                  )),
              Container(
                child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signup(
                                      OrgObj: OrgObj,
                                    )));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              Text(
                "OR",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Text('Sign UP as '),
                    // FlatButton(
                    //   textColor: Colors.blue,
                    //   child: Icon(
                    //     Icons.add_business_outlined,
                    //     size: 50,
                    //   ),
                    //   onPressed: () {
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (context) => AddOrg()));
                    //   },
                    // )
                    Container(
                      width: 150,
                      height: 50,
                      child: DropdownButton(
                        autofocus: true,
                        focusColor: Colors.white,
                        isExpanded: true,
                        hint: Text(
                          'Organization',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 10,
                            color: Colors.blue,
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            this.selectedName = value!;
                            Department = selectedName;
                            print(Department);
                            if (Department == 'Organization') {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddOrg()));
                              });
                            }
                            if (Department == 'Nurse') {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddEmp(
                                              dep: Department,
                                              org: "Independent",
                                              obj: OrgObj,
                                            )));
                              });
                            }
                            if (Department == 'Physio') {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddEmp(
                                              dep: Department,
                                              org: "Independent",
                                              obj: OrgObj,
                                            )));
                              });
                            }
                            if (Department == 'Vaccinator') {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddEmp(
                                              dep: Department,
                                              org: "Independent",
                                              obj: OrgObj,
                                            )));
                              });
                            }
                            if (Department == 'General Physician') {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddEmp(
                                              dep: Department,
                                              org: "Independent",
                                              obj: OrgObj,
                                            )));
                              });
                            }
                          });
                        },
                        value: selectedName,
                        items: locations.map((item) {
                          return DropdownMenuItem(
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                              ),
                            ),
                            value: item,
                          );
                        }).toList(),
                        dropdownColor: Colors.white,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
