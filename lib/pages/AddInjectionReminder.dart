import 'package:ctse_medicine_reminder_app/pages/InjectionReminders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'Sql_helper_pages/sql_helper_InjectionReminder.dart';
import 'package:form_field_validator/form_field_validator.dart';

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
//   @override
//   Widget build(BuildContext context) {
//
//     //widget function for Injection Name
//     Widget _buildInjectionNameField(){
//       return TextFormField(
//         maxLength: 20,
//         maxLines: 1,
//         controller: _nameController,
//         decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             labelText: 'Injection Name',
//             hintText: 'Enter Injection Name',
//             labelStyle: TextStyle(
//                 // color: Colors.black87,
//                 fontSize: 18,
//                 )),
//         validator: (InjectionName){
//           if(InjectionName!.isEmpty){
//             return 'Injection Name can not be empty';
//           }
//           return null;
//         },
//       );
//     }
//
//     Widget _buildDosageField() {
//       return TextFormField(
//         maxLength: 10,
//         keyboardType: TextInputType.number,
//         controller: _dosageController,
//         decoration: const InputDecoration(
//             border: OutlineInputBorder(),
//             labelText: 'Dosage',
//             labelStyle: TextStyle(
//               // color: Colors.black87,
//               fontSize: 18,
//               // fontWeight: FontWeight.bold,
//             ),
//             hintText: 'Enter Dosage (mg)'
//         ),
//         validator: (text) {
//           if (text!.isEmpty) {
//             return "Please enter a valid Dosage";
//           }
//           return null;
//         },
//         // onSaved: (value) {
//         //   _Dosage = int.parse(value!);
//         // },
//       );
//     }
//
//     //widget function for Injection Dosage
//     Widget _buildQuantityField(){
//       return TextFormField(
//         maxLength: 2,
//         keyboardType: TextInputType.number,
//         controller: _quantityController,
//         decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             labelText: 'Quantity',
//           labelStyle: TextStyle(
//             // color: Colors.black87,
//             fontSize: 18,
//             // fontWeight: FontWeight.bold,
//           ),
//             hintText: 'Enter Quantity',
//         ),
//         validator: (text) {
//           if (text!.isEmpty) {
//             return "Please enter a valid Quantity";
//           }
//           return null;
//         },
//         // onSaved: (value) {
//         //   _Quantity = int.parse(value!);
//         // },
//       );
//     }
//
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("New Injection Reminder"),
//         ),
//         body: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Container(
//               // mainAxisAlignment: MainAxisAlignment.center,
//               // crossAxisAlignment: CrossAxisAlignment.center,
//               margin: const EdgeInsets.all(24.0),
//               child: Column(
//                 children: <Widget>[
//                   //text field functions
//                   Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: _buildInjectionNameField(),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: _buildDosageField(),
//                   ),Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: _buildQuantityField(),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     children: [
//                       Checkbox(
//                           value: _getRepeatValue(repeatValue),
//                           onChanged: (bool? value){
//                             setState(() {
//                               repeatValue = value.toString();
//                             });
//                           }),
//                       Text("Repeat Daily"),
//                     ],
//                   ),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   //   children: [
//                   //     // Text("Repeat", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                   //     SizedBox(
//                   //       height: 50,
//                   //       width: 300,
//                   //       child: FormBuilderDropdown(
//                   //         name: 'dropdown',
//                   //         items: ['Hourly', 'Daily', 'Weekly']
//                   //             .map((repeat) =>
//                   //             DropdownMenuItem(value: repeat, child: Text("$repeat")))
//                   //             .toList(),
//                   //       ),
//                   //
//                   //     ),
//                   //
//                   //   ],
//                   // ),
//                   // Padding(
//                   //   padding: const EdgeInsets.all(4.0),
//                   //   child: _buildRepeatField(),
//                   // ),
//                   // Padding(
//                   //   padding: const EdgeInsets.all(4.0),
//                   //   child:  _buildTimeField(),
//                   // ),
//
//             Padding(
//               padding: const EdgeInsets.all(24.0),
//             ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       // Text("Time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                       SizedBox(
//                         height: 50,
//                         width: 300,
//                         child: CupertinoDatePicker(
//                           mode: CupertinoDatePickerMode.time,
//                           initialDateTime: DateTime.now(),
//                           onDateTimeChanged: (DateTime newDateTime) {
//                             formattedTime = DateFormat('kk:mm').format(newDateTime);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(
//                     height: 80,
//                     width: 200,
//                   ),
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                   ElevatedButton(onPressed: () async{
//                       await _addInjectionReminder();
//                       Navigator.of(context).pushNamed(InjectionReminders.routeName);
//                     // Navigator.of(context).pushNamed(AddInjectionReminder.routeName);
//                     // if(_formKey.currentState!.validate()){
//                     //   _formKey.currentState?.save();
//                     //   print('Injectionname');
//
//                   },
//                     child: const Text('Save'),
//                     style: ElevatedButton.styleFrom(
//                         fixedSize: const Size(120, 50),
//                         primary: Colors.blue,
//                         shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(40),
//                         ),
//                       textStyle: const TextStyle(
//                         fontStyle: FontStyle.normal,
//                         fontSize: 20,
//                       )
//                     ),
//                   ),
//                   // ElevatedButton(
//                   //     onPressed:() {
//                   //       _formKey.currentState!.reset();
//                   //     },
//                   //   child: const Text('Reset'),
//                   //   style: ElevatedButton.styleFrom(
//                   //       fixedSize: const Size(120, 50),
//                   //       primary: Colors.blue,
//                   //       shape: RoundedRectangleBorder(
//                   //         borderRadius: BorderRadius.circular(40),
//                   //       ),
//                   //       textStyle: const TextStyle(
//                   //         fontStyle: FontStyle.normal,
//                   //         fontSize: 20,
//                   //       )
//                   //   ),
//                   // ),
//                       ]),
//                   // Container(color: Colors.amber, height: 300),
//                   // Container(color: Colors.red, height: 300),
//                   // Container(color: Colors.blueAccent, height: 300),
//                 ],
//               ),
//               // children: [
//               //   const Padding(
//               //     padding: EdgeInsets.all(20.0),
//               //     child: TextField(
//               //       maxLength: 20,
//               //       autofocus: true,
//               //       autocorrect: true,
//               //       keyboardType: TextInputType.text,
//               //       style: TextStyle(fontSize: 21.0),
//               //     ),
//               //   ),
//               //   const Padding(
//               //     padding: EdgeInsets.all(20.0),
//               //     child: TextField(
//               //       keyboardType: TextInputType.number,
//               //       style: TextStyle(fontSize: 21.0),
//               //     ),
//               //   ),
//               //   const SizedBox(width:double.infinity,
//               //   ),
//               //   ElevatedButton(onPressed: () {
//               //     Navigator.of(context).pushNamed(InjectionReminders.routeName);
//               //   }, child: const Text('Add Reminder +'),
//               //   ),
//               // ],
//             ),
//           ),
//         ),
//
//     );
//   }
//   // Update an existing list item
//   Future<void> _updateInjectionReminder(int id) async {
//     await SQLHelperInjectionReminder.updateInjectionReminder(
//       id,
//       _nameController.text,
//       _dosageController.text,
//         _quantityController.text,
//         _repeatController.text,
//         _timeController.text
//     );
//     _repeatController;
//   }
}
