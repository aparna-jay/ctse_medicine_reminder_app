import 'package:flutter/material.dart';

class  Home extends StatelessWidget {
  const  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width:double.infinity,
        ),
        ElevatedButton(onPressed: () {  }, child: Text('Pill Reminders'),
        ),
        SizedBox(height:30
        ),
        ElevatedButton(onPressed: () {  }, child: Text('Refill Reminders'),
        ),
        SizedBox(height:30
        ),
        ElevatedButton(onPressed: () {  }, child: Text('Health Habit Reminders'),
        ),
        SizedBox(height:30
        ),
        ElevatedButton(onPressed: () {  }, child: Text('Injection Reminders'),
        ),

      ],
    );
  }
}
