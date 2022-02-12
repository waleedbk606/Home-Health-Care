import 'package:flutter/material.dart';
import 'package:hhc/Models/Users.dart';
import 'package:hhc/Screens/Home.dart';
import 'package:hhc/Screens/Login.dart';
import 'package:hhc/Screens/Records.dart';
import 'package:hhc/Screens/UserAppointments.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatefulWidget {
  final User obj;

  const NavDrawer({Key? key, required this.obj}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  late User object = widget.obj;
  // void logoutUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.clear();
  //   Navigator.of(context)
  //       .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // FutureBuilder(
          //     future: FlutterSession().get('token'),
          //     builder: (context, snapshot) {
          //       return Text(snapshot.hasData ? snapshot.data : 'loading...');
          //     }),
          DrawerHeader(
            child: Text(
              object.fname + " " + object.lname,
              style: TextStyle(color: Colors.tealAccent, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          /*ListTile(
            leading: Icon(
              Icons.sentiment_satisfied_alt,
            ),
            title: Text('Welcome'),
            onTap: () => {},
          ),*/
          // ListTile(
          //   leading: Icon(Icons.verified_user),
          //   title: Text('Profile'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: Text('Home'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => hhcHome(
                    username: object.username,
                    password: object.password,
                  ),
                ),
              ),
            },
          ),
          ListTile(
            leading: Icon(
              Icons.watch_later,
            ),
            title: Text('Appointments'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserAppoint(
                    obj: object,
                  ),
                ),
              ),
            },
          ),
          ListTile(
            leading: Icon(
              Icons.content_paste,
            ),
            title: Text('Records'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Records(
                    obj: object,
                  ),
                ),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              // logoutUser(),
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LoginPage()))
            },
          ),
        ],
      ),
    );
  }
}
