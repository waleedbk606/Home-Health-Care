// To parse this JSON data, do
//
//     final employee = employeeFromJson(jsonString);

import 'dart:convert';

List<Employee> employeeFromJson(String str) =>
    List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Employee EmpFromJson(String str) => Employee.fromJson(json.decode(str));

String EmpToJson(Employee data) => json.encode(data.toJson());

class Employee {
  Employee({
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
    required this.status,
    required this.nofComApm,
    required this.raitings,
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
  String orgName;
  String department;
  String status;
  int nofComApm;
  int raitings;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
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
        status: json["Status"],
        nofComApm: json["NofComApm"] == null ? null : json["NofComApm"],
        raitings: json["Raitings"] == null ? null : json["Raitings"],
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
        "Status": status,
        "NofComApm": nofComApm == null ? null : nofComApm,
        "Raitings": raitings == null ? null : raitings,
      };
}
