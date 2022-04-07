import 'package:ctse_medicine_reminder_app/pages/InjectionReminders.dart';
import 'package:ctse_medicine_reminder_app/pages/pillReminders.dart';
import 'package:ctse_medicine_reminder_app/pages/healthHabitReminders.dart';
import 'package:ctse_medicine_reminder_app/pages/reFillReminder.dart';
import 'package:ctse_medicine_reminder_app/pages/sideNav.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'AddInjectionReminder.dart';
import 'feedbackForm.dart';

class  Home extends StatelessWidget {
  static const String routeName = '/';
  const  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideNav(),
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width:double.infinity,
          ),

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(FontAwesomeIcons.pills, color:Colors.blue),
                        iconSize: 50,
                        onPressed: () { Navigator.of(context).pushNamed(PillReminders.routeName);},
                      ),
                      Text("Pill Reminders", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(FontAwesomeIcons.prescriptionBottle, color:Colors.blue),
                        iconSize: 50,
                        onPressed: () { Navigator.of(context).pushNamed(RefillReminder.routeName);},
                      ),
                      Text("Refill Reminders", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),

                ),
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(FontAwesomeIcons.syringe, color:Colors.blue),
                      iconSize: 50,
                      onPressed: () { Navigator.of(context).pushNamed(InjectionReminders.routeName);},
                    ),
                    Text("Injection Reminders", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(FontAwesomeIcons.appleAlt, color:Colors.blue),
                      iconSize: 50,
                      onPressed: () {Navigator.of(context).pushNamed(HealthHabitReminders.routeName);},
                    ),
                    Text("Health Habit Reminders", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
