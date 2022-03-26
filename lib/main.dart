import 'package:ctse_medicine_reminder_app/pages/Injection%20reminders.dart';
import 'package:ctse_medicine_reminder_app/pages/addPillReminder.dart';
import 'package:ctse_medicine_reminder_app/pages/reFillReminder.dart';
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
        InjectionReminder.routeName:(context)=> InjectionReminder()
      },
    );
  }
}
