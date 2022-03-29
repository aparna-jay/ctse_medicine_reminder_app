import 'package:ctse_medicine_reminder_app/pages/AddInjectionReminder.dart';
import 'package:ctse_medicine_reminder_app/pages/InjectionReminders.dart';
import 'package:ctse_medicine_reminder_app/pages/addPillReminder.dart';
import 'package:ctse_medicine_reminder_app/pages/feedbackForm.dart';
import 'package:ctse_medicine_reminder_app/pages/reFillReminder.dart';
import 'package:ctse_medicine_reminder_app/pages/reFillReminderForm.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Home.routeName,
      routes: {
        Home.routeName: (context) => Home(),
        AddPillReminder.routeName: (context) => AddPillReminder(),
        RefillReminder.routeName:(context)=> RefillReminder(),
        AddInjectionReminder.routeName:(context)=> AddInjectionReminder(),
        InjectionReminders.routeName:(context)=> InjectionReminders(),
        RefillReminderForm.routeName:(context)=>RefillReminderForm(id: "0",),
        FeedbackForm.routeName:(context)=>FeedbackForm(),
      },
    );
  }
}
