import 'package:flutter/material.dart';
import 'package:hhc/Models/Schedule.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';

class ShowAllEmp extends StatefulWidget {
  final List<Schedule> avail;
  final List<Schedule> nonavail;
  const ShowAllEmp({Key? key, required this.avail, required this.nonavail})
      : super(key: key);

  @override
  _ShowAllEmpState createState() => _ShowAllEmpState();
}

class _ShowAllEmpState extends State<ShowAllEmp> {
  bool visibal = true;
  late List<Schedule> avail = widget.avail;
  late List<Schedule> nonavail = widget.nonavail;

  Future<List<Schedule>> Availablist(
      List<Schedule> avail, List<Schedule> nonavail) async {
    print(avail.length);
    print(nonavail.length);
    List<Schedule> b = [];
    for (int i = 0; i < avail.length; i++) {
      if (i == 0) {
        b.add(avail.elementAt(i));
      } else {
        for (int j = 0; j < b.length; j++) {
          if (b[j].eid == avail[i].eid) {
            break;
          } else {
            b.add(avail.elementAt(i));
          }
        }
      }
    }
    for (int j = 0; j < nonavail.length; j++) {
      if (b[j].eid == nonavail[j].eid) {
        b.removeAt(j);
      }
      continue;
    }
    print(b.length);
    return b;
  }

  Future<List<Schedule>> NonAvailablist(List<Schedule> nonavail) async {
    List<Schedule> b = [];
    for (int i = 0; i < nonavail.length; i++) {
      if (i == 0) {
        b.add(nonavail.elementAt(i));
      } else {
        for (int j = 0; j < b.length; j++) {
          if (b[j].eid == nonavail[i].eid) {
            break;
          } else {
            b.add(nonavail.elementAt(i));
          }
        }
      }
    }

    return b;
  }

  @override
  void initState() {
    super.initState();
    Availablist(widget.avail, widget.nonavail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Employee"),
      ),
      body: Column(
        children: [
          Card(
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Name",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 100,
                ),
                Text(
                  "Ratings",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Available",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Distance",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: visibal,
                  child: Container(
                    width: 350,
                    child: FutureBuilder<List<Schedule>>(
                      future: Availablist(avail, nonavail),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          snapshot.data!.length == 0 ? visibal = false : true;
                          print(snapshot.data!.length.toString() + "lenght");
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Colors.grey,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 150,
                                              child: Text(
                                                snapshot.data![index].fname +
                                                    " " +
                                                    snapshot.data![index].lname,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 40,
                                              child: Text(
                                                snapshot.data![index].ratings
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Container(
                                              color: Colors.lightGreenAccent,
                                              width: 40,
                                              child: Text(
                                                "Yes",
                                              ),
                                            ),
                                            SizedBox(
                                              width: 25,
                                            ),
                                            Container(
                                              width: 40,
                                              child: Text(
                                                "1km",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                          // Text(snapshot.data!.name);
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  child: FutureBuilder<List<Schedule>>(
                    future: NonAvailablist(nonavail),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data!.length.toString() + "lenght");
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.grey,
                                child: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 150,
                                            child: Text(
                                              snapshot.data![index].fname +
                                                  " " +
                                                  snapshot.data![index].lname,
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 40,
                                            child: Text(
                                              snapshot.data![index].ratings
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            color: Colors.deepOrangeAccent,
                                            width: 40,
                                            child: Text(
                                              "NO",
                                            ),
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          Container(
                                            width: 40,
                                            child: Text(
                                              "1km",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                        // Text(snapshot.data!.name);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
