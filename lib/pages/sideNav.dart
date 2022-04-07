import 'package:ctse_medicine_reminder_app/pages/InjectionReminders.dart';
import 'package:ctse_medicine_reminder_app/pages/aboutUs.dart';
import 'package:ctse_medicine_reminder_app/pages/pillReminders.dart';
import 'package:ctse_medicine_reminder_app/pages/reFillReminder.dart';
import 'package:ctse_medicine_reminder_app/pages/healthHabitReminders.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'feedbackForm.dart';

class SideNav extends StatelessWidget {

  //Resource https://maffan.medium.com/how-to-create-a-side-menu-in-flutter-a2df7833fdfb

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child:  SizedBox(
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/logo.png'))),
           ),
          ListTile(
            leading: Icon(FontAwesomeIcons.pills, color:Colors.blue),
            title: Text('Pill Reminders', style: TextStyle(fontSize: 18, color: Colors.grey)),
            onTap: () => {Navigator.of(context).pushNamed(PillReminders.routeName)},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.prescriptionBottle, color:Colors.blue),
            title: Text('Refill Reminders', style: TextStyle(fontSize: 18, color: Colors.grey)),
            onTap: () => {Navigator.of(context).pushNamed(RefillReminder.routeName)},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.syringe, color:Colors.blue),
            title: Text('Injection Reminders',  style: TextStyle(fontSize: 18, color: Colors.grey)),
            onTap: () => {Navigator.of(context).pushNamed(InjectionReminders.routeName)},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.appleAlt, color:Colors.blue),
            title: Text('Health Habit Reminders',  style: TextStyle(fontSize: 18, color: Colors.grey)),
            onTap: () => {Navigator.of(context).pushNamed(HealthHabitReminders.routeName)},
          ),
          ListTile(
            leading: Icon(Icons.border_color, color:Colors.blue),
            title: Text('Feedback', style: TextStyle(fontSize: 18, color: Colors.grey)),
            onTap: () => {Navigator.of(context).pushNamed(FeedbackForm.routeName)},
          ),
          ListTile(
            leading: Icon(Icons.border_color, color:Colors.blue),
            title: Text('About Us', style: TextStyle(fontSize: 18, color: Colors.grey)),
            onTap: () => {Navigator.of(context).pushNamed(Aboutus.routeName)},
          ),
        ],
      ),
    );
  }
}