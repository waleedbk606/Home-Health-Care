import 'package:flutter/material.dart';
import 'package:hhc/Models/Locations.dart';
import 'package:hhc/Screens/Login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Map.dart';
import '../Urls.dart';

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
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class AddOrg extends StatefulWidget {
  final List<Locations> OrgList;
  const AddOrg({Key? key, required this.OrgList}) : super(key: key);

  @override
  _AddOrgState createState() => _AddOrgState();
}

class _AddOrgState extends State<AddOrg> {
  TextEditingController NameController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
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

  late bool error, sending, success;
  late String msg;
  String url = "http://${Url.ip}/HhcApi/api/HhcAdmin/AddOrg";
  String LocationsUrl = "http://${Url.ip}/HhcApi/api/HhcAdmin/AddLocations";
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
        PhonenumController.text = '';
        EmailController.text = '';
        HOONameController.text = '';
        DiscriptionController.text = '';
        UsernameController.text = '';
        PasswordController.text = '';
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

  Future<void> SendLocationsData(Locations Obj) async {
    var Locations = await http.post(
      Uri.parse(LocationsUrl),
      body: {
        'OrgName': NameController.text,
        'Lat': Obj.lat,
        'Long': Obj.long,
        'Radius': Obj.radius,
      },
    );
    if (Locations.statusCode == 200) {
      print(Locations.body);
      var data = json.decode(Locations.body);
      if (data["error"]) {
        setState(() {
          sending = false;
          error = true;
          msg = data["message"];
        });
      } else {
        NameController.text = '';
        AddressController.text = '';
        PhonenumController.text = '';
        EmailController.text = '';
        HOONameController.text = '';
        DiscriptionController.text = '';
        UsernameController.text = '';
        PasswordController.text = '';
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

  String AddOrgLoginUrl = "http://${Url.ip}/HhcApi/api/Login/AddLogin";

  Future<void> sendlogin() async {
    var res = await http.post(
      Uri.parse(AddOrgLoginUrl),
      body: {
        'Username': UsernameController.text,
        'Password': PasswordController.text,
        'Role': "OrgAdmin",
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
                padding: EdgeInsets.all(8),
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 13,
                      ),
                      Text(
                        "Add pin location on map:",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        icon: new Icon(
                          Icons.location_on,
                          color: Colors.blue,
                          //size: 23,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Map(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
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
                    for (int i = 0; i < widget.OrgList.length; i++) {
                      SendLocationsData(widget.OrgList.elementAt(i));
                    }
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
