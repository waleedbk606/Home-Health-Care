import 'package:flutter/material.dart';
import 'package:hhc/Models/Employee.dart';
import 'package:hhc/Screens/UpdateEmp.dart';
import 'package:http/http.dart' as http;
import '../Urls.dart';

class EmployeeHome extends StatefulWidget {
  final Employee obj;

  const EmployeeHome({Key? key, required this.obj}) : super(key: key);

  @override
  _EmployeeHomeState createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends State<EmployeeHome> {
  // Future<Employee> fetchUserDetails(String Username, String Password) async {
  //   final response = await http.get(Uri.parse(
  //       'http://${Url.ip}/HhcApi/api/Login/GetEmpByUsername?Username=${Username}&Password=${Password}'));
  //   if (response.statusCode == 200) {
  //     Employee paresd = EmpFromJson(response.body);
  //     obj = paresd;
  //     print(paresd.fname);
  //     return paresd;
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  @override
  void initState() {
    super.initState();
//    fetchUserDetails(widget.Username, widget.Password);
  }

  late Employee emp = widget.obj;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(emp.fname + " " + emp.lname)),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 150,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                        'Apply For Leave',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Container(
                    height: 40,
                    width: 150,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                        'ADD Details',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateEmp(obj: emp)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
