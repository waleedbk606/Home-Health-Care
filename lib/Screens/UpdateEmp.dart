import 'package:flutter/material.dart';
import 'package:hhc/Models/Employee.dart';
import 'package:hhc/Models/Organization.dart';
import 'package:hhc/Screens/Employee.dart';
import 'package:hhc/Screens/OrgAdmin.dart';
import 'package:hhc/Urls.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

showAlertDialog(BuildContext context) {
  Widget okButton = FlatButton(
    child: Text(
      "OK",
      style: TextStyle(
        fontSize: 25,
        color: Colors.teal,
      ),
    ),
    onPressed: () {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => OrgAdmin()));
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Employee Updated",
      style: TextStyle(
        color: Colors.blue,
      ),
    ),
    content: Text("Refresh the list"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    //barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class org {
  String eid;
  String Fname;
  String Lname;
  String Age;
  String CNIC;
  String Gender;
  String Phone;
  String Email;
  String Qualification;
  String Experience;
  String Username;
  String Password;
  String OrgName;
  String Department;
  String Status;
  org({
    required this.eid,
    required this.Fname,
    required this.Lname,
    required this.Age,
    required this.CNIC,
    required this.Gender,
    required this.Phone,
    required this.Email,
    required this.Qualification,
    required this.Experience,
    required this.Username,
    required this.Password,
    required this.OrgName,
    required this.Department,
    required this.Status,
  });
  factory org.fromJson(Map<String, dynamic> json) {
    return org(
      eid: json['eid'].toString(),
      Fname: json['Fname'],
      Lname: json['Lname'],
      Age: json['Age'],
      CNIC: json['CNIC'],
      Gender: json['Gender'],
      Phone: json['Phone'],
      Email: json['Email'],
      Qualification: json['Qualification'],
      Experience: json['Experience'],
      Username: json['Username'],
      Password: json['Password'],
      OrgName: json['OrgName'],
      Department: json['Department'],
      Status: json['Status'],
    );
  }
}

class UpdateEmp extends StatefulWidget {
  final Employee obj;
  const UpdateEmp({Key? key, required this.obj}) : super(key: key);

  @override
  _UpdateEmpState createState() => _UpdateEmpState();
}

class _UpdateEmpState extends State<UpdateEmp> {
  late Employee obj = widget.obj;
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

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  void validate() {
    if (_formkey.currentState!.validate()) {
      print('ok');
    }
  }

  Object? _value = 'user';
  late bool error, sending, success;
  late String msg;
  late Future<List<Employee>> futureorg;
  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    super.initState();
    futureorg = fetchorg(obj.eid);
  }

  Future<List<Employee>> fetchorg(int id) async {
    final response = await http
        .get(Uri.parse('http://${Url.ip}/HhcApi/api/Login/GetEmp?id=${id}'));
    if (response.statusCode == 200) {
      List<Employee> paresd = employeeFromJson(response.body);
      print(response.body);
      return paresd;
    } else {
      print(response.body);
      throw Exception('Failed to load album');
    }
  }

  Future<void> sendData() async {
    var res = await http.post(
      Uri.parse(('http://${Url.ip}/HhcApi/api/Login/ModifyEmployee')),
      body: {
        'eid': obj.eid,
        'Fname': FnameController.text,
        'Lname': LnameController.text,
        'Age': AgeController.text,
        'CNIC': CNICController.text,
        'Gender': GenderController.text,
        'Phone': PhoneController.text,
        'Email': EmailController.text,
        'Qualification': QualificationController.text,
        'Experience': ExperienceController.text,
        'Username': UsernameController.text,
        'Password': PasswordController.text,
        'OrgName': obj.orgName,
        'Department': obj.department,
        'Status': obj.status,
      },
    );
    if (res.statusCode == 200) {
      print(res.body);
      var data = json.decode(res.body);
      print(data);
      // if (data["error"]) {
      //   setState(() {
      //     sending = false;
      //     error = true;
      //     msg = data["message"];
      //   });
      // } else {
      //   FnameController.text = '';
      //   LnameController.text = '';
      //   AgeController.text = '';
      //   CNICController.text = '';
      //   GenderController.text = '';
      //   PhoneController.text = '';
      //   EmailController.text = '';
      //   QualificationController.text = '';
      //   ExperienceController.text = '';
      //   UsernameController.text = '';
      //   PasswordController.text = '';
      //   _value = '';
      //
      //   setState(() {
      //     sending = false;
      //     success = true;
      //   });
      // }
    } else {
      setState(() {
        error = true;
        msg = "Error during sending data";
        sending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Employee"),
      ),
      body: FutureBuilder<List<Employee>>(
        future: futureorg,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  FnameController.text = snapshot.data![index].fname.toString();
                  LnameController.text = snapshot.data![index].lname.toString();
                  AgeController.text = snapshot.data![index].age.toString();
                  CNICController.text = snapshot.data![index].cnic.toString();
                  GenderController.text =
                      snapshot.data![index].gender.toString();
                  PhoneController.text = snapshot.data![index].phone.toString();
                  EmailController.text = snapshot.data![index].email.toString();
                  QualificationController.text =
                      snapshot.data![index].qualification.toString();
                  ExperienceController.text =
                      snapshot.data![index].experience.toString();
                  UsernameController.text =
                      snapshot.data![index].username.toString();
                  PasswordController.text =
                      snapshot.data![index].password.toString();
                  return Padding(
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
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                'Update',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                sendData();
                                setState(
                                  () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EmployeeHome(
                                          obj: obj,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
