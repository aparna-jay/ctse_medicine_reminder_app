import 'package:flutter/material.dart';

class RefillReminder extends StatefulWidget {
  static const String routeName = '/RefillReminder';
  const RefillReminder({Key? key}) : super(key: key);

  @override
  State<RefillReminder> createState() => _RefillReminderState();
}

class _RefillReminderState extends State<RefillReminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ReFill Reminder"),
      ),
    );
  }
}
