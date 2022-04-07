import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'home.dart';

class FeedbackForm extends StatelessWidget {
  static const String routeName = '/feedback ';

  static final TextEditingController _nameController = TextEditingController();
  static final TextEditingController _feedController = TextEditingController();

  static void clear() {
    _nameController.text = '';
    _feedController.text = '';
  }

  const FeedbackForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Add your feedback",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 2,
                      fontSize: 30,
                      // color: Colors.blue
                  ),
                ),
                const SizedBox(height: 35),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.limeAccent)),
                      labelText: ('Your Email address')),
                ),
                const SizedBox(height: 10),
                Card(
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _feedController,
                        maxLines: 8,
                        decoration: const InputDecoration.collapsed(
                            hintText: "Enter your text here"),
                      ),
                    )),
                const SizedBox(height: 10),
                RatingBar.builder(
                  minRating: 1,
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amberAccent),
                  onRatingUpdate: (double value) {},
                ),
                Container(
                  margin: const EdgeInsets.all(25),
                  child: ElevatedButton(
                    onPressed: () {
                      clear();
                      Navigator.of(context).pushNamed(Home.routeName);
                    },
                    child: const Text("Add FeedBack",
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
