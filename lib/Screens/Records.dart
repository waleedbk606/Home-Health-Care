import 'package:flutter/material.dart';
import 'package:hhc/Models/Appointment.dart';
import 'package:hhc/Models/Users.dart';
import 'package:hhc/Screens/NavDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:rating_dialog/rating_dialog.dart';
import '../Urls.dart';

class Records extends StatefulWidget {
  final User obj;
  const Records({Key? key, required this.obj}) : super(key: key);

  @override
  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  Future<List<Appointment>> GetCompletedAppointments() async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}/HhcApi/api/Login/GetCompletedAppointments?uid=${widget.obj.uid}'));
    if (response.statusCode == 200) {
      List<Appointment> paresd = appointmentFromJson(response.body);
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> UpdateRating(int aid, String rate) async {
    final response = await http.patch(Uri.parse(
        'http://${Url.ip}/HhcApi/api/Login/UpdateRatings?aid=${aid}&rating=${rate}'));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  var Rating = 0;
  late Future<List<Appointment>> getApp;
  @override
  void initState() {
    super.initState();
    getApp = GetCompletedAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(obj: widget.obj),
      appBar: AppBar(
        title: Text('         Appointments Record'),
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
                          height: 430,
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
                                height: 430,
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
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 25,
                                      child: Text(
                                        "Ratings:",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 405,
                                //color: Colors.deepOrangeAccent,
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
                                              'S1        '
                                          ? Text(
                                              "6am-9am (3hr)",
                                              style: TextStyle(
                                                color: Colors.teal,
                                                fontSize: 18,
                                              ),
                                            )
                                          : snapshot.data![index].timeslot ==
                                                  'S2        '
                                              ? Text(
                                                  "9am-12pm (3hr)",
                                                  style: TextStyle(
                                                    color: Colors.teal,
                                                    fontSize: 18,
                                                  ),
                                                )
                                              : snapshot.data![index]
                                                          .timeslot ==
                                                      'S3        '
                                                  ? Text(
                                                      "12pm-3pm (3hr)",
                                                      style: TextStyle(
                                                        color: Colors.teal,
                                                        fontSize: 18,
                                                      ),
                                                    )
                                                  : snapshot.data![index]
                                                              .timeslot ==
                                                          'S4        '
                                                      ? Text(
                                                          "3pm-6pm (3hr)",
                                                          style: TextStyle(
                                                            color: Colors.teal,
                                                            fontSize: 18,
                                                          ),
                                                        )
                                                      : snapshot.data![index]
                                                                  .timeslot ==
                                                              'S5        '
                                                          ? Text(
                                                              "6pm-9pm (3hr)",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.teal,
                                                                fontSize: 18,
                                                              ),
                                                            )
                                                          : snapshot
                                                                      .data![
                                                                          index]
                                                                      .timeslot ==
                                                                  'S6        '
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
                                                                      'S7        '
                                                                  ? Text(
                                                                      "12am-3am (3hr)",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .teal,
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                    )
                                                                  : Text(
                                                                      "3am-6am (3hr)",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .teal,
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                    ),
                                    ),
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
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        child: snapshot.data![index].ratings ==
                                                0
                                            ? Container(
                                                height: 35,
                                                color: Colors.lightBlue,
                                                child: TextButton(
                                                  onPressed: () {
                                                    show(snapshot
                                                        .data![index].aid);
                                                  },
                                                  child: Text(
                                                    'Give Ratings',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Text(
                                                snapshot.data![index].ratings
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.teal,
                                                  fontSize: 18,
                                                ),
                                              )),
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

  void show(int aid) {
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon: const Icon(
              Icons.star,
              size: 100,
              color: Colors.blue,
            ), // set your own image/icon widget
            title: "Please Rate Our Service",
            description: "Tap a star to give your rating.",
            submitButton: "SUBMIT",
            // alternativeButton: "Contact us instead?", // optional
            // positiveComment: "We are so happy to hear 😍", // optional
            // negativeComment: "We're sad to hear 😭", // optional
            accentColor: Colors.blue, // optional
            onSubmitPressed: (int rating) {
              Rating = rating;
              print("onSubmitPressed: rating = $Rating");
              UpdateRating(aid, Rating.toString());
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Records(obj: widget.obj)),
              );
              // TODO: open the app's page on Google Play / Apple App Store
            },
            onAlternativePressed: () {
              print("onAlternativePressed: do something");
              // TODO: maybe you want the user to contact you instead of rating a bad review
            },
          );
        });
  }
}
