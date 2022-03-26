import 'package:ctse_medicine_reminder_app/pages/addPillReminder.dart';
import 'package:ctse_medicine_reminder_app/pages/reFillReminder.dart';
import 'package:flutter/material.dart';

import 'AddInjectionReminder.dart';

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
            Navigator.of(context).pushNamed(AddPillReminder.routeName);
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
            Navigator.of(context).pushNamed(AddInjectionReminder.routeName);
          }, child: const Text('Injection Reminders'),
          ),

        ],
      ),
    );
  }
}
