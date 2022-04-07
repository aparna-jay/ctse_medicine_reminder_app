import 'package:ctse_medicine_reminder_app/pages/InjectionReminders.dart';
import 'package:ctse_medicine_reminder_app/pages/pillReminders.dart';
import 'package:ctse_medicine_reminder_app/pages/reFillReminder.dart';
import 'package:ctse_medicine_reminder_app/pages/sideNav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'AddInjectionReminder.dart';
import 'feedbackForm.dart';
import 'healthHabitReminders.dart';

class  Home extends StatelessWidget {
  static const String routeName = '/';
  const  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideNav(),
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              width:double.infinity,
              height: 100,
            ),
            Center(child: Text("MedReminder", style: TextStyle( fontSize: 50, fontWeight: FontWeight.bold,
                foreground: Paint()..style = PaintingStyle.stroke..strokeWidth = 5..color = Colors.blueGrey
            ))),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(
                  width:double.infinity,
                  height: 100,
                ),
                const SizedBox(

                ),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        child: Column(
                          children: [
                            IconButton(
                              icon: Icon(FontAwesomeIcons.pills, color:Colors.orange),
                              iconSize: 50,
                              onPressed: () { Navigator.of(context).pushNamed(PillReminders.routeName);},
                            ),
                            Text("Pill Reminders", style: TextStyle(color: Colors.blueGrey, fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            IconButton(
                              icon: Icon(FontAwesomeIcons.prescriptionBottle, color:Colors.orange),
                              iconSize: 50,
                              onPressed: () { Navigator.of(context).pushNamed(RefillReminder.routeName);},
                            ),
                            Text("Refill Reminders", style: TextStyle(color: Colors.blueGrey, fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),

                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(FontAwesomeIcons.syringe, color:Colors.orange),
                            iconSize: 50,
                            onPressed: () { Navigator.of(context).pushNamed(InjectionReminders.routeName);},
                          ),
                          Text("Injection Reminders", style: TextStyle(color: Colors.blueGrey, fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(FontAwesomeIcons.appleAlt, color:Colors.orange),
                            iconSize: 50,
                            onPressed: () {Navigator.of(context).pushNamed(HealthHabitReminders.routeName);},
                          ),
                          Text("Health Habit Reminders", style: TextStyle(color: Colors.blueGrey, fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}