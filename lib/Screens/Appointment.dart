import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hhc/Models/Schedule.dart';
import 'package:hhc/Models/Users.dart';
import 'package:hhc/Screens/Home.dart';
import '../Urls.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Appointment extends StatefulWidget {
  final String service;
  final User userObj;
  final String org;
  final String dep;

  const Appointment(
      {Key? key,
      required this.service,
      required this.userObj,
      required this.org,
      required this.dep})
      : super(key: key);

  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  String SelectedDate = '';
  TimeOfDay SelectedTime = TimeOfDay.now();
  String selectedgender = 'Male';
  String Shift = 'Morning';
  late Schedule ScheduleObj;

  // List<Schedule> paresd = [];
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
  String selectedTimeSlot = "6am-9am";
  String sO = '';
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
    _time = TimeOfDay.now();
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
        print(
          SelectedDate.toString(),
        );
      });
    }
  }

  Future<List<Schedule>> GetSchedule(
      String shift, String data, String time) async {
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
            ScheduleObj = paresd[i];
            print(
                ScheduleObj.fname + ' ' + ScheduleObj.lname + ' Is available');
            break;
          } else if (paresd[i].date == data && paresd[i].timeslot == time) {
            print(paresd[i].fname +
                ' ' +
                paresd[i].lname +
                ' Is Busy at ' +
                time);
            for (int j = i; j < 5; j++) {
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
            continue;
          } else if (paresd[i].date == data &&
              paresd[i].timeslot == time + 'L') {
            print(paresd[i].fname +
                ' ' +
                paresd[i].lname +
                ' Is on Leave at ' +
                time +
                'L');
            for (int j = i; j < 5; j++) {
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
            continue;
          } else if (paresd[i].date == data && paresd[i].timeslot == 'Leave') {
            print(paresd[i].fname +
                ' ' +
                paresd[i].lname +
                ' Is on Full Leave on ' +
                data);
            for (int j = 0; j < 5; j++) {
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
            continue;
          } else {
            print(paresd[i].fname + ' ' + paresd[i].lname + ' 606');
            continue;
          }
        }
      } else {
        print('List is null');
      }
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> sendData() async {
    var res = await http.post(
      Uri.parse(url),
      body: {
        'Fname': FnameController.text,
        'Lname': LnameController.text,
        'Age': AgeController.text,
        'Gender': selectedgender,
        'Phone': PhonenumController.text,
        'Address': AddressController.text,
        'Service': widget.service,
        'Username': widget.userObj.username,
      },
    );
    if (res.statusCode == 200) {
      print(res.body);
      var data = json.decode(res.body);
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment'),
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
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: PhonenumController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 330,
                    child: TextField(
                      controller: AddressController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 40,
                    width: 50,
                    color: Colors.blueAccent,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gender',
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 40,
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
                          ],
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Row(
                          children: [
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
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: TextFormField(
            //     cursorColor: Color(0xFFC41A3B),
            //     readOnly: true,
            //     onTap: () {
            //       setState(() {
            //         _selectDate(context);
            //       });
            //     },
            //     decoration: InputDecoration(
            //         labelText: 'Select Date',
            //         // you can style labelText
            //         labelStyle: TextStyle(fontSize: 16.0),
            //         hintText: (_date.toString()),
            //         // you can style hintText
            //         focusedBorder: OutlineInputBorder(
            //           borderSide: BorderSide(
            //               color: Color(0xFFC41A3B),
            //               width:
            //                   2.0), // Focused Border you can style your own way
            //           // borderRadius: BorderRadius.circular(50.0), // Border Radius for outline
            //         ),
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(5.0), // Normal Border
            //         )),
            //   ),
            // ),

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
                  width: 30,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 180,
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

                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: RaisedButton(
                //     onPressed: () {
                //       setState(() {
                //         _pickTime();
                //       });
                //     },
                //     color: Colors.blue,
                //     child: Row(
                //       children: [
                //         Text(
                //           'Select Time',
                //           style: TextStyle(
                //             color: Colors.white,
                //           ),
                //         ),
                //         SizedBox(
                //           width: 3,
                //         ),
                //         Icon(
                //           Icons.schedule,
                //           color: Colors.white,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
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
                                  GetSchedule(Shift, SelectedDate, sO);
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
                                  GetSchedule(Shift, SelectedDate, sO);
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
                                  GetSchedule(Shift, SelectedDate, sO);
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
                                  GetSchedule(Shift, SelectedDate, sO);
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
                                  GetSchedule(Shift, SelectedDate, sO);
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
                                  GetSchedule(Shift, SelectedDate, sO);
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
                                  GetSchedule(Shift, SelectedDate, sO);
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
                                  GetSchedule(Shift, SelectedDate, sO);
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

            // ListTile(
            //   title: Text('Time : ${_time.hour}:${_time.minute}'),
            //   trailing: Icon(Icons.timer),
            //   onTap: _pickTime,
            // ),
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
                  sendData();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => hhcHome()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _pickTime() async {
    TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: _time,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(),
            child: MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: child!,
              ),
            ),
          );
        });
    if (time != null)
      setState(() {
        _time = time;
        SelectedTime = _time;
      });
    print(SelectedTime);
  }
}
