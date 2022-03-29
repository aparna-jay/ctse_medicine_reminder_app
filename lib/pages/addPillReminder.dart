import 'package:ctse_medicine_reminder_app/pages/pillReminders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import 'Sql_helper_pages/sql_helper_pillReminder.dart';

class AddPillReminder extends StatefulWidget {
  static const String routeName = '/addPillReminder';
  const AddPillReminder({Key? key}) : super(key: key);

  @override
  _AddPillReminderState createState() => _AddPillReminderState();
}

//Form builder tutorial https://www.youtube.com/watch?v=7FBELQq808M
//https://github.com/syntacops/flutter_formbuilder_example/blob/master/lib/main.dart


class _AddPillReminderState extends State<AddPillReminder> {
  final _formKey = GlobalKey<FormBuilderState>();
  late String formattedTime = DateFormat('kk:mm').format(DateTime.now());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  //Insert a new pill reminder to the database
  Future<void> _addPillReminder() async {
    await SQLHelperPillReminder.createPillReminder(
        _nameController.text, _dosageController.text, _quantityController.text, _repeatController.text, _timeController.text);
    //_refreshPillReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Pill Reminder")),
      body: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:<Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Enter Pill Name"),
            SizedBox(
              height: 50,
              width: 300,
              child:TextFormField(
                controller: _nameController,
              ),
            )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Enter Dosage"),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child:TextFormField(
                      controller: _dosageController,
                    ),
                  )
                ],

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Quantity"),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child:TextFormField(
                      controller: _quantityController,
                    ),
                  )

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Repeat"),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child:TextFormField(
                      controller: _repeatController,
                    ),
                  )

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Time"),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child:TextFormField(
                      controller: _timeController,
                    ),
                  )

                ],
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Repeat"),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: FormBuilderDropdown(
                                    name: 'dropdown',
                                    items: ['Hourly', 'Daily', 'Weekly']
                                        .map((repeat) =>
                                            DropdownMenuItem(value: repeat, child: Text("$repeat")))
                                        .toList(),
                                  ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Time"),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (DateTime newDateTime) {
                        formattedTime = DateFormat('kk:mm').format(newDateTime);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    // Save new pill reminder

                    await _addPillReminder();
                    Navigator.of(context).pushNamed(PillReminders.routeName);
                    // onPressed:(){
                  //   if(_formKey.currentState!.saveAndValidate()){
                  //     print(_formKey.currentState!.value);
                  //   }

                  },
                ),
                ElevatedButton(
                  child: Text('Reset'),
                  onPressed:() {
                    _formKey.currentState!.reset();
                  }
                ),
              ],)
            ]
          ),
        )
      ),
    );
  }
}
