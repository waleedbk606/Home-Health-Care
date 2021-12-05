import 'package:flutter/material.dart';
import 'package:hhc/Screens/ServicesDetail.dart';

class services extends StatefulWidget {
  const services({Key? key}) : super(key: key);

  @override
  _servicesState createState() => _servicesState();
}

class _servicesState extends State<services> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: Padding(
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
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Add Services',
                        style: TextStyle(fontSize: 15, color: Colors.white),
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
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Delete',
                        style: TextStyle(fontSize: 15, color: Colors.white),
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
            ],
          ),
        ),
      ),
    );
  }
}
