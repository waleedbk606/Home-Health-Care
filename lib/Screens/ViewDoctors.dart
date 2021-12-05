import "package:flutter/material.dart";
import 'package:flutter/painting.dart';

class ViewDoctors extends StatefulWidget {
  const ViewDoctors({Key? key}) : super(key: key);

  @override
  _ViewDoctorsState createState() => _ViewDoctorsState();
}

class _ViewDoctorsState extends State<ViewDoctors> {
  List<String> _Departments = [
    'Dermatologists',
    'Ophthalmologists',
    'Cardiologists',
    'Gastroenterologists',
  ];
  List<String> _Date = [
    '08/11/2021',
    '09/11/2021',
    '10/11/2021',
    '11/11/2021',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'Doctor\'s Detail',
                style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w900,
                    fontSize: 35),
              ),
            ),
            Container(
              height: 50,
              width: 400,
              child: DropdownButton(
                autofocus: true,
                hint: Text(
                  'Departments',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ), // Not necessary for Option 1

                //value: _selectedLocation,
                onChanged: (newValue) {
                  setState(
                    () {
                      // _selectedLocation = newValue;
                    },
                  );
                },
                items: _Departments.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
              ),
            ),
            Table(
              border: TableBorder.all(
                width: 2,
              ),
              columnWidths: {
                0: FixedColumnWidth(40),
                1: FixedColumnWidth(110),
                2: FixedColumnWidth(220),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.top,
              children: [
                TableRow(
                  children: [
                    Column(
                      children: [
                        Text(
                          'ID',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w900,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w900,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Department',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w900,
                              fontSize: 20),
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
                          '1',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Dr.Hasnain',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Dermatologists',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
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
                          '2',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Dr.Abdullah',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Cardiologists',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
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
                          '3',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Dr.Salman',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Gastroenterologists',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
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
                          '4',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Dr.Zeeshan',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Ophthalmologists',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
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
                          '5',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Dr.Zain',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Nephrologists',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 255,
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  padding: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromARGB(255, 51, 204, 255), width: 5),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                  ),
                ),
                Positioned(
                  left: 110,
                  top: 9,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    color: Colors.white,
                    child: Text(
                      'Available In',
                      style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
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
                        fontSize: 25),
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
                    items: _Date.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
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
                                      fontSize: 20),
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
                                      fontSize: 13),
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
                                      fontSize: 13),
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
                                      fontSize: 13),
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
                                      fontSize: 13),
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
                                      fontSize: 13),
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
                                  'Tue',
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
          ],
        ),
      ),
    );
  }
}
