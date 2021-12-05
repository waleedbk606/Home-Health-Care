import 'package:flutter/material.dart';
import 'package:hhc/Screens/ViewDoctors.dart';

class DeleteEmp extends StatefulWidget {
  const DeleteEmp({Key? key}) : super(key: key);

  @override
  _DeleteEmpState createState() => _DeleteEmpState();
}

class _DeleteEmpState extends State<DeleteEmp> {
  List<String> _locations = ['Doctor', 'Nurse', 'Service']; // Option 2
  //String _selectedLocation; // Option 2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delete Employee',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 260,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search by Id or Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none),
                        fillColor: Color(0xffe6e6ec),
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    //width: 400,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      border: Border.all(
                        color: Colors.black54,
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: DropdownButton(
                      autofocus: true,
                      /*hint: Text(
                      'Nursing',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 35,
                        color: Colors.teal,
                      ),
                    ),*/
                      //value: _selectedLocation,
                      onChanged: (newValue) {
                        setState(
                          () {
                            // _selectedLocation = newValue;
                          },
                        );
                      },
                      items: _locations.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                      dropdownColor: Colors.white,
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      height: 320,
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      padding: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 51, 204, 255), width: 5),
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 30,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 300,
                              color: Colors.purple,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.medical_services,
                                    size: 100,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Dr.Hasnain',
                                        style: TextStyle(
                                            color: Colors.tealAccent,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 25),
                                      ),
                                      Text(
                                        'Dermatologists',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        'qwertyuiop asdfhkjkk zxcvbnm',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 300,
                              color: Colors.blue,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.medical_services,
                                    size: 100,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Dr.Salman',
                                        style: TextStyle(
                                            color: Colors.tealAccent,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 25),
                                      ),
                                      Text(
                                        'Ophthalmologists',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        'qwertyuiop asdfhkjkk zxcvbnm',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 300,
                              color: Colors.purple,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.medical_services,
                                    size: 100,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Dr.Zain',
                                        style: TextStyle(
                                            color: Colors.tealAccent,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 25),
                                      ),
                                      Text(
                                        'Cardiologists',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        'qwertyuiop asdfhkjkk zxcvbnm',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 100,
                width: 300,
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
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
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
