import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'home.dart';

class Aboutus extends StatelessWidget {
  static const String routeName = '/aboutus ';

  // static final TextEditingController _nameController = TextEditingController();
  // static final TextEditingController _feedController = TextEditingController();

  // static void clear() {
  //   _nameController.text = '';
  //   _feedController.text = '';
  // }

  const Aboutus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"  ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "About Us",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1,
                      fontSize: 25,
                      // color: Colors.blue
                  ),
                ),
                const SizedBox(height: 5),
                // const Text(
                //   "Med Reminder reminds you to take your Pills, Re fill pills, Injections "
                //       "and Health habits. Med Reminder is an ad-free,easy-access,offline, "
                //       "pill reminder and medication tracker.Available on Apple and Android devices.",
                //   style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       height: 1,
                //       fontSize: 22,
                //       color: Colors.blueGrey),
                // ),
                Card(
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField( enabled:false,
                        maxLines: 23,
                        decoration: const InputDecoration.collapsed(
                            hintText: ""
                                "Pill Reminder - Pill Reminder is an easy-to-use and reliable app that helps "
                                "you remember to take your medications at the right time. It allows you to create "
                                "any type of recurring reminders.  "
                                "\n"
                                "\n"
                                "Re-Fill Reminder - It tracks the remaining quantity of each medication and shows "
                                "a refill alert when running low.It allows you to create any type of recurring reminders."
                                "\n"
                                "\n"
                                "Injection Reminder - It allows quick configuration of multiple medications "
                                "and multiple schedules."
                                "\n"
                                "\n"
                                "Health Habit -  It's a way to help you track how well you're sticking "
                                "with daily.It allows you to create any type of recurring reminders."
                                "\n"
                                "\n"
                                "Med Reminder is an ad-free,easy-access,offline, "
                                "pill reminder and medication tracker.Available on Apple and Android devices."
                                "",hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey)),
                      ),
                    )),
                const SizedBox(height: 5),
                const Text(
                  "Email - medReminder@gmail.com",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1,
                      fontSize: 18,
                      color: Colors.blueGrey),
                ),
                const Text(
                  "Phone - 011-2335522",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1,
                      fontSize: 18,
                      color: Colors.blueGrey),
                ),
                const Text(
                  "Address - No.7,Kandy Road,Kandy",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1,
                      fontSize: 18,
                      color: Colors.blueGrey),
                ),
                const Text(
                  "Fax - 011-255669988",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1,
                      fontSize: 18,
                      color: Colors.blueGrey),
                ),
                Container(
                  margin: const EdgeInsets.all(22),
                  child: ElevatedButton(
                    onPressed: () {

                      Navigator.of(context).pushNamed(Home.routeName);
                    },
                    child: const Text("Back To Home",
                        style: TextStyle(fontSize: 20.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}