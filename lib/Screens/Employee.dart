import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hhc/Models/Appointment.dart';
import 'package:hhc/Models/Employee.dart';
import 'package:hhc/Models/Schedule.dart';
import 'package:hhc/Screens/Leave.dart';
import 'package:hhc/Screens/UpdateEmp.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
import '../Urls.dart';

class EmployeeHome extends StatefulWidget {
  final Employee obj;

  const EmployeeHome({Key? key, required this.obj}) : super(key: key);

  @override
  _EmployeeHomeState createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends State<EmployeeHome> {
  // Future<Employee> fetchUserDetails(String Username, String Password) async {
  //   final response = await http.get(Uri.parse(
  //       'http://${Url.ip}/HhcApi/api/Login/GetEmpByUsername?Username=${Username}&Password=${Password}'));
  //   if (response.statusCode == 200) {
  //     Employee paresd = EmpFromJson(response.body);
  //     obj = paresd;
  //     print(paresd.fname);
  //     return paresd;
  //   } else {`
  //     throw Exception('Failed to load album');
  //   }
  // }
  var LeaveObj;
  Future<Schedule> SchduleObj() async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}/HhcApi/api/Login/GetScheduleObj?eid=${widget.obj.eid}'));
    if (response.statusCode == 200) {
      Schedule paresd = schedulefromJson(response.body);
      LeaveObj = paresd;
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> CompleteAppointment(int aid) async {
    final response = await http.patch(Uri.parse(
        'http://${Url.ip}/HhcApi/api/Login/CompleteAppointment?id=${aid}'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> UpdateSchPendApp(int eid) async {
    final response = await http.patch(Uri.parse(
        'http://${Url.ip}/HhcApi/api/Login/UpdatePendAppSubtract?eid=${eid}'));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> DeletSchedule(int eid, String data, String time) async {
    final response = await http.delete(Uri.parse(
        'http://${Url.ip}/HhcApi/api/Login/DeleteSchedule?eid=${eid}&date=${data}&time=${time}'));
    if (response.statusCode == 200) {
      print("Delete done");
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Appointment>> GetPendingAppointments() async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}/HhcApi/api/Login/GetEmpAppointments?eid=${widget.obj.eid}'));
    if (response.statusCode == 200) {
      List<Appointment> paresd = appointmentFromJson(response.body);
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  TextEditingController detailsController = TextEditingController();
  DateTime date = DateTime.now();
  String SelectedDate = '';
  late Future<List<Appointment>> getApp;
  @override
  void initState() {
    super.initState();
    getApp = GetPendingAppointments();
    SchduleObj();
    date = DateTime.now();
  }

  late Employee emp = widget.obj;
  // void logoutUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.clear();
  //   Navigator.of(context)
  //       .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  // }

  Future<String> CheckAvailablity(String a) async {
    String b = a;
    return b;
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Confirm"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(
        child: Text(
          "Apply For Leave",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
      content: Container(
        height: 130,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 30,
                  width: 100,
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _selectDate(context);
                        SelectedDate = date.day.toString() +
                            '-' +
                            date.month.toString() +
                            '-' +
                            date.year.toString();
                        //CheckAvailablity(SelectedDate);
                      });
                    },
                    color: Colors.blue,
                    child: Row(
                      children: [
                        Text(
                          'Select Date',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                          size: 13,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 100,
                  key: UniqueKey(),
                  child: Center(
                    child: FutureBuilder(
                      future: CheckAvailablity(SelectedDate),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data.toString(),
                            style: TextStyle(fontSize: 15),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: detailsController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Details',
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
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

  // Future<void> GivenDate() async {
  //   var res = await http.post(
  //     Uri.parse("http://${Url.ip}/HhcApi/api/Login/AddEmpSchedule"),
  //     body: {
  //       "eid": ScheduleObj.eid.toString(),
  //       "fname": ScheduleObj.fname,
  //       "lname": ScheduleObj.lname,
  //       "orgname": ScheduleObj.orgname,
  //       "dep": ScheduleObj.dep,
  //       "shift": ScheduleObj.shift,
  //       "noOfpndApnt": ScheduleObj.noOfpndApnt.toString(),
  //       "ratings": ScheduleObj.ratings.toString(),
  //       "date": SelectedDate,
  //       "timeslot": sO,
  //       "NoLeave": ScheduleObj.noLeave.toString(),
  //     },
  //   );
  //   if (res.statusCode == 200) {
  //     print("Given data ADD");
  //     UpdateOrg(ScheduleObj.eid);
  //   }
  // }

  Future<Null> _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: date,
      // Current Date
      firstDate: DateTime(2010),
      // First Date
      lastDate: DateTime(2050),
      // Last Date
      textDirection: TextDirection.ltr,
      // Header Text or Button Direction ltr or rtl
      initialDatePickerMode: DatePickerMode.day, // Day or Year Mode
      //   selectableDayPredicate: (DateTime val) =>
      //       val.weekday == 6 || val.weekday == 7 ? false : true, // WeekDay Off
      // selectableDayPredicate: (DateTime val) =>
      //     val.isBefore(val) ? false : true,
    );

    if (_datePicker != null && _datePicker != date) {
      setState(() {
        date = _datePicker;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(emp.fname + " " + emp.lname)),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 150,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: emp.status == "Details Required"
                        ? TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                            child: Text(
                              'ADD Details',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateEmp(obj: emp)),
                              );
                            },
                          )
                        : TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                            child: Text(
                              'Apply For Leave',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Leave(obj: widget.obj, Sobj: LeaveObj),
                                ),
                              );
                            },
                          ),
                  ),

                  // SizedBox(
                  //   width: 100,
                  // ),
                  // Container(
                  //   height: 40,
                  //   width: 150,
                  //   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  //   child: TextButton(
                  //     style: ButtonStyle(
                  //       backgroundColor:
                  //           MaterialStateProperty.all<Color>(Colors.blue),
                  //       shape:
                  //           MaterialStateProperty.all<RoundedRectangleBorder>(
                  //         RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(30.0),
                  //         ),
                  //       ),
                  //     ),
                  //     child: Text(
                  //       'ADD Details',
                  //       style: TextStyle(fontSize: 15, color: Colors.white),
                  //     ),
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => UpdateEmp(obj: emp)),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder<List<Appointment>>(
                future: getApp,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 480,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey,
                              width: 4,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 400,
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 25,
                                          child: Text(
                                            "Patient Name:",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 25,
                                          child: Text(
                                            "Age:",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 25,
                                          child: Text(
                                            "Gender:",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 50,
                                          child: Text(
                                            "Address:",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 25,
                                          child: Text(
                                            "Service:",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 25,
                                          child: Text(
                                            "Date:",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 25,
                                          child: Text(
                                            "Time:",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 25,
                                          child: Text(
                                            "Employee:",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 25,
                                          child: Text(
                                            "Organization:",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 25,
                                          child: Text(
                                            "Status:",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 375,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 25,
                                          child: Text(
                                            snapshot.data![index].pfname +
                                                ' ' +
                                                snapshot.data![index].plname,
                                            style: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 25,
                                          child: Text(
                                            snapshot.data![index].age
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 25,
                                          child: Text(
                                            snapshot.data![index].gender,
                                            style: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 50,
                                          child: Text(
                                            snapshot.data![index].address,
                                            style: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 25,
                                          child: Text(
                                            snapshot.data![index].service,
                                            style: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 25,
                                          child: Text(
                                            snapshot.data![index].date,
                                            style: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            height: 25,
                                            child: snapshot.data![index]
                                                        .timeslot ==
                                                    'S1'
                                                ? Text(
                                                    "6am-9am (3hr)",
                                                    style: TextStyle(
                                                      color: Colors.teal,
                                                      fontSize: 18,
                                                    ),
                                                  )
                                                : snapshot.data![index]
                                                            .timeslot ==
                                                        'S2'
                                                    ? Text(
                                                        "9am-12pm (3hr)",
                                                        style: TextStyle(
                                                          color: Colors.teal,
                                                          fontSize: 18,
                                                        ),
                                                      )
                                                    : snapshot.data![index]
                                                                .timeslot ==
                                                            'S3'
                                                        ? Text(
                                                            "12pm-3pm (3hr)",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.teal,
                                                              fontSize: 18,
                                                            ),
                                                          )
                                                        : snapshot.data![index]
                                                                    .timeslot ==
                                                                'S4'
                                                            ? Text(
                                                                "3pm-6pm (3hr)",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .teal,
                                                                  fontSize: 18,
                                                                ),
                                                              )
                                                            : snapshot
                                                                        .data![
                                                                            index]
                                                                        .timeslot ==
                                                                    'S5'
                                                                ? Text(
                                                                    "6pm-9pm (3hr)",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .teal,
                                                                      fontSize:
                                                                          18,
                                                                    ),
                                                                  )
                                                                : snapshot
                                                                            .data![
                                                                                index]
                                                                            .timeslot ==
                                                                        'S6'
                                                                    ? Text(
                                                                        "9pm-12am (3hr)",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.teal,
                                                                          fontSize:
                                                                              18,
                                                                        ),
                                                                      )
                                                                    : snapshot.data![index].timeslot ==
                                                                            'S7'
                                                                        ? Text(
                                                                            "12am-3am (3hr)",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.teal,
                                                                              fontSize: 18,
                                                                            ),
                                                                          )
                                                                        : Text(
                                                                            "3am-6am (3hr)",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.teal,
                                                                              fontSize: 18,
                                                                            ),
                                                                          )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 25,
                                          child: Text(
                                            snapshot.data![index].empname,
                                            style: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 25,
                                          child: Text(
                                            snapshot.data![index].orgname,
                                            style: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 25,
                                          child: Text(
                                            snapshot.data![index].status,
                                            style: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
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
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Complete',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    CompleteAppointment(
                                        snapshot.data![index].aid);
                                    print("Appointment Completed");
                                    DeletSchedule(
                                        snapshot.data![index].eid,
                                        snapshot.data![index].date,
                                        snapshot.data![index].timeslot);
                                    print("Schedule Deleted");
                                    UpdateSchPendApp(snapshot.data![index].eid);
                                    print("Schedule Updated");
                                    setState(
                                      () {
                                        snapshot.data!.removeAt(index);
                                      },
                                    );
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
