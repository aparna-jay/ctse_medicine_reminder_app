import 'package:flutter/material.dart';

class  InjectionReminder extends StatelessWidget {
  static const String routeName = '/newInjectionReminder';
  const  InjectionReminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Injection Reminder"),
        ),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width:double.infinity,
            ),
            ElevatedButton(onPressed: () {  }, child: Text('Injection Reminders'),
            ),
          ],
        )
    );
  }
}
