import 'package:flutter/material.dart';
import 'package:hhc/Screens/DocSignUp.dart';
import 'package:hhc/Screens/NurseSignUp.dart';

class AddEmpSer extends StatefulWidget {
  const AddEmpSer({Key? key}) : super(key: key);

  @override
  _AddEmpSerState createState() => _AddEmpSerState();
}

class _AddEmpSerState extends State<AddEmpSer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Container(
                height: 120,
                width: 400,
                child: Text(
                  'Add Employee and services',
                  style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w900,
                      fontSize: 40),
                ),
              ),
              Container(
                width: 400,
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        child: Text(
                          'Add Doctors',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DocSignUp(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 50,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        child: Text(
                          'Add Nurse',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NurseSignUp()));
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 50,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        child: Text(
                          'Add Service',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          //Navigator.push(
                          //  context,
                          //MaterialPageRoute(
                          //  builder: (context) => NurseSignUp()));
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
