import 'package:ctse_medicine_reminder_app/pages/pillReminders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'Sql_helper_pages/sql_helper_pillReminder.dart';

class AddPillReminder extends StatefulWidget {
  static const String routeName = '/addPillReminder';
  final int reminderId;
  const AddPillReminder(this.reminderId);

  @override
  _AddPillReminderState createState() => _AddPillReminderState();
}

//Form builder tutorial https://www.youtube.com/watch?v=7FBELQq808M
//https://github.com/syntacops/flutter_formbuilder_example/blob/master/lib/main.dart
//Alert dialog resource - https://medium.com/multiverse-software/alert-dialog-and-confirmation-dialog-in-flutter-8d8c160f4095


class _AddPillReminderState extends State<AddPillReminder> {

  late String formattedTime = DateFormat('kk:mm').format(DateTime.now());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  String repeatValue = "false";
  List<Map<String, dynamic>> _pillReminder = [];

  String title = "Add Pill Reminder";
  String btn_lbl = "Add Reminder";

  //Insert a new pill reminder to the database
  Future<void> _addPillReminder() async {
    await SQLHelperPillReminder.createPillReminder(
        _nameController.text, _dosageController.text, _quantityController.text, repeatValue, formattedTime);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully added a pill reminder!'),
    ));
  }

  // Update an existing pill reminder
  Future<void> _updatePillReminder(int id) async {
    await SQLHelperPillReminder.updatePillReminder(
        id,  _nameController.text, _dosageController.text, _quantityController.text, repeatValue, formattedTime);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully updated pill reminder!'),
    ));
  }

  void _getPillReminder(int id) async {
    final data = await SQLHelperPillReminder.getPillReminder(id);
    setState(() {
      _pillReminder = data;
      _nameController.text = data[0]['name'];
      _dosageController.text = data[0]['dosage'];
      _quantityController.text = data[0]['quantity'];
      repeatValue = data[0]['repeat'];
      formattedTime  = data[0]['time'];
    });
  }

  bool? _getRepeatValue(String value){
    if(value == 'true'){
      return true;
    }
    else if(value == 'false'){
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.reminderId != 0) {
      title = "Update Pill Reminder";
      btn_lbl = "Update";
      _getPillReminder(widget.reminderId);
    }
  // Get the pill reminder for update
  }

  @override
  Widget build(BuildContext context) {
    String backNavEnabled = "true";
    return WillPopScope(
      onWillPop: () async {
        if(backNavEnabled == "true"){
          Navigator.of(context).pushNamed(PillReminders.routeName);
          return true;
        }
        else {
          return false;
        }

      },
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                children:<Widget>[
                  Text(title , style: TextStyle(fontWeight: FontWeight.bold, height: 3, fontSize: 25),),
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
                  TextField(
                    controller: _dosageController,
                    decoration: const InputDecoration(
                        border:OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.limeAccent)
                        ),
                        labelText: ('Enter Dosage (mg)')
                    ),
                      keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                        border:OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.limeAccent)
                        ),
                        labelText: ('Quantity')
                    ),
                      keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 65,
                        width: MediaQuery.of(context).size.width - 32,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          minimumDate:  DateTime.now(),
                          initialDateTime:  DateTime.now(),
                          onDateTimeChanged: (DateTime newDateTime) {
                            formattedTime = DateFormat('kk:mm').format(newDateTime);
                          },
                          // dateTimePickerTextStyle: TextStyle(
                          //   fontSize: 16,
                          // ),
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
                          value: _getRepeatValue(repeatValue),
                          onChanged: (bool? value){
                            setState(() {
                              repeatValue = value.toString();
                            });
                          }),
                      Text("Repeat Daily"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    ElevatedButton(
                      child:  Text(btn_lbl, style: TextStyle(fontSize: 18)),
                      onPressed: () async {
                        // Save new pill reminder
                        if (widget.reminderId == 0) {
                          await _addPillReminder();
                          //FlutterAlarmClock.createAlarm(3, 59);
                        }
                        Navigator.of(context).pushNamed(PillReminders.routeName);

                        if (widget.reminderId != 0) {

                          await _updatePillReminder(widget.reminderId);
                        }
                        Navigator.of(context).pushNamed(PillReminders.routeName);
                        },
                    ),
                ]
              ),
              ]
            ),
            ),
        ),
      ),
    );
  }
}
