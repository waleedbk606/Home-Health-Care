import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hhc/Models/Appointment.dart';
import 'package:hhc/Models/Users.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../Urls.dart';
import 'NavDrawer.dart';

class UserAppoint extends StatefulWidget {
  final User obj;

  const UserAppoint({Key? key, required this.obj}) : super(key: key);

  @override
  _UserAppointState createState() => _UserAppointState();
}

class _UserAppointState extends State<UserAppoint> {
  Future<List<Appointment>> GetPendingAppointments() async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}/HhcApi/api/User/GetAppointments?uid=${widget.obj.uid}'));
    if (response.statusCode == 200) {
      List<Appointment> paresd = appointmentFromJson(response.body);
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<Appointment>> getApp;
  @override
  void initState() {
    super.initState();
    getApp = GetPendingAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(obj: widget.obj),
      appBar: AppBar(
        title: Text('             Appointments'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                          height: 400,
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
                          child: Row(
                            children: [
                              Container(
                                width: 150,
                                height: 400,
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        snapshot.data![index].age.toString(),
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
                                        child: snapshot.data![index].timeslot ==
                                                'S1'
                                            ? Text(
                                                "6am-9am (3hr)",
                                                style: TextStyle(
                                                  color: Colors.teal,
                                                  fontSize: 18,
                                                ),
                                              )
                                            : snapshot.data![index].timeslot ==
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
                                                          color: Colors.teal,
                                                          fontSize: 18,
                                                        ),
                                                      )
                                                    : snapshot.data![index]
                                                                .timeslot ==
                                                            'S4'
                                                        ? Text(
                                                            "3pm-6pm (3hr)",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.teal,
                                                              fontSize: 18,
                                                            ),
                                                          )
                                                        : snapshot.data![index]
                                                                    .timeslot ==
                                                                'S5'
                                                            ? Text(
                                                                "6pm-9pm (3hr)",
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
                                                                    'S6'
                                                                ? Text(
                                                                    "9pm-12am (3hr)",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .teal,
                                                                      fontSize:
                                                                          18,
                                                                    ),
                                                                  )
                                                                : snapshot.data![index]
                                                                            .timeslot ==
                                                                        'S7'
                                                                    ? Text(
                                                                        "12am-3am (3hr)",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.teal,
                                                                          fontSize:
                                                                              18,
                                                                        ),
                                                                      )
                                                                    : Text(
                                                                        "3am-6am (3hr)",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.teal,
                                                                          fontSize:
                                                                              18,
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
