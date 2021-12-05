import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hhc/Screens/BookNow.dart';

class HomeServices extends StatefulWidget {
  const HomeServices({Key? key}) : super(key: key);

  @override
  _HomeServicesState createState() => _HomeServicesState();
}

enum SingingCharacter { lafayette, jefferson }

class _HomeServicesState extends State<HomeServices> {
  List<String> _Nurse = [
    'Wonds Dressing',
    'Body Vitals Check',
    'IV Injections',
    'Stiches Removal'
  ];
  List<String> _Physio = [
    'General physician',
    'NEURO PHYSIOTHERAPIST',
    'SPORT PHYSIOTHERAPIST',
    'CARDIO-RESPIRATORY PHYSIOTHERAPIST'
  ];
  List<String> _Vaccination = ['Covid-19', 'Polio', 'Child Vaccination'];
  List<String> _Date = [
    '08/11/2021',
    '09/11/2021',
    '10/11/2021',
    '11/11/2021',
  ];
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Services',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 255,
                    margin: EdgeInsets.fromLTRB(
                      10,
                      20,
                      10,
                      10,
                    ),
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(
                          255,
                          51,
                          204,
                          255,
                        ),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Positioned(
                    left: 110,
                    top: 9,
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: 10,
                        left: 10,
                        right: 10,
                      ),
                      color: Colors.white,
                      child: Text(
                        'Available In',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 25,
                    child: Text(
                      'Date:',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 100,
                    child: DropdownButton(
                      autofocus: true,
                      hint: Text(
                        '08/11/2021',
                      ),
                      //value: _selectedLocation,
                      onChanged: (newValue) {
                        setState(
                          () {
                            // _selectedLocation = newValue;
                          },
                        );
                      },
                      items: _Date.map(
                        (location) {
                          return DropdownMenuItem(
                            child: new Text(location),
                            value: location,
                          );
                        },
                      ).toList(),
                      dropdownColor: Colors.white,
                    ),
                  ),
                  Positioned(
                    left: 3,
                    //right: ,
                    top: 70,
                    //bottom: ,
                    //height: ,
                    //width: ,
                    child: Container(
                      width: 70,
                      padding: EdgeInsets.all(10),
                      child: Table(
                        border: TableBorder.all(
                          width: 1,
                        ),
                        columnWidths: {
                          0: FixedColumnWidth(60),
                          1: FixedColumnWidth(50),
                          2: FixedColumnWidth(50),
                          3: FixedColumnWidth(50),
                          4: FixedColumnWidth(50),
                          5: FixedColumnWidth(50),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Day',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '9-10',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '11-12',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '01-02',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '03-04',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '05-06',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Mon',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Tue',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Wed',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Ths',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Fri',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Sat',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Sun',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                title: const Text('One Time'),
                leading: Radio<SingingCharacter>(
                  value: SingingCharacter.lafayette,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Repeated'),
                leading: Radio<SingingCharacter>(
                  value: SingingCharacter.lafayette,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      //  _character = value;
                    });
                  },
                ),
              ),
              Container(
                height: 100,
                width: 400,
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
                    'Next',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BookNow()));
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
