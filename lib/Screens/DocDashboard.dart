import 'package:flutter/material.dart';
import 'package:hhc/Screens/NavDrawerDoc.dart';

class DocDashboard extends StatefulWidget {
  const DocDashboard({Key? key}) : super(key: key);

  @override
  _DocDashboardState createState() => _DocDashboardState();
}

class _DocDashboardState extends State<DocDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawerDoc(),
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
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Container(
                        height: 80,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Patient: ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "M.Waleed",
                                  style: TextStyle(
                                    fontSize: 15,
                                    //fontWeight: FontWeight.w500,
                                    //color: Colors.teal,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Address:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal,
                                  ),
                                ),
                                Text(
                                  " Flat#3,4th floor,st#20,G-8/4",
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Date:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal,
                                  ),
                                ),
                                Text(
                                  " 20-Dec-2021",
                                ),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  "Time:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal,
                                  ),
                                ),
                                Text(
                                  " 09:00 am - 10:00 am",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Container(
                        height: 80,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Patient: ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Obaid",
                                  style: TextStyle(
                                    fontSize: 15,
                                    //fontWeight: FontWeight.w500,
                                    //color: Colors.teal,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Address:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal,
                                  ),
                                ),
                                Text(
                                  "House#2,st#10,G-9/1",
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Date:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal,
                                  ),
                                ),
                                Text(
                                  " 21-Dec-2021",
                                ),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  "Time:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal,
                                  ),
                                ),
                                Text(
                                  " 11:00 am - 12:00 am",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Container(
                        height: 80,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Patient: ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Zohaib",
                                  style: TextStyle(
                                    fontSize: 15,
                                    //fontWeight: FontWeight.w500,
                                    //color: Colors.teal,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Address:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal,
                                  ),
                                ),
                                Text(
                                  " House#26,st#2,Raja Bazar Rawalpindi",
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Date:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal,
                                  ),
                                ),
                                Text(
                                  " 21-Dec-2021",
                                ),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  "Time:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal,
                                  ),
                                ),
                                Text(
                                  " 02:00 am - 03:00 am",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Container(
                        height: 80,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Patient: ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Adnan",
                                  style: TextStyle(
                                    fontSize: 15,
                                    //fontWeight: FontWeight.w500,
                                    //color: Colors.teal,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Address:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal,
                                  ),
                                ),
                                Text(
                                  " House#34,st#3-B,F-10/4",
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Date:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal,
                                  ),
                                ),
                                Text(
                                  " 22-Dec-2021",
                                ),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  "Time:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal,
                                  ),
                                ),
                                Text(
                                  " 04:00 am - 05:00 am",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
