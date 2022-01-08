// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  Welcome({
    required this.eid,
    required this.fname,
    required this.lname,
    required this.age,
    required this.gender,
    required this.cnic,
    required this.phone,
    required this.email,
    required this.qualification,
    required this.experience,
    required this.username,
    required this.password,
    required this.orgName,
    required this.department,
  });

  int eid;
  String fname;
  String lname;
  String age;
  String gender;
  String cnic;
  String phone;
  String email;
  String qualification;
  String experience;
  String username;
  String password;
  dynamic orgName;
  String department;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        eid: json["eid"],
        fname: json["Fname"],
        lname: json["Lname"],
        age: json["Age"],
        gender: json["Gender"],
        cnic: json["CNIC"],
        phone: json["Phone"],
        email: json["Email"],
        qualification: json["Qualification"],
        experience: json["Experience"],
        username: json["Username"],
        password: json["Password"],
        orgName: json["OrgName"],
        department: json["Department"],
      );

  Map<String, dynamic> toJson() => {
        "eid": eid,
        "Fname": fname,
        "Lname": lname,
        "Age": age,
        "Gender": gender,
        "CNIC": cnic,
        "Phone": phone,
        "Email": email,
        "Qualification": qualification,
        "Experience": experience,
        "Username": username,
        "Password": password,
        "OrgName": orgName,
        "Department": department,
      };
}
