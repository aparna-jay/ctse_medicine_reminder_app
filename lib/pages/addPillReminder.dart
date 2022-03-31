import 'package:ctse_medicine_reminder_app/pages/pillReminders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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


class _AddPillReminderState extends State<AddPillReminder> {
  late String formattedTime = DateFormat('kk:mm').format(DateTime.now());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  bool? repeat = false;
  String repeatValue = "false";
  List<Map<String, dynamic>> _pillReminder = [];

  //Insert a new pill reminder to the database
  Future<void> _addPillReminder() async {
    await SQLHelperPillReminder.createPillReminder(
        _nameController.text, _dosageController.text, _quantityController.text, repeatValue, formattedTime);
    //_refreshPillReminders();
  }

  // Update an existing pill reminder
  Future<void> _updatePillReminder(int id) async {
    await SQLHelperPillReminder.updatePillReminder(
        id,  _nameController.text, _dosageController.text, _quantityController.text, repeatValue, formattedTime);
  }

  void _getPillReminder(int id) async {
    final data = await SQLHelperPillReminder.getPillReminder(id);
    setState(() {
      _pillReminder = data;
      print(_pillReminder);
      //_nameController.text =  _pillReminder['name'];
      //_dosageController.text, _quantityController.text, repeatValue, formattedTime
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.reminderId != 0) {
      _getPillReminder(widget.reminderId);
    } // Get the pill reminder for update
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Pill Reminder")),
      body:  SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children:<Widget>[
                const Text("Add Pill Reminder" , style: TextStyle(fontWeight: FontWeight.bold, height: 3, fontSize: 25),),
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
                      labelText: ('Enter Dosage')
                  ),
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
                      // Save new pill reminder
                      if (widget.reminderId == 0) {
                        await _addPillReminder();
                      }
                      Navigator.of(context).pushNamed(PillReminders.routeName);

                      if (widget.reminderId != 0) {

                        await _updatePillReminder(widget.reminderId);
                      }
                      // Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(PillReminders.routeName);
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
