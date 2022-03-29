import 'package:flutter/material.dart';

class FeedbackForm extends StatelessWidget {
  static const String routeName = '/feedback ';
  const FeedbackForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback" ),
      ),
      body:Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children:const [
            Text("Add your feedback" , style: TextStyle(fontWeight: FontWeight.bold, height: 5, fontSize: 20),),
            TextField(
              // controller: _nameController,
              decoration: InputDecoration(
                  border:OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.limeAccent)
                  ),
                  labelText: ('Your Email address')
              ),
            ),
            const SizedBox(height: 12),
            Card(
                color: Colors.white70,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 8,
                    decoration: InputDecoration.collapsed(hintText: "Enter your text here"),
                  ),
                )
            )
          ],
        ),
      ),

    );
  }
}
