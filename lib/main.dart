import 'package:ctse_medicine_reminder_app/pages/AddInjectionReminder.dart';
import 'package:ctse_medicine_reminder_app/pages/InjectionReminders.dart';
import 'package:ctse_medicine_reminder_app/pages/Splash.dart';
import 'package:ctse_medicine_reminder_app/pages/aboutUs.dart';
import 'package:ctse_medicine_reminder_app/pages/addPillReminder.dart';
import 'package:ctse_medicine_reminder_app/pages/addHealthHabitReminder.dart';
import 'package:ctse_medicine_reminder_app/pages/pillReminders.dart';
import 'package:ctse_medicine_reminder_app/pages/healthHabitReminders.dart';
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
        // Home.routeName: (context) => Home(),
        Home.routeName: (context) => Splash(),
        AddPillReminder.routeName: (context) => AddPillReminder(0),
        RefillReminder.routeName:(context)=> RefillReminder(),
        AddInjectionReminder.routeName:(context)=> AddInjectionReminder(0),
        InjectionReminders.routeName:(context)=> InjectionReminders(),
        PillReminders.routeName:(context)=> PillReminders(),
        RefillReminderForm.routeName:(context)=>RefillReminderForm(id: "0",),
        FeedbackForm.routeName:(context)=>FeedbackForm(),
        Aboutus.routeName:(context)=>Aboutus(),
        AddHealthHabitReminder.routeName: (context) => AddHealthHabitReminder(0),
        HealthHabitReminders.routeName:(context)=> HealthHabitReminders(),
      },
    );
  }
}
