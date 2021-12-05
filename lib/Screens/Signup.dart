import 'package:flutter/material.dart';
import 'Login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController FnameController = TextEditingController();
  TextEditingController LnameController = TextEditingController();
  TextEditingController AgeController = TextEditingController();
  TextEditingController CnicController = TextEditingController();
  TextEditingController DobController = TextEditingController();
  TextEditingController GenderController = TextEditingController();
  TextEditingController BloodGroupController = TextEditingController();
  TextEditingController PhonenumController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
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
  String urllog = "http://192.168.10.4/HhcApi/api/Login/AddLogin";
  String url = "http://192.168.10.4/HhcApi/api/Login/AddRegister";
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
        'Age': AgeController.text,
        'Cnic': CnicController.text,
        'Dob': DobController.text,
        'Gender': GenderController.text,
        'BloodGroup': BloodGroupController.text,
        'Phonenum': PhonenumController.text,
        'Email': EmailController.text,
        'Address': AddressController.text,
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
        AgeController.text = '';
        CnicController.text = '';
        DobController.text = '';
        GenderController.text = '';
        BloodGroupController.text = '';
        PhonenumController.text = '';
        EmailController.text = '';
        AddressController.text = '';
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
    var res = await http.post(
      Uri.parse(urllog),
      body: {
        'Username': UsernameController.text,
        'Password': PasswordController.text,
        'Role': "Patient",
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
      } else {
        UsernameController.text = '';
        PasswordController.text = '';
        _value = '';

        setState(() {
          sending = false;
          success = true;
        });
      }
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
        title: Text('Sign UP'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                  controller: CnicController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CNIC',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: DobController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date Of Birth',
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
                  controller: BloodGroupController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Blood Group',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: AddressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: PhonenumController,
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
                    sendData();
                    sendlogin();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
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
}
