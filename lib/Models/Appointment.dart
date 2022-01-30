// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:convert';

List<Appointment> appointmentFromJson(String str) => List<Appointment>.from(
    json.decode(str).map((x) => Appointment.fromJson(x)));

String appointmentToJson(List<Appointment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Appointment {
  Appointment({
    required this.aid,
    required this.orgname,
    required this.eid,
    required this.empname,
    required this.dep,
    required this.service,
    required this.uid,
    required this.username,
    required this.pfname,
    required this.plname,
    required this.age,
    required this.gender,
    required this.phnum,
    required this.address,
    required this.date,
    required this.timeslot,
    required this.timeduration,
    required this.status,
    required this.ratings,
  });

  int aid;
  String orgname;
  int eid;
  String empname;
  String dep;
  String service;
  int uid;
  String username;
  String pfname;
  String plname;
  int age;
  String gender;
  String phnum;
  String address;
  String date;
  String timeslot;
  String timeduration;
  String status;
  int ratings;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        aid: json["aid"],
        orgname: json["orgname"],
        eid: json["eid"],
        empname: json["empname"],
        dep: json["dep"],
        service: json["service"],
        uid: json["uid"],
        username: json["username"],
        pfname: json["pfname"],
        plname: json["plname"],
        age: json["age"],
        gender: json["gender"],
        phnum: json["phnum"],
        address: json["address"],
        date: json["date"],
        timeslot: json["timeslot"],
        timeduration: json["timeduration"],
        status: json["status"],
        ratings: json["ratings"],
      );

  Map<String, dynamic> toJson() => {
        "aid": aid,
        "orgname": orgname,
        "eid": eid,
        "empname": empname,
        "dep": dep,
        "service": service,
        "uid": uid,
        "username": username,
        "pfname": pfname,
        "plname": plname,
        "age": age,
        "gender": gender,
        "phnum": phnum,
        "address": address,
        "date": date,
        "timeslot": timeslot,
        "timeduration": timeduration,
        "status": status,
        "ratings": ratings,
      };
}
