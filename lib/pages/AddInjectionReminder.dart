import 'package:ctse_medicine_reminder_app/pages/InjectionReminders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Sql_helper_pages/sql_helper_InjectionReminder.dart';
import 'package:form_field_validator/form_field_validator.dart';

//resources
//Form builder tutorial https://www.youtube.com/watch?v=7FBELQq808M
//https://github.com/syntacops/flutter_formbuilder_example/blob/master/lib/main.dart
//Alert dialog resource - https://medium.com/multiverse-software/alert-dialog-and-confirmation-dialog-in-flutter-8d8c160f4095

class  AddInjectionReminder extends StatefulWidget {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const String routeName = '/addInjectionReminder';
  final int reminderId;
  const AddInjectionReminder(this.reminderId);

  @override
  _AddInjectionReminderState createState() => _AddInjectionReminderState();
}

// AddInjectionReminder({Key? key, required this.id}) : super(key: key);
class _AddInjectionReminderState extends State<AddInjectionReminder> {
  late String formattedTime = DateFormat('kk:mm').format(DateTime.now());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  // final TextEditingController _repeatController = TextEditingController();
  // final TextEditingController _timeController = TextEditingController();

  String repeatValue = "false";
  List<Map<String, dynamic>> _injectionReminder = [];

  String title = "Add Injection Reminder";
  String btn_lbl = "Add Reminder";

  //Insert a new Injection reminder to the database
  Future<void> _addInjectionReminder() async {
    await SQLHelperInjectionReminder.createInjectionReminder(
        _nameController.text, _dosageController.text, _quantityController.text, repeatValue, formattedTime);
  }

  // Update an existing Injection Reminder
  Future<void> _updateInjectionReminder(int id) async {
    await SQLHelperInjectionReminder.updateInjectionReminder(
        id,  _nameController.text, _dosageController.text, _quantityController.text, repeatValue, formattedTime);
  }

// Read an Injection Reminder
  void _getInjectionReminders(int id) async {
    final data = await SQLHelperInjectionReminder.getInjectionReminder(id);
    setState(() {
      _injectionReminder = data;
      _nameController.text = data[0]['injectionName'];
      _dosageController.text = data[0]['dosage'];
      _quantityController.text = data[0]['quantity'];
      repeatValue = data[0]['repeat'];
      formattedTime  = data[0]['time'];
    });
  }

  //repeat value
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
      title = "Update Injection Reminder";
      btn_lbl = "Update Reminder";
      _getInjectionReminders(widget.reminderId);
    }
    // Get the injection reminder for update
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                TextFormField(
                  controller: _nameController,
                  validator: RequiredValidator(errorText: 'Enter a valid Injection Name'),
                  decoration: const InputDecoration(
                    border:OutlineInputBorder(
                        borderSide:BorderSide(color: Colors.limeAccent)
                    ),
                    labelText: ('Enter Injection Name'),
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
                      labelText: ('Enter Dosage (ml)')
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
                            await _addInjectionReminder();
                            //FlutterAlarmClock.createAlarm(3, 59);
                          }
                          Navigator.of(context).pushNamed(InjectionReminders.routeName);

                          if (widget.reminderId != 0) {

                            await _updateInjectionReminder(widget.reminderId);
                          }
                          // Navigator.of(context).pop();
                          Navigator.of(context).pushNamed(InjectionReminders.routeName);
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
