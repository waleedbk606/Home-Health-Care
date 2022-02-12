import 'package:flutter/material.dart';
import 'package:hhc/Models/Employee.dart';
import 'package:hhc/Models/Schedule.dart';
import 'package:hhc/Screens/Employee.dart';
import 'package:http/http.dart' as http;
import '../Urls.dart';

class Leave extends StatefulWidget {
  final Employee obj;
  final Schedule Sobj;
  const Leave({Key? key, required this.obj, required this.Sobj})
      : super(key: key);

  @override
  _LeaveState createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {
  DateTime date = DateTime.now();
  String SelectedDate = '';
  TextEditingController detailsController = TextEditingController();
  @override
  void initState() {
    super.initState();
    date = DateTime.now();
  }

  Future<void> GivenDate() async {
    var res = await http.post(
      Uri.parse("http://${Url.ip}/HhcApi/api/Login/AddEmpSchedule"),
      body: {
        "eid": widget.Sobj.eid.toString(),
        "fname": widget.Sobj.fname,
        "lname": widget.Sobj.lname,
        "orgname": widget.Sobj.orgname,
        "dep": widget.Sobj.dep,
        "shift": widget.Sobj.shift,
        "noOfpndApnt": widget.Sobj.noOfpndApnt.toString(),
        "ratings": widget.Sobj.ratings.toString(),
        "date": SelectedDate,
        "timeslot": 'Leave',
        "NoLeave": (widget.Sobj.noLeave).toString(),
      },
    );
    if (res.statusCode == 200) {
      print("Given data ADD");
    }
  }

  Future<void> UpdateOrg(int id) async {
    final response = await http.patch(
        Uri.parse('http://${Url.ip}/HhcApi/api/Login/NoLeave?eid=${id}'));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

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
        SelectedDate = date.day.toString() +
            '-' +
            date.month.toString() +
            '-' +
            date.year.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apply Leave "),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Container(
                height: 350,
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
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 40,
                          width: 130,
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
                                  style: TextStyle(
                                    color: Colors.white,
                                    // fontSize: 10,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          key: UniqueKey(),
                          child: Text(
                            SelectedDate,
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 100,
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 20,
                        controller: detailsController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Details',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 40,
                      width: 130,
                      child: RaisedButton(
                        onPressed: () {
                          widget.Sobj.noLeave > 2 ? "No More" : GivenDate();
                          UpdateOrg(widget.Sobj.eid);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EmployeeHome(obj: widget.obj),
                            ),
                          );
                        },
                        color: Colors.blue,
                        child: Center(
                          child: Text(
                            'Apply',
                            style: TextStyle(
                              color: Colors.white,
                              // fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
