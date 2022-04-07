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
        title: const Text("About Us"),
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
                      fontSize: 27,
                      color: Colors.blue),
                ),
                const Text(
                  "Email - medReminder@gmail.com",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1,
                      fontSize: 20,
                      color: Colors.grey),
                ),
                const Text(
                  "Phone - 011-2335522",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1,
                      fontSize: 20,
                      color: Colors.grey),
                ),
                const Text(
                  "Address - No.7,Kandy Road,Kandy",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1,
                      fontSize: 20,
                      color: Colors.grey),
                ),
                const Text(
                  "Fax - 011-255669988",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1,
                      fontSize: 20,
                      color: Colors.grey),
                ),



                Container(
                  margin: const EdgeInsets.all(25),
                  child: OutlinedButton(
                    onPressed: () {

                      Navigator.of(context).pushNamed(Home.routeName);
                    },
                    child: const Text("Thank You",
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