import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefillReminder extends StatefulWidget {
  static const String routeName = '/RefillReminder';
  const RefillReminder({Key? key}) : super(key: key);

  @override
  State<RefillReminder> createState() => _RefillReminderState();
}

class _RefillReminderState extends State<RefillReminder> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ReFill Reminder"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  border:OutlineInputBorder(
                    borderSide:BorderSide(color: Colors.limeAccent)
                  ),
                  labelText: ('Name')
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                    border:OutlineInputBorder(
                        borderSide:BorderSide(color: Colors.limeAccent)
                    ),
                    labelText: ('Dose')
                ),
              ),
              const SizedBox(height:12),
              TextFormField(
                decoration: const InputDecoration(
                    border:OutlineInputBorder(
                        borderSide:BorderSide(color: Colors.limeAccent)
                    ),
                    labelText: ('Total Quantity')
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(25),
                  child: const Text("TODAY DATE AND TIME")),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (DateTime newDateTime) {
                              // Date = newDateTime;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child:
                  SizedBox(
                    height: 100,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (DateTime newDateTime) {
                        // Date = newDateTime;
                      },
                    ),
              ),
                      ),
                    ],
                  ),
              Container(
                margin: const EdgeInsets.all(25),
                child: OutlinedButton(
                    onPressed: (){},
                    child: const Text("Add Reminder",style: TextStyle(fontSize: 20.0)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


