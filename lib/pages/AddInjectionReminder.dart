import 'package:flutter/material.dart';

import 'InjectionReminders.dart';

class  AddInjectionReminder extends StatelessWidget {
  static const String routeName = '/newInjectionReminder';
  const  AddInjectionReminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Injection Reminder"),
        ),
        body:Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                maxLength: 20,
                autofocus: true,
                autocorrect: true,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 21.0),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 21.0),
              ),
            ),
            const SizedBox(width:double.infinity,
            ),
            ElevatedButton(onPressed: () {
              Navigator.of(context).pushNamed(InjectionReminders.routeName);
            }, child: const Text('Add Reminder +'),
            ),
          ],
        ),

    );
  }
}
