import 'package:ctse_medicine_reminder_app/pages/InjectionReminders.dart';
import 'package:ctse_medicine_reminder_app/pages/pillReminders.dart';
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
              children: [
                SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(FontAwesomeIcons.pills),
                        iconSize: 50,
                        onPressed: () { Navigator.of(context).pushNamed(PillReminders.routeName);},
                      ),
                      Text("Pill Reminders", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(FontAwesomeIcons.prescriptionBottle),
                        iconSize: 50,
                        onPressed: () { Navigator.of(context).pushNamed(RefillReminder.routeName);},
                      ),
                      Text("Refill Reminders", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),

                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              SizedBox(
                width: 200,
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(FontAwesomeIcons.syringe),
                      iconSize: 50,
                      onPressed: () { Navigator.of(context).pushNamed(InjectionReminders.routeName);},
                    ),
                    Text("Injection Reminders", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                width: 200,
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(FontAwesomeIcons.appleAlt),
                      iconSize: 50,
                      onPressed: () {},
                    ),
                    Text("Health Habit Reminders", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),

          // ElevatedButton(onPressed: () {
          //   Navigator.of(context).pushNamed(PillReminders.routeName);
          // }, child: const Text('Pill Reminders'),
          // ),
          // const SizedBox(height:30
          // ),
          // ElevatedButton(onPressed: () {
          //   Navigator.of(context).pushNamed(RefillReminder.routeName);
          // }, child: const Text('Refill Reminders'),
          // ),
          // const SizedBox(height:30
          // ),
          // ElevatedButton(onPressed: () {  }, child: const Text('Health Habit Reminders'),
          // ),
          // const SizedBox(height:30
          // ),
          // ElevatedButton(onPressed: () {
          //   Navigator.of(context).pushNamed(InjectionReminders.routeName);
          // }, child: const Text('Injection Reminders'),
          // ),
          // const SizedBox(height:30
          // ),
          // ElevatedButton(onPressed: () {
          //   Navigator.of(context).pushNamed(FeedbackForm.routeName);
          // }, child: const Text('Feedback'),
          // ),
        ],
      ),
    );
  }
}
