import 'package:flutter/material.dart';

class BookNow extends StatefulWidget {
  const BookNow({Key? key}) : super(key: key);

  @override
  _BookNowState createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  TextEditingController FnameController = TextEditingController();
  TextEditingController LnameController = TextEditingController();
  TextEditingController AgeController = TextEditingController();
  TextEditingController CnicController = TextEditingController();
  TextEditingController DobController = TextEditingController();
  TextEditingController GenderController = TextEditingController();
  TextEditingController BloodGroupController = TextEditingController();
  TextEditingController PhonenumController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController AddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Give Patient Details"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: FnameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: LnameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: AgeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: CnicController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CNIC',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: DobController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date Of Birth',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: GenderController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Gender',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: BloodGroupController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Blood Group',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: AddressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: PhonenumController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone#',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: EmailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                height: 60,
                width: 120,
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
                    ' Open Map',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    // Navigator.push(context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ),
              Container(
                height: 60,
                width: 200,
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
                    ' Book Now',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    // Navigator.push(context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()));
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
