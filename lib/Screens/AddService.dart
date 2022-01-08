import 'dart:convert';
import 'package:hhc/Models/Organization.dart';
import 'package:hhc/Screens/OrgAdmin.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Urls.dart';

class service {
  String id;
  String Name;
  String Discription;
  String Staff;
  String Charges;
  String Organization;
  service({
    required this.id,
    required this.Name,
    required this.Discription,
    required this.Staff,
    required this.Charges,
    required this.Organization,
  });

  factory service.fromJson(Map<String, dynamic> json) {
    return service(
      id: json['id'].toString(),
      Name: json['Name'],
      Discription: json['Discription'],
      Staff: json['Staff'],
      Charges: json['Charges'],
      Organization: json['Organization'],
    );
  }
}

class AddService extends StatefulWidget {
  final Organization obj;
  const AddService({Key? key, required this.obj}) : super(key: key);

  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  late Organization obj = widget.obj;
  TextEditingController NameController = TextEditingController();
  TextEditingController DiscriptionController = TextEditingController();
  TextEditingController StaffController = TextEditingController();
  TextEditingController ChargesController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  void validate() {
    if (_formkey.currentState!.validate()) {
      print('ok');
    }
  }

  late bool error, sending, success;
  late String msg;
  String url = "http://${Url.ip}/HhcApi/api/Login/AddService";
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
        'Discription': DiscriptionController.text,
        'Staff': StaffController.text,
        'Charges': ChargesController.text,
        'Organization': obj.name,
      },
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      print(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Srvice"),
      ),
      body: Padding(
        padding: EdgeInsets.all(08),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  controller: StaffController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Staff Required',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: ChargesController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Charges',
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
                    'Add Service',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    sendData();
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
            context,
            MaterialPageRoute(
                builder: (context) => OrgAdmin(
                      OrgObj: obj,
                    )));
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Service Added",
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
      content: Text("Please Check the List"),
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
}
