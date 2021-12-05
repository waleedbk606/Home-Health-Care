import 'package:flutter/material.dart';
import 'package:hhc/Screens/Login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text(
      "OK",
      style: TextStyle(
        fontSize: 25,
        color: Colors.teal,
      ),
    ),
    onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Request Send",
      style: TextStyle(
        color: Colors.blue,
      ),
    ),
    content: Text("Please wait for the admin response"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class AddOrg extends StatefulWidget {
  const AddOrg({Key? key}) : super(key: key);

  @override
  _AddOrgState createState() => _AddOrgState();
}

class _AddOrgState extends State<AddOrg> {
  TextEditingController NameController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  TextEditingController CityController = TextEditingController();
  TextEditingController PhonenumController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController HOONameController = TextEditingController();
  TextEditingController DiscriptionController = TextEditingController();
  TextEditingController UsernameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController StatusController = TextEditingController();
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
  String url = "http://192.168.10.4/HhcApi/api/Login/AddOrg";
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
        'Name': NameController.text,
        'Address': AddressController.text,
        'City': CityController.text,
        'Phonenum': PhonenumController.text,
        'Email': EmailController.text,
        'HooName': HOONameController.text,
        'Discription': DiscriptionController.text,
        'Username': UsernameController.text,
        'Password': PasswordController.text,
        'Status': 'Pending',
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
        NameController.text = '';
        AddressController.text = '';
        CityController.text = '';
        PhonenumController.text = '';
        EmailController.text = '';
        HOONameController.text = '';
        DiscriptionController.text = '';
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
        'Role': "OrgAdmin  ",
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
        title: Text('Sign UP as Organization'),
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
                  controller: NameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
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
                  controller: CityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'City',
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
                  controller: HOONameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Head of Organization Name ',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: DiscriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Discription',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: UsernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'UserName ',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: PasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password ',
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
                    'Send Request',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    sendData();
                    sendlogin();
                    showAlertDialog(context);
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
