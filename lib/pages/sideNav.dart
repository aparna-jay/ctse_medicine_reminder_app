import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SideNav extends StatelessWidget {

  //Resource https://maffan.medium.com/how-to-create-a-side-menu-in-flutter-a2df7833fdfb

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'))),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.pills),
            title: Text('PIll Reminder'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.prescriptionBottle),
            title: Text('Refill Reminder'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.syringe),
            title: Text('Injection Reminder'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.appleAlt),
            title: Text('Health Habit Reminder'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}