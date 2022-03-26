import 'package:flutter/material.dart';

class  InjectionReminders extends StatelessWidget {
  static const String routeName = '/InjectionReminders';
  const  InjectionReminders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Injection Reminders"),
      ),
      body:Column(
        children: const [
          Text("New Injection Reminder",
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => setState(() => _count++),
        tooltip: 'Increment Counter',
        onPressed: () {  },
        child: const Icon(Icons.add),
      ),
    );
  }
}
