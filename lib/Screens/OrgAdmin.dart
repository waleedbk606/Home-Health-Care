import 'package:flutter/material.dart';
import 'package:hhc/Screens/DocConsult.dart';
import 'package:hhc/Screens/Services.dart';
import 'package:hhc/Screens/ServicesDetail.dart';

class OrgAdmin extends StatefulWidget {
  const OrgAdmin({Key? key}) : super(key: key);

  @override
  _OrgAdminState createState() => _OrgAdminState();
}

class _OrgAdminState extends State<OrgAdmin> {
  List<String> locations = [
    'General physician',
    'Nurse',
    'PHYSIOTHERAPIST',
    'Vaccinator',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Organization Admin')),
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.badge),
                  text: 'Employees',
                ),
                Tab(
                  icon: Icon(
                    Icons.medical_services,
                  ),
                  text: 'Services',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: 250,
                        child: DropdownButton(
                          autofocus: true,
                          focusColor: Colors.white,
                          hint: Text(
                            'Select Department',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              color: Colors.teal,
                            ),
                          ),
                          //value: _selectedLocation,
                          onChanged: (newValue) {
                            setState(
                              () {
                                // _selectedLocation = newValue;
                              },
                            );
                          },
                          items: locations.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                          dropdownColor: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Container(
                          height: 100,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.list_alt,
                                    size: 30,
                                    color: Colors.lightBlueAccent,
                                  ),
                                  Text(
                                    'VIEW EMPLOYEE LIST',
                                    style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 200,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'View',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DocConsult()));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Container(
                          height: 100,
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person_add,
                                      size: 30,
                                      color: Colors.lightBlueAccent,
                                    ),
                                    Text(
                                      'ADD NEW EMPLOYEE',
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 200,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Add',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DocConsult()));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Container(
                          height: 100,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.info,
                                    size: 30,
                                    color: Colors.lightBlueAccent,
                                  ),
                                  Text(
                                    'UPDATE EMPLOYEE',
                                    style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 200,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ServicesDetail()));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Container(
                          height: 100,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    size: 30,
                                    color: Colors.lightBlueAccent,
                                  ),
                                  Text(
                                    'DELETE EMPLOYEE',
                                    style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 200,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => services()));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 140,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                'Add Services',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Container(
                            height: 60,
                            width: 150,
                            padding: EdgeInsets.all(10),
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                        child: Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: "Search by Name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide.none),
                              fillColor: Color(0xffe6e6ec),
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.list_alt_outlined,
                            size: 35,
                            color: Colors.lightBlueAccent,
                          ),
                          Text(
                            'Services List',
                            style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.w500,
                              fontSize: 33,
                            ),
                          ),
                        ],
                      ),
                      Card(
                        child: Container(
                          height: 80,
                          child: Column(
                            children: [
                              Text(
                                "Wounds Dressing",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.lightBlue,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                " Specialized and trained healthcare professionals to treat and care for every kind of wound",
                                style: TextStyle(
                                  fontSize: 15,
                                  //fontWeight: FontWeight.w500,
                                  //color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        child: Container(
                          height: 100,
                          child: Column(
                            children: [
                              Text(
                                "Body Vitals Check",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.lightBlue,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                " Body temperature,Pulse rate Respiration rate of breathing,Blood pressure\(monitored by medical professionals \) ",
                                style: TextStyle(
                                  fontSize: 15,
                                  //fontWeight: FontWeight.w500,
                                  //color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        child: Container(
                          height: 100,
                          child: Column(
                            children: [
                              Text(
                                "Stiches Removal",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.lightBlue,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Specialized and trained healthcare professionals to remove stiches",
                                style: TextStyle(
                                  fontSize: 15,
                                  //fontWeight: FontWeight.w500,
                                  //color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
