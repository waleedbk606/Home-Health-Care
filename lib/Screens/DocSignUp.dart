import 'package:flutter/material.dart';
import 'package:hhc/Screens/Login.dart';
import 'package:hhc/Screens/ViewDoctors.dart';

class DocSignUp extends StatefulWidget {
  const DocSignUp({Key? key}) : super(key: key);

  @override
  _DocSignUpState createState() => _DocSignUpState();
}

class _DocSignUpState extends State<DocSignUp> {
  TextEditingController Fname = TextEditingController();
  TextEditingController Lname = TextEditingController();
  TextEditingController Age = TextEditingController();
  TextEditingController Cnic = TextEditingController();
  TextEditingController Dob = TextEditingController();
  TextEditingController Gender = TextEditingController();
  TextEditingController Phonenum = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController Qualification = TextEditingController();
  TextEditingController Speciality = TextEditingController();
  TextEditingController Experience = TextEditingController();
  TextEditingController Department = TextEditingController();
  TextEditingController Organization = TextEditingController();
  TextEditingController ConsultationFee = TextEditingController();
  TextEditingController Username = TextEditingController();
  TextEditingController Password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign UP'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: Fname,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: Lname,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: Age,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: Cnic,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CNIC',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: Dob,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date Of Birth',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: Gender,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Gender',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: Phonenum,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: Email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: Address,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: Qualification,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Qualification',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: Speciality,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Speciality',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: Experience,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Experience',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: Department,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Department',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: Organization,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Organization',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: ConsultationFee,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Consultation Fee',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: Username,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: Password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
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
                    'Add Doctor',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ViewDoctors()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
