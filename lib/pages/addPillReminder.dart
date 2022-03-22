import 'package:flutter/material.dart';

class  AddPillReminder extends StatelessWidget {
  static const String routeName = '/addPillReminders';
  const  AddPillReminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width:double.infinity,
        ),
        ElevatedButton(onPressed: () {  }, child: Text('Pill Reminders'),
        ),
      ],
    );
  }
}
