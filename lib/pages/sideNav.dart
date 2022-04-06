import 'package:ctse_medicine_reminder_app/pages/InjectionReminders.dart';
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
            child: Center(
              child: Text(
                'MedReminder',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          //   decoration: BoxDecoration(
          //       color: Colors.green,
          //       image: DecorationImage(
          //           fit: BoxFit.fill,
          //           image: AssetImage('assets/images/cover.jpg'))),
           ),
          ListTile(
            leading: Icon(FontAwesomeIcons.pills),
            title: Text('Pill Reminders'),
            onTap: () => {Navigator.of(context).pushNamed(PillReminders.routeName)},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.prescriptionBottle),
            title: Text('Refill Reminders'),
            onTap: () => {Navigator.of(context).pushNamed(RefillReminder.routeName)},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.syringe),
            title: Text('Injection Reminders'),
            onTap: () => {Navigator.of(context).pushNamed(InjectionReminders.routeName)},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.appleAlt),
            title: Text('Health Habit Reminders'),
            onTap: () => {Navigator.of(context).pushNamed(HealthHabitReminders.routeName)},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pushNamed(FeedbackForm.routeName)},
          ),
        ],
      ),
    );
  }
}