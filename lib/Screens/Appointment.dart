import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hhc/Models/Schedule.dart';
import 'package:hhc/Models/Users.dart';
import 'package:hhc/Screens/Home.dart';
import 'package:hhc/Screens/UserMap.dart';
import '../Urls.dart';
import 'package:http/http.dart' as http;

class Appointment extends StatefulWidget {
  final String service;
  final User userObj;
  final String org;
  final String dep;
  final double lat;
  final double lng;
  const Appointment({
    Key? key,
    required this.service,
    required this.userObj,
    required this.org,
    required this.dep,
    required this.lat,
    required this.lng,
  }) : super(key: key);

  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  DateTime _date = DateTime.now();
  DateTime Tempdate = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  String SelectedDate = '';
  String SelectedTime = '';
  String selectedgender = 'Male';
  String repeat = 'Once';
  String DWM = 'Daily';
  String Shift = 'Morning';
  Schedule ScheduleObj = new Schedule(
      sid: 0,
      eid: 0,
      fname: '',
      lname: '',
      orgname: '',
      dep: '',
      shift: '',
      noOfpndApnt: 0,
      ratings: 0,
      date: '',
      timeslot: '',
      noLeave: 0,
      city: '');
  List<String> timeslot = [
    '6am-9am',
    '9am-12pm',
    '12pm-3pm',
    '3pm-6pm',
    '6pm-9pm',
    '9pm-12am',
    '12am-3am',
    '3am-6am',
  ];
  List<String> dates = [];
  int repetedcount = 0;
  int availFail = 1;
  String selectedTimeSlot = "6am-9am";
  String sO = '';
  String availability = " ";
  List<int> dailyList = [3, 4, 5, 6, 7];
  int selDay = 3;
  int selWeek = 3;
  int c = 0;
  List<int> WeeklyList = [3, 4, 5, 6, 7];
  bool repeated = false;
  TextEditingController FnameController = TextEditingController();
  TextEditingController LnameController = TextEditingController();
  TextEditingController AgeController = TextEditingController();
  TextEditingController PhonenumController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void validate() {
    if (_formkey.currentState!.validate()) {
      print('ok');
    }
  }

  @override
  void initState() {
    super.initState();
    repeated = false;
    _date = DateTime.now();
  }

  String url = "http://${Url.ip}/HhcApi/api/Login/AddRegister";

  Future<Null> _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
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

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
        SelectedDate = _date.day.toString() +
            '-' +
            _date.month.toString() +
            '-' +
            _date.year.toString();

        print(_date.add(Duration(days: 7)));
        print(
          SelectedDate.toString(),
        );
      });
    }
  }

  Future<String> CheckAvailablity(String a) async {
    String b = a == ' '
        ? ' '
        : a == 'true'
            ? 'Available'
            : 'Not-Avaliable';
    return b;
  }

  Future<Schedule> GetSchedule(String shift, String data, String time) async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}/HhcApi/api/Login/GetSchedule?orgname=${widget.org}&dep=${widget.dep}&shift=${shift}'));
    if (response.statusCode == 200) {
      List<Schedule> paresd = scheduleFromJson(response.body);
      print(widget.org);
      print(widget.dep);
      print(data);
      print(time);
      if (paresd != null && paresd.length != 0) {
        for (int i = 0; i < paresd.length; i++) {
          if (paresd[i].date == 'NoDate' &&
              paresd[i].timeslot == 'S0        ') {
            setState(() {
              availability = 'true';
              ScheduleObj = paresd[i];
            });
            print(
                ScheduleObj.fname + ' ' + ScheduleObj.lname + ' Is available');
            break;
          } else if (paresd[i].date == data && paresd[i].timeslot == time) {
            print(paresd[i].fname +
                ' ' +
                paresd[i].lname +
                ' Is Busy at ' +
                time);
            setState(() {
              availability = 'false';
            });
            for (int j = i; j < 5; j++) {
              if (j + 1 != paresd.length) {
                if (paresd[j].eid == paresd[j + 1].eid) {
                  i++;
                } else {
                  if (i >= paresd.length) {
                    print('No Employee is free');
                    break;
                  } else
                    print(paresd[i].sid);
                  break;
                }
              }
              break;
            }
            continue;
          } else if (paresd[i].date == data &&
              paresd[i].timeslot == time + 'L') {
            print(paresd[i].fname +
                ' ' +
                paresd[i].lname +
                ' Is on Leave at ' +
                time +
                'L');
            setState(() {
              availability = 'false';
            });
            for (int j = i; j < 5; j++) {
              if (j + 1 != paresd.length) {
                if (paresd[j].eid == paresd[j + 1].eid) {
                  i++;
                } else {
                  if (i >= paresd.length) {
                    print('No Employee is free');
                    break;
                  } else
                    print(paresd[i].sid);
                  break;
                }
              }
              break;
            }
            continue;
          } else if (paresd[i].date == data && paresd[i].timeslot == 'Leave') {
            print(paresd[i].fname +
                ' ' +
                paresd[i].lname +
                ' Is on Leave on ' +
                data);
            setState(() {
              availability = 'false';
            });
            for (int j = 0; j < 5; j++) {
              if (j + 1 != paresd.length) {
                if (paresd[j].eid == paresd[j + 1].eid) {
                  i++;
                } else {
                  i++;
                  if (i >= paresd.length) {
                    print('No Employee is free');
                    break;
                  } else
                    print(paresd[i].fname + ' Now');
                  break;
                }
              }
              break;
            }
            continue;
          } else if (i + 1 != paresd.length) {
            if (paresd[i].eid != paresd[i + 1].eid) {
              setState(() {
                ScheduleObj = paresd[i];
                availability = 'true';
              });
              print(
                ScheduleObj.fname + ' ' + ScheduleObj.lname + ' Is available',
              );
              break;
            } else {
              continue;
            }
          } else {
            setState(() {
              availability = 'true';
              ScheduleObj = paresd[i];
            });
            print(
              ScheduleObj.fname + ' ' + ScheduleObj.lname + ' Is available',
            );
            break;
          }
        }
      } else {
        setState(() {
          availability = 'false';
        });
        print('No Employee in this shift');
      }
      print(availability);
      if (ScheduleObj.fname != '') {
        print(ScheduleObj.fname + ' ' + ScheduleObj.lname + ' Is Appointed');
      } else {
        print('No Employee Available!');
      }
      return ScheduleObj;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> sendAppointment() async {
    var res = await http.post(
      Uri.parse("http://${Url.ip}/HhcApi/api/Login/AddAppointment"),
      body: {
        "orgname": widget.org,
        "eid": ScheduleObj.eid.toString(),
        "empname": ScheduleObj.fname + ' ' + ScheduleObj.lname,
        "dep": widget.dep,
        "service": widget.service,
        "uid": widget.userObj.uid.toString(),
        "username": widget.userObj.fname + ' ' + widget.userObj.lname,
        "pfname": FnameController.text,
        "plname": LnameController.text,
        "age": AgeController.text,
        "gender": selectedgender,
        "phnum": PhonenumController.text,
        "address": AddressController.text,
        "date": SelectedDate,
        "timeslot": sO,
        "timeduration": '3hr',
        "status": "Pending",
        "ratings": 0.toString(),
      },
    );
    if (res.statusCode == 200) {
      print("Appointment add");
    }
  }

  Future<void> NullDate(int id) async {
    var res = await http.post(
      Uri.parse("http://${Url.ip}/HhcApi/api/Login/AddNullDatedSchedule"),
      body: {
        "sid": ScheduleObj.sid.toString(),
        "eid": ScheduleObj.eid.toString(),
        "fname": ScheduleObj.fname,
        "lname": ScheduleObj.lname,
        "orgname": ScheduleObj.orgname,
        "dep": ScheduleObj.dep,
        "shift": ScheduleObj.shift,
        "noOfpndApnt": ScheduleObj.noOfpndApnt.toString(),
        "ratings": ScheduleObj.ratings.toString(),
        "date": SelectedDate,
        "timeslot": sO,
        "NoLeave": ScheduleObj.noLeave.toString(),
      },
    );
    if (res.statusCode == 200) {
      print("Null data ADD");
      UpdateOrg(ScheduleObj.eid);
    }
  }

  Future<void> GivenDate() async {
    var res = await http.post(
      Uri.parse("http://${Url.ip}/HhcApi/api/Login/AddEmpSchedule"),
      body: {
        "eid": ScheduleObj.eid.toString(),
        "fname": ScheduleObj.fname,
        "lname": ScheduleObj.lname,
        "orgname": ScheduleObj.orgname,
        "dep": ScheduleObj.dep,
        "shift": ScheduleObj.shift,
        "noOfpndApnt": ScheduleObj.noOfpndApnt.toString(),
        "ratings": ScheduleObj.ratings.toString(),
        "date": SelectedDate,
        "timeslot": sO,
        "NoLeave": ScheduleObj.noLeave.toString(),
      },
    );
    if (res.statusCode == 200) {
      print("Given data ADD");
      UpdateOrg(ScheduleObj.eid);
    }
  }

  Future<void> UpdateOrg(int id) async {
    final response = await http.patch(
        Uri.parse('http://${Url.ip}/HhcApi/api/Login/UpdatePendApp?eid=${id}'));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to load album');
    }
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
      onPressed: () {
        if (ScheduleObj.date == 'NoDate' && ScheduleObj.timeslot == 'S0') {
          sendAppointment();
          NullDate(ScheduleObj.sid);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => hhcHome(
                username: widget.userObj.username,
                password: widget.userObj.password,
              ),
            ),
          );
        } else {
          sendAppointment();
          GivenDate();
          print("Data Send");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => hhcHome(
                username: widget.userObj.username,
                password: widget.userObj.password,
              ),
            ),
          );
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(
        child: Text(
          "Appointment",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
      content: Row(
        children: [
          Container(
            width: 100,
            height: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 25,
                  child: Text("Name:"),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 25,
                  child: Text("Age:"),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 25,
                  child: Text("Gender:"),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 50,
                  child: Text("Address:"),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  height: 25,
                  child: Text("Service:"),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 25,
                  child: Text("Date:"),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 25,
                  child: Text("Time:"),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 25,
                  child: Text("Employee:"),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 25,
                  child: Text("Organization:"),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 25,
                  child: Text("Charges:"),
                ),
              ],
            ),
          ),
          Container(
            width: 130,
            height: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 25,
                  child: Text(
                    FnameController.text + ' ' + LnameController.text,
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 25,
                  child: Text(
                    AgeController.text,
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 25,
                  child: Text(
                    selectedgender,
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 50,
                  child: Text(
                    AddressController.text,
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  height: 25,
                  child: Text(
                    widget.service,
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 25,
                  child: Text(
                    SelectedDate,
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                    height: 25,
                    child: sO == 'S1'
                        ? Text(
                            "6am-9am (3hr)",
                            style: TextStyle(
                              color: Colors.teal,
                            ),
                          )
                        : sO == 'S2'
                            ? Text(
                                "9am-12pm (3hr)",
                                style: TextStyle(
                                  color: Colors.teal,
                                ),
                              )
                            : sO == 'S3'
                                ? Text(
                                    "12pm-3pm (3hr)",
                                    style: TextStyle(
                                      color: Colors.teal,
                                    ),
                                  )
                                : sO == 'S4'
                                    ? Text(
                                        "3pm-6pm (3hr)",
                                        style: TextStyle(
                                          color: Colors.teal,
                                        ),
                                      )
                                    : sO == 'S5'
                                        ? Text(
                                            "6pm-9pm (3hr)",
                                            style: TextStyle(
                                              color: Colors.teal,
                                            ),
                                          )
                                        : sO == 'S6'
                                            ? Text(
                                                "9pm-12am (3hr)",
                                                style: TextStyle(
                                                  color: Colors.teal,
                                                ),
                                              )
                                            : sO == 'S7'
                                                ? Text(
                                                    "12am-3am (3hr)",
                                                    style: TextStyle(
                                                      color: Colors.teal,
                                                    ),
                                                  )
                                                : Text(
                                                    "3am-6am (3hr)",
                                                    style: TextStyle(
                                                      color: Colors.teal,
                                                    ),
                                                  )),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 25,
                  child: Text(
                    ScheduleObj.fname + ' ' + ScheduleObj.lname,
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 25,
                  child: Text(
                    widget.org,
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 25,
                  child: Text(
                    'Rs.500',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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

  showRepeatedAlertDialog(
      BuildContext context, List<String> date, String Time, int dOrY) {
    setState(() {});
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        setState(() {
          dates = [];
          availability = '';
          availFail = 0;
        });
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Confirm"),
      onPressed: () {
        GetSchedule(Shift, SelectedDate, sO);
        if (availability == 'true') {
          if (ScheduleObj.date == 'NoDate' && ScheduleObj.timeslot == 'S0') {
            sendAppointment();
            NullDate(ScheduleObj.sid);
            MaterialPageRoute(
              builder: (context) => hhcHome(
                  username: widget.userObj.username,
                  password: widget.userObj.password),
            );
          } else {
            sendAppointment();
            GivenDate();
            print("Data Send");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => hhcHome(
                  username: widget.userObj.username,
                  password: widget.userObj.password,
                ),
              ),
            );
          }
        } else {}
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(
        child: Text(
          "Appointments",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
      content: Column(
        children: [
          Row(
            children: [
              Container(
                width: 95,
                height: 210,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 25,
                      child: Text("Name:"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 25,
                      child: Text("Age:"),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   height: 25,
                    //   child: Text("Gender:"),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      child: Text("Address:"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 25,
                      child: Text("Service:"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 25,
                      child: Text("Organization:"),
                    ),
                    Container(
                      height: 25,
                      child: Text("Charges:"),
                    ),
                  ],
                ),
              ),
              Container(
                width: 135,
                height: 210,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 25,
                      child: Text(
                        FnameController.text + ' ' + LnameController.text,
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 25,
                      child: Text(
                        AgeController.text,
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      child: Text(
                        AddressController.text,
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 25,
                      child: Text(
                        widget.service,
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 25,
                      child: Text(
                        widget.org,
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    Container(
                      height: 25,
                      child: Text(
                        'Rs.500',
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: 230,
            child: Column(
              children: [
                Row(children: [
                  Text(
                    'Date',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    'Time:',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ]),
                SizedBox(
                  height: 2,
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dOrY,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  child: Text(
                                    date[index],
                                    // style: TextStyle(
                                    //   fontSize: 12,
                                    // ),
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  height: 30,
                                  child: availFail == 0
                                      ? Center(
                                          child: Text(
                                            Time == 'S1'
                                                ? "6am-9am (3hr)"
                                                : Time == 'S2'
                                                    ? "9am-12pm (3hr)"
                                                    : Time == 'S3'
                                                        ? "12pm-3pm (3hr)"
                                                        : Time == 'S4'
                                                            ? "3pm-6pm (3hr)"
                                                            : Time == 'S5'
                                                                ? "6pm-9pm (3hr)"
                                                                : Time == 'S6'
                                                                    ? "9pm-12am (3hr)"
                                                                    : Time ==
                                                                            'S7'
                                                                        ? "12am-3am (3hr)"
                                                                        : "3am-6am (3hr)",
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: 90,
                                          child: DropdownButton(
                                            autofocus: true,
                                            focusColor: Colors.white,
                                            // isExpanded: true,
                                            onChanged: (String? value) {
                                              setState(
                                                () {
                                                  selectedTimeSlot = value!;
                                                  selectedTimeSlot == "6am-9am"
                                                      ? SelectedTime = 'S1'
                                                      : selectedTimeSlot ==
                                                              "9am-12pm"
                                                          ? SelectedTime = 'S2'
                                                          : selectedTimeSlot ==
                                                                  "12pm-3pm"
                                                              ? SelectedTime =
                                                                  'S3'
                                                              : selectedTimeSlot ==
                                                                      "3pm-6pm"
                                                                  ? SelectedTime =
                                                                      'S4'
                                                                  : selectedTimeSlot ==
                                                                          "6pm-9pm"
                                                                      ? SelectedTime =
                                                                          'S5'
                                                                      : selectedTimeSlot ==
                                                                              "9pm-12am"
                                                                          ? SelectedTime =
                                                                              'S6'
                                                                          : selectedTimeSlot == "12am-3am"
                                                                              ? SelectedTime = 'S7'
                                                                              : selectedTimeSlot == "3am-6am"
                                                                                  ? SelectedTime = 'S8'
                                                                                  : " ";
                                                  print(SelectedTime);
                                                },
                                              );
                                            },
                                            value: selectedTimeSlot,
                                            items: timeslot.map((item) {
                                              return DropdownMenuItem(
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.teal,
                                                  ),
                                                ),
                                                value: item,
                                              );
                                            }).toList(),
                                            dropdownColor: Colors.white,
                                          ),
                                        ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 30,
                                  width: 45,
                                  color: Colors.blue,
                                  child: TextButton(
                                    child: Text(
                                      'Confirm',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      SelectedDate = date[index];
                                      GetSchedule(Shift, SelectedDate, sO);
                                      if (availability == 'true') {
                                        if (ScheduleObj.date == 'NoDate' &&
                                            ScheduleObj.timeslot == 'S0') {
                                          sendAppointment();
                                          NullDate(ScheduleObj.sid);
                                          MaterialPageRoute(
                                            builder: (context) => hhcHome(
                                                username:
                                                    widget.userObj.username,
                                                password:
                                                    widget.userObj.password),
                                          );
                                        } else {
                                          sendAppointment();
                                          GivenDate();
                                          print("Data Send");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => hhcHome(
                                                username:
                                                    widget.userObj.username,
                                                password:
                                                    widget.userObj.password,
                                              ),
                                            ),
                                          );
                                        }
                                      } else {
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
      actions: [
        cancelButton,
        //continueButton,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Booking'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    'Male',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                  ),
                  Radio(
                    groupValue: selectedgender,
                    value: 'Male',
                    onChanged: (String? val) {
                      setState(() {
                        selectedgender = val!;
                        print(selectedgender);
                      });
                    },
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    'Female',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                  ),
                  Radio(
                    groupValue: selectedgender,
                    value: 'Female',
                    onChanged: (String? val) {
                      setState(() {
                        selectedgender = val!;
                        print(selectedgender);
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: PhonenumController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                ),
              ),
            ),
            Card(
              child: Container(
                width: 350,
                height: 75,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          'Location:',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Container(
                          height: 60,
                          //width: 100,
                          padding: EdgeInsets.all(10),
                          child: TextButton(
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
                            child: Row(
                              children: [
                                Text(
                                  'Open Map',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserMap(
                                    service: widget.service,
                                    org: widget.org,
                                    dep: widget.dep,
                                    userObj: widget.userObj,
                                    lat: 0,
                                    lng: 0,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _selectDate(context);
                      });
                    },
                    color: Colors.blue,
                    child: Row(
                      children: [
                        Text(
                          'Select Date',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 140,
                      child: Center(
                        child: Text(
                          _date.day.toString() +
                              '-' +
                              _date.month.toString() +
                              '-' +
                              _date.year.toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Once',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                  ),
                  Radio(
                    groupValue: repeat,
                    value: 'Once',
                    onChanged: (String? val) {
                      setState(() {
                        repeat = val!;
                        print(repeat);
                        repeated = false;
                      });
                    },
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Text(
                    'Repeated',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                  ),
                  Radio(
                    groupValue: repeat,
                    value: 'Repeated',
                    onChanged: (String? val) {
                      setState(() {
                        repeat = val!;
                        print(repeat);
                        repeated = true;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: repeated == true ? true : false,
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Daily',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.teal,
                          ),
                        ),
                        Radio(
                          groupValue: DWM,
                          value: 'Daily',
                          onChanged: (String? val) {
                            setState(() {
                              DWM = val!;
                              print(DWM);
                            });
                          },
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text("Number of days:"),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 50,
                          child: DropdownButton(
                            autofocus: true,
                            focusColor: Colors.white,
                            // isExpanded: true,
                            onChanged: (int? value) {
                              setState(
                                () {
                                  selDay = value!;
                                  repetedcount = selDay;

                                  for (int i = 0; i < selDay; i++) {
                                    setState(() {
                                      Tempdate =
                                          _date.add(new Duration(days: i));
                                      SelectedDate = Tempdate.day.toString() +
                                          '-' +
                                          Tempdate.month.toString() +
                                          '-' +
                                          Tempdate.year.toString();
                                      print(SelectedDate);
                                      dates.add(SelectedDate);
                                      SelectedDate = '';
                                      print(dates.elementAt(i));
                                    });
                                  }
                                },
                              );
                            },
                            value: selDay,
                            items: dailyList.map((item) {
                              return DropdownMenuItem(
                                child: Text(
                                  item.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal,
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Weekly',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.teal,
                          ),
                        ),
                        Radio(
                          groupValue: DWM,
                          value: 'Weekly',
                          onChanged: (String? val) {
                            setState(() {
                              DWM = val!;
                              print(DWM);
                            });
                          },
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Text("Number of weeks:"),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 50,
                          child: DropdownButton(
                            autofocus: true,
                            focusColor: Colors.white,
                            // isExpanded: true,
                            onChanged: (int? value) {
                              setState(
                                () {
                                  selWeek = value!;
                                  repetedcount = selWeek;
                                  for (int i = 0; i < selWeek; i++) {
                                    setState(() {
                                      Tempdate =
                                          _date.add(new Duration(days: i * 7));
                                      SelectedDate = Tempdate.day.toString() +
                                          '-' +
                                          Tempdate.month.toString() +
                                          '-' +
                                          Tempdate.year.toString();
                                      print(SelectedDate);
                                      dates.add(SelectedDate);
                                      SelectedDate = '';
                                      print(dates.elementAt(i));
                                    });
                                  }
                                },
                              );
                            },
                            value: selWeek,
                            items: WeeklyList.map((item) {
                              return DropdownMenuItem(
                                child: Text(
                                  item.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal,
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
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  child: Row(
                    children: [
                      Text(
                        'Select Time Slot:',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 200,
                        child: DropdownButton(
                          autofocus: true,
                          focusColor: Colors.white,
                          isExpanded: true,
                          onChanged: (String? value) {
                            setState(
                              () {
                                this.selectedTimeSlot = value!;
                                if (selectedTimeSlot == "6am-9am") {
                                  setState(() {
                                    Shift = 'Morning';
                                    sO = 'S1';
                                  });
                                  print(selectedTimeSlot +
                                      ' ' +
                                      Shift +
                                      ' ' +
                                      sO);
                                  setState(() {
                                    if (ScheduleObj != null) {
                                      ScheduleObj.eid = 0;
                                      ScheduleObj.sid = 0;
                                      ScheduleObj.fname = '';
                                      ScheduleObj.lname = '';
                                      ScheduleObj.date = '';
                                      ScheduleObj.dep = '';
                                      ScheduleObj.noLeave = 0;
                                      ScheduleObj.noOfpndApnt = 0;
                                      ScheduleObj.orgname = '';
                                      ScheduleObj.ratings = 0;
                                      ScheduleObj.shift = '';
                                      ScheduleObj.timeslot = '';
                                    }
                                  });
                                  repeated == false
                                      ? GetSchedule(Shift, SelectedDate, sO)
                                      : print("Repeted appointment Call");
                                } else if (selectedTimeSlot == "9am-12pm") {
                                  setState(() {
                                    Shift = 'Morning';
                                    sO = 'S2';
                                  });
                                  print(selectedTimeSlot +
                                      ' ' +
                                      Shift +
                                      ' ' +
                                      sO);
                                  setState(() {
                                    if (ScheduleObj != null) {
                                      ScheduleObj.eid = 0;
                                      ScheduleObj.sid = 0;
                                      ScheduleObj.fname = '';
                                      ScheduleObj.lname = '';
                                      ScheduleObj.date = '';
                                      ScheduleObj.dep = '';
                                      ScheduleObj.noLeave = 0;
                                      ScheduleObj.noOfpndApnt = 0;
                                      ScheduleObj.orgname = '';
                                      ScheduleObj.ratings = 0;
                                      ScheduleObj.shift = '';
                                      ScheduleObj.timeslot = '';
                                    }
                                  });
                                  repeated == false
                                      ? GetSchedule(Shift, SelectedDate, sO)
                                      : print("Repeted appointment Call");
                                } else if (selectedTimeSlot == "12pm-3pm") {
                                  setState(() {
                                    Shift = 'Morning';
                                    sO = 'S3';
                                  });
                                  print(selectedTimeSlot +
                                      ' ' +
                                      Shift +
                                      ' ' +
                                      sO);
                                  setState(() {
                                    if (ScheduleObj != null) {
                                      ScheduleObj.eid = 0;
                                      ScheduleObj.sid = 0;
                                      ScheduleObj.fname = '';
                                      ScheduleObj.lname = '';
                                      ScheduleObj.date = '';
                                      ScheduleObj.dep = '';
                                      ScheduleObj.noLeave = 0;
                                      ScheduleObj.noOfpndApnt = 0;
                                      ScheduleObj.orgname = '';
                                      ScheduleObj.ratings = 0;
                                      ScheduleObj.shift = '';
                                      ScheduleObj.timeslot = '';
                                    }
                                  });
                                  repeated == false
                                      ? GetSchedule(Shift, SelectedDate, sO)
                                      : print("Repeted appointment Call");
                                } else if (selectedTimeSlot == "3pm-6pm") {
                                  setState(() {
                                    Shift = 'Morning';
                                    sO = 'S4';
                                  });
                                  print(selectedTimeSlot +
                                      ' ' +
                                      Shift +
                                      ' ' +
                                      sO);
                                  setState(() {
                                    if (ScheduleObj != null) {
                                      ScheduleObj.eid = 0;
                                      ScheduleObj.sid = 0;
                                      ScheduleObj.fname = '';
                                      ScheduleObj.lname = '';
                                      ScheduleObj.date = '';
                                      ScheduleObj.dep = '';
                                      ScheduleObj.noLeave = 0;
                                      ScheduleObj.noOfpndApnt = 0;
                                      ScheduleObj.orgname = '';
                                      ScheduleObj.ratings = 0;
                                      ScheduleObj.shift = '';
                                      ScheduleObj.timeslot = '';
                                    }
                                  });
                                  repeated == false
                                      ? GetSchedule(Shift, SelectedDate, sO)
                                      : print("Repeted appointment Call");
                                } else if (selectedTimeSlot == '6pm-9pm') {
                                  setState(() {
                                    Shift = "Evening";
                                    sO = 'S5';
                                  });
                                  print(selectedTimeSlot +
                                      ' ' +
                                      Shift +
                                      ' ' +
                                      sO);
                                  setState(() {
                                    if (ScheduleObj != null) {
                                      ScheduleObj.eid = 0;
                                      ScheduleObj.sid = 0;
                                      ScheduleObj.fname = '';
                                      ScheduleObj.lname = '';
                                      ScheduleObj.date = '';
                                      ScheduleObj.dep = '';
                                      ScheduleObj.noLeave = 0;
                                      ScheduleObj.noOfpndApnt = 0;
                                      ScheduleObj.orgname = '';
                                      ScheduleObj.ratings = 0;
                                      ScheduleObj.shift = '';
                                      ScheduleObj.timeslot = '';
                                    }
                                  });
                                  repeated == false
                                      ? GetSchedule(Shift, SelectedDate, sO)
                                      : print("Repeted appointment Call");
                                } else if (selectedTimeSlot == '9pm-12am') {
                                  setState(() {
                                    Shift = "Evening";
                                    sO = 'S6';
                                  });
                                  print(selectedTimeSlot +
                                      ' ' +
                                      Shift +
                                      ' ' +
                                      sO);
                                  setState(() {
                                    if (ScheduleObj != null) {
                                      ScheduleObj.eid = 0;
                                      ScheduleObj.sid = 0;
                                      ScheduleObj.fname = '';
                                      ScheduleObj.lname = '';
                                      ScheduleObj.date = '';
                                      ScheduleObj.dep = '';
                                      ScheduleObj.noLeave = 0;
                                      ScheduleObj.noOfpndApnt = 0;
                                      ScheduleObj.orgname = '';
                                      ScheduleObj.ratings = 0;
                                      ScheduleObj.shift = '';
                                      ScheduleObj.timeslot = '';
                                    }
                                  });
                                  repeated == false
                                      ? GetSchedule(Shift, SelectedDate, sO)
                                      : print("Repeted appointment Call");
                                } else if (selectedTimeSlot == '12am-3am') {
                                  setState(() {
                                    Shift = "Night";
                                    sO = 'S7';
                                  });
                                  print(selectedTimeSlot +
                                      ' ' +
                                      Shift +
                                      ' ' +
                                      sO);
                                  setState(() {
                                    if (ScheduleObj != null) {
                                      ScheduleObj.eid = 0;
                                      ScheduleObj.sid = 0;
                                      ScheduleObj.fname = '';
                                      ScheduleObj.lname = '';
                                      ScheduleObj.date = '';
                                      ScheduleObj.dep = '';
                                      ScheduleObj.noLeave = 0;
                                      ScheduleObj.noOfpndApnt = 0;
                                      ScheduleObj.orgname = '';
                                      ScheduleObj.ratings = 0;
                                      ScheduleObj.shift = '';
                                      ScheduleObj.timeslot = '';
                                    }
                                  });
                                  repeated == false
                                      ? GetSchedule(Shift, SelectedDate, sO)
                                      : print("Repeted appointment Call");
                                } else if (selectedTimeSlot == '3am-6am') {
                                  setState(() {
                                    Shift = "Night";
                                    sO = 'S8';
                                  });
                                  print(selectedTimeSlot +
                                      ' ' +
                                      Shift +
                                      ' ' +
                                      sO);
                                  setState(() {
                                    if (ScheduleObj != null) {
                                      ScheduleObj.eid = 0;
                                      ScheduleObj.sid = 0;
                                      ScheduleObj.fname = '';
                                      ScheduleObj.lname = '';
                                      ScheduleObj.date = '';
                                      ScheduleObj.dep = '';
                                      ScheduleObj.noLeave = 0;
                                      ScheduleObj.noOfpndApnt = 0;
                                      ScheduleObj.orgname = '';
                                      ScheduleObj.ratings = 0;
                                      ScheduleObj.shift = '';
                                      ScheduleObj.timeslot = '';
                                    }
                                  });
                                  repeated == false
                                      ? GetSchedule(Shift, SelectedDate, sO)
                                      : print("Repeted appointment Call");
                                }
                              },
                            );
                          },
                          value: selectedTimeSlot,
                          items: timeslot.map((item) {
                            return DropdownMenuItem(
                              child: item == "6am-9am" ||
                                      item == "9am-12pm" ||
                                      item == "12pm-3pm" ||
                                      item == "3pm-6pm"
                                  ? Text(
                                      item + ' ' + "-Morning" + "-3Hr",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                      ),
                                    )
                                  : item == '6pm-9pm' || item == "9pm-12am"
                                      ? Text(
                                          item + ' ' + "-Evening" + "-3Hr",
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                          ),
                                        )
                                      : Text(
                                          item + ' ' + "-Night" + "-3Hr",
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
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
                ),
              ),
            ),
            Visibility(
              visible: repeated == false ? true : false,
              child: FutureBuilder<String>(
                future: CheckAvailablity(availability),
                key: UniqueKey(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: snapshot.data == 'Available'
                              ? Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.check_outlined,
                                      color: Colors.greenAccent,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Available",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.lightBlueAccent),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('(' +
                                        ScheduleObj.fname +
                                        ' ' +
                                        ScheduleObj.lname +
                                        ' Is available)'),
                                  ],
                                )
                              : snapshot.data == 'Not-Avaliable'
                                  ? Row(
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.close_outlined,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Not-Available",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.lightBlueAccent),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '(Please select another Time slot)',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    )
                                  : Text(" "),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
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
                  'Book Now',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  repeated == false
                      ? showAlertDialog(context)
                      : showRepeatedAlertDialog(
                          context, dates, sO, repetedcount);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

// Future<Null> _pickTime() async {
//   TimeOfDay? time = await showTimePicker(
//       context: context,
//       initialTime: _time,
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: ThemeData(),
//           child: MediaQuery(
//             data:
//                 MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
//             child: Directionality(
//               textDirection: TextDirection.ltr,
//               child: child!,
//             ),
//           ),
//         );
//       });
//   if (time != null)
//     setState(() {
//       _time = time;
//       SelectedTime = _time;
//     });
//   print(SelectedTime);
// }
}
