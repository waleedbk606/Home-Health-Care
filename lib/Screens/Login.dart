import 'dart:convert';
import "package:flutter/material.dart";
import 'package:hhc/Screens/AddOrg.dart';
import 'package:hhc/Screens/DocDashboard.dart';
import 'package:hhc/Screens/NurseDashbord.dart';
import 'Home.dart';
import 'OrgAdmin.dart';
import 'Signup.dart';
//import 'ViewNurse.dart';
import 'hhcAdmin.dart';
import 'package:http/http.dart' as http;
//import 'package:hhc/ViewDoctors.dart';
//import 'package:hhc/hhcAdmin.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  late String username, password;
  late bool error, sending, success;
  late String msg;
  late String role;
  String url = "http://192.168.10.4/HhcApi/api/Login/verifylogin";
  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    super.initState();
  }

  Future<void> verifylogin() async {
    var res = await http.post(Uri.parse(url), body: {
      'UserName': usernameController.text,
      'Password': passwordController.text,
      //'Role': roleController.text,
    });
    if (res.statusCode == 200) {
      print(res.body);
      var data = json.decode(res.body);
      role = data['Role'];
      print(role);
      if (data['Role'] == 'Patient   ') {
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => hhcHome()));
        });
      }
      if (data['Role'] == 'AppAdmin  ') {
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => hhcAdmin()));
        });
      }
      if (data['Role'] == 'OrgAdmin  ') {
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => OrgAdmin()));
        });
      }
      if (data['Role'] == 'Doctor    ') {
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DocDashboard()));
        });
      }
      if (data['Role'] == 'Nurse     ') {
        setState(() {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NurseDashboard()));
        });
      }
      if (data['Role'] == 'Physio    ') {
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => hhcAdmin()));
        });
      }
      if (data['Role'] == 'Vaccinator') {
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => hhcAdmin()));
        });
      }
      if (data['Role'] == 'Vaccinator') {
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => hhcAdmin()));
        });
      }
      if (data["error"]) {
        setState(() {
          sending = false;
          error = true;
          msg = data["message"];
        });
      } else {
        usernameController.text = '';
        passwordController.text = '';
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
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
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Text('Sign UP as Organization'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Icon(
                        Icons.add_business_outlined,
                        size: 50,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AddOrg()));
                      },
                    )
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
