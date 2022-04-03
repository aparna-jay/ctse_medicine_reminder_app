import 'package:ctse_medicine_reminder_app/pages/healthHabitReminders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'Sql_helper_pages/sql_helper_healthHabitReminder.dart';

class AddHealthHabitReminder extends StatefulWidget {
  static const String routeName = '/addHealthHabitReminder';
  final int reminderId;
  const AddHealthHabitReminder(this.reminderId);

  @override
  _AddHealthHabitReminderState createState() => _AddHealthHabitReminderState();
}

//Form builder tutorial https://www.youtube.com/watch?v=7FBELQq808M
//https://github.com/syntacops/flutter_formbuilder_example/blob/master/lib/main.dart


class _AddHealthHabitReminderState extends State<AddHealthHabitReminder> {
  late String formattedTime = DateFormat('kk:mm').format(DateTime.now());
final TextEditingController _nameController = TextEditingController();
bool? repeat = false;
String repeatValue = "false";
List<Map<String, dynamic>> _healthHabitReminder = [];

//Insert a new HealthHabit reminder to the database
Future<void> _addHealthHabitReminder() async {
  await SQLHelperHealthHabitReminder.createhealthHabitReminder(
      _nameController.text, repeatValue);
  //_refreshHealthHabitReminders();
}

// Update an existing pill reminder
Future<void> _updateHealthHabitReminder(int id) async {
  await SQLHelperHealthHabitReminder.updatehealthHabitReminder(
      id,  _nameController.text, formattedTime);
}

void _getHealthHabitReminder(int id) async {
  final data = await SQLHelperHealthHabitReminder.gethealthHabitReminder(id);
  setState(() {
    _healthHabitReminder = data;
    print(_healthHabitReminder);
    //_nameController.text =  _healthHabitReminder['name'];
    //_dosageController.text, repeatValue, formattedTime
  });
}

@override
void initState() {
  super.initState();
  if (widget.reminderId != 0) {
    _getHealthHabitReminder(widget.reminderId);
  } // Get the HealthHabit reminder for update
}


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text("Add Health Habit Reminder")),
    body:  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            children:<Widget>[
              const Text("Add Health Habit Reminder" , style: TextStyle(fontWeight: FontWeight.bold, height: 3, fontSize: 25),),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                    border:OutlineInputBorder(
                        borderSide:BorderSide(color: Colors.limeAccent)
                    ),
                    labelText: ('Enter Pill Name')
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width - 32,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      minimumDate:  DateTime.now(),
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (DateTime newDateTime) {
                        formattedTime = DateFormat('kk:mm').format(newDateTime);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Checkbox(
                      value: repeat,
                      onChanged: (bool? value){
                        setState(() {
                          repeat = value;
                          repeatValue = repeat.toString();
                        });
                      }),
                  Text("Repeat Daily"),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      child: const Text('Submit', style: TextStyle(fontSize: 18)),
                      onPressed: () async {
                        // Save new HealthHabit reminder
                        if (widget.reminderId == 0) {
                          await _addHealthHabitReminder();
                        }
                        Navigator.of(context).pushNamed(HealthHabitReminders.routeName);

                        if (widget.reminderId != 0) {

                          await _updateHealthHabitReminder(widget.reminderId);
                        }
                        // Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(HealthHabitReminders.routeName);
                      },
                    ),
                  ]
              ),
            ]
        ),
      ),
    ),
  );
}
}