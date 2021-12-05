import 'package:flutter/material.dart';
import 'package:hhc/Screens/Login.dart';

class NavDrawerDoc extends StatefulWidget {
  const NavDrawerDoc({Key? key}) : super(key: key);

  @override
  _NavDrawerDocState createState() => _NavDrawerDocState();
}

class _NavDrawerDocState extends State<NavDrawerDoc> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'User Name',
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
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(
              Icons.watch_later,
            ),
            title: Text('Apply for leave'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(
              Icons.content_paste,
            ),
            title: Text('Records'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LoginPage()))
            },
          ),
        ],
      ),
    );
  }
}
