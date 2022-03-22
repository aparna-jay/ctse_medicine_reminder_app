import 'package:flutter/material.dart';

class  AddPillReminder extends StatelessWidget {
  static const String routeName = '/addPillReminders';
  const  AddPillReminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Add Pill Reminder"),
    ),
    body:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width:double.infinity,
        ),
        ElevatedButton(onPressed: () {  }, child: Text('Pill Reminders'),
        ),
      ],
    )
    );
  }
}
