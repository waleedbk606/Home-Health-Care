import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hhc/Screens/BookNow.dart';
import 'package:hhc/Screens/NavDrawer.dart';
import 'HomeServices.dart';

class hhcHome extends StatefulWidget {
  const hhcHome({Key? key}) : super(key: key);

  @override
  _hhcHomeState createState() => _hhcHomeState();
}

class _hhcHomeState extends State<hhcHome> {
  List<String> _Org = ['PIMS', 'Nescom', 'Shifa']; // Option 2
  List<String> _Staff = [
    'General physician',
    'Nurse',
    'PHYSIOTHERAPIST',
    'Vaccinator',
  ]; // Option 2
  List<String> _Skill = [
    'Wonds Dressing',
    'Body Vitals Check',
    'Stiches Removal',
  ]; // Option 2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Home Health Care'),
        backgroundColor: Colors.blueAccent,
        /* actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Navigator.push(
              // context,
              // MaterialPageRoute(builder: (context) => SearchPage()),
              //);
            },
          ),
        ],
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(1.0, 0.0),
              end: Alignment(1.0, 0.0),
              colors: [
                Theme.of(context).primaryColorLight,
                Theme.of(context).primaryColorDark,
              ],
            ),
          ),
        ),
        // backgroundColor: Colors.transparent,
        elevation: 0.0,*/
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 250,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search Doctor,Services",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none),
                        fillColor: Color(0xffe6e6ec),
                        filled: true,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(20),
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Stack(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Container(
                      height: 120,
                      width: 400,
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Organizations',
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.w500,
                            fontSize: 33,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    child: Icon(
                      Icons.local_hospital,
                      size: 80,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  Positioned(
                    top: 60,
                    right: 30,
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
                      items: _Org.map((location) {
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
              SizedBox(
                height: 36.0,
              ),
              Stack(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Container(
                      height: 120,
                      width: 400,
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Medical Staff'
                          '',
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.w500,
                            fontSize: 33,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    child: Icon(
                      Icons.medical_services,
                      size: 80,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  Positioned(
                    top: 60,
                    right: 30,
                    child: Container(
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
                        items: _Staff.map((location) {
                          return DropdownMenuItem(
                            child: new Text(location),
                            value: location,
                          );
                        }).toList(),
                        dropdownColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 36.0,
              ),
              Stack(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Container(
                      height: 130,
                      width: 400,
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Type of Services',
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.w500,
                            fontSize: 33,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    child: Icon(
                      Icons.healing,
                      size: 80,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  Positioned(
                    top: 60,
                    right: 30,
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
                      items: _Skill.map((location) {
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
              SizedBox(
                height: 60,
              ),
              Container(
                width: 200,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeServices()));
                  },
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(20),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
