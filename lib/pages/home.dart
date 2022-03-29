import 'package:ctse_medicine_reminder_app/pages/InjectionReminders.dart';
import 'package:ctse_medicine_reminder_app/pages/addPillReminder.dart';
import 'package:ctse_medicine_reminder_app/pages/pillReminders.dart';
import 'package:ctse_medicine_reminder_app/pages/reFillReminder.dart';
import 'package:flutter/material.dart';

import 'AddInjectionReminder.dart';
import 'feedbackForm.dart';

class  Home extends StatelessWidget {
  static const String routeName = '/';
  const  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width:double.infinity,
          ),
          ElevatedButton(onPressed: () {
            Navigator.of(context).pushNamed(PillReminders.routeName);
          }, child: const Text('Pill Reminders'),
          ),
          const SizedBox(height:30
          ),
          ElevatedButton(onPressed: () {
            Navigator.of(context).pushNamed(RefillReminder.routeName);
          }, child: const Text('Refill Reminders'),
          ),
          const SizedBox(height:30
          ),
          ElevatedButton(onPressed: () {  }, child: const Text('Health Habit Reminders'),
          ),
          const SizedBox(height:30
          ),
          ElevatedButton(onPressed: () {
            Navigator.of(context).pushNamed(InjectionReminders.routeName);
          }, child: const Text('Injection Reminders'),
          ),
          const SizedBox(height:30
          ),
          ElevatedButton(onPressed: () {
            Navigator.of(context).pushNamed(FeedbackForm.routeName);
          }, child: const Text('Feedback'),
          ),
        ],
      ),
    );
  }
}
