import 'package:flutter/material.dart';
import 'package:hhc/Screens/NavDrawerNurse.dart';

class NurseDashboard extends StatefulWidget {
  const NurseDashboard({Key? key}) : super(key: key);

  @override
  _NurseDashboardState createState() => _NurseDashboardState();
}

class _NurseDashboardState extends State<NurseDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawerNurse(),
      appBar: AppBar(
        title: Text('DashBoard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 650,
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
                        'Schedule',
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.w900,
                            fontSize: 25),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 3,
                    //right: ,
                    top: 30,
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
      ),
    );
  }
}
