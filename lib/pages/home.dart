import 'package:ctse_medicine_reminder_app/pages/addPillReminder.dart';
import 'package:ctse_medicine_reminder_app/pages/reFillReminder.dart';
import 'package:flutter/material.dart';

import 'Injection reminders.dart';

class  Home extends StatelessWidget {
  static const String routeName = '/';
  const  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width:double.infinity,
          ),
          ElevatedButton(onPressed: () {
            Navigator.of(context).pushNamed(AddPillReminder.routeName);
          }, child: Text('Pill Reminders'),
          ),
          SizedBox(height:30
          ),
          ElevatedButton(onPressed: () {
            Navigator.of(context).pushNamed(RefillReminder.routeName);
          }, child: Text('Refill Reminders'),
          ),
          SizedBox(height:30
          ),
          ElevatedButton(onPressed: () {  }, child: Text('Health Habit Reminders'),
          ),
          SizedBox(height:30
          ),
          ElevatedButton(onPressed: () {
            Navigator.of(context).pushNamed(InjectionReminder.routeName);
          }, child: Text('Injection Reminders'),
          ),

        ],
      ),
    );
  }
}
