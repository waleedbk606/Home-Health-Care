// To parse this JSON data, do
//
//     final schedule = scheduleFromJson(jsonString);

import 'dart:convert';

List<Schedule> scheduleFromJson(String str) =>
    List<Schedule>.from(json.decode(str).map((x) => Schedule.fromJson(x)));

String scheduleToJson(List<Schedule> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Schedule {
  Schedule({
    required this.sid,
    required this.eid,
    required this.fname,
    required this.lname,
    required this.orgname,
    required this.dep,
    required this.shift,
    required this.noOfpndApnt,
    required this.ratings,
    required this.date,
    required this.timeslot,
    required this.noLeave,
  });

  int sid;
  int eid;
  String fname;
  String lname;
  String orgname;
  String dep;
  String shift;
  int noOfpndApnt;
  int ratings;
  String date;
  String timeslot;
  int noLeave;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        sid: json["sid"],
        eid: json["eid"],
        fname: json["fname"],
        lname: json["lname"],
        orgname: json["orgname"],
        dep: json["dep"],
        shift: json["shift"],
        noOfpndApnt: json["noOfpndApnt"],
        ratings: json["ratings"],
        date: json["date"],
        timeslot: json["timeslot"],
        noLeave: json["NoLeave"],
      );

  Map<String, dynamic> toJson() => {
        "sid": sid,
        "eid": eid,
        "fname": fname,
        "lname": lname,
        "orgname": orgname,
        "dep": dep,
        "shift": shift,
        "noOfpndApnt": noOfpndApnt,
        "ratings": ratings,
        "date": date,
        "timeslot": timeslot,
        "NoLeave": noLeave,
      };
}
