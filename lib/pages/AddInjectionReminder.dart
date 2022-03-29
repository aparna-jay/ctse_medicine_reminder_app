import 'package:ctse_medicine_reminder_app/pages/InjectionReminders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'Sql_helper_pages/sql_helper_InjectionReminder.dart';

class  AddInjectionReminder extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const String routeName = '/addInjectionReminder';
  AddInjectionReminder({Key? key, required this.id}) : super(key: key);

  static late String formattedTime = DateFormat('kk:mm').format(DateTime.now());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final String id;
  //Insert a new Injection reminder to the database
  Future<void> _addInjectionReminder()async{
    await SQLHelperInjectionReminder.createInjectionReminder(
      _nameController.text,
      _dosageController.text,
        _quantityController.text,
        _repeatController.text, _timeController.text);
  }


  @override
  Widget build(BuildContext context) {
    // String? _Injectionname;
    // int _Dosage;
    // int _Quantity;
    // String? _Repeat;
    // DateTime _Time;

    //widget function for Injection Name
    Widget _buildInjectionNameField(){
      return TextFormField(
        maxLength: 20,
        maxLines: 1,
        controller: _nameController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Injection Name',
            hintText: 'Enter Injection Name',
            labelStyle: TextStyle(
                color: Colors.black87,
                fontSize: 18,
              fontWeight: FontWeight.bold,
                )),
        validator: (InjectionName){
          if(InjectionName!.isEmpty){
            return 'Injection Name can not be empty';
          }
          return null;
        },
      );
    }

    Widget _buildDosageField() {
      return TextFormField(
        maxLength: 10,
        keyboardType: TextInputType.number,
        controller: _dosageController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Dosage',
            labelStyle: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            hintText: 'Enter Dosage (mg)'
        ),
        validator: (text) {
          if (text!.isEmpty) {
            return "Please enter a valid Dosage";
          }
          return null;
        },
        // onSaved: (value) {
        //   _Dosage = int.parse(value!);
        // },
      );
    }

    //widget function for Injection Dosage
    Widget _buildQuantityField(){
      return TextFormField(
        maxLength: 2,
        keyboardType: TextInputType.number,
        controller: _quantityController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Quantity',
          labelStyle: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
            hintText: 'Enter Quantity',
        ),
        validator: (text) {
          if (text!.isEmpty) {
            return "Please enter a valid Quantity";
          }
          return null;
        },
        // onSaved: (value) {
        //   _Quantity = int.parse(value!);
        // },
      );
    }

    // //widget function for Repeat
    // Widget _buildRepeatField() {
    //   return TextFormField(
    //     decoration: InputDecoration(
    //         border: OutlineInputBorder(),
    //         labelText: 'Repeat',
    //         hintText: 'Select from the drop down',
    //         labelStyle: TextStyle(
    //           color: Colors.black87,
    //           fontSize: 18,
    //           fontWeight: FontWeight.bold,
    //         ),
    //     ),
    //     validator: (text) {
    //       if (text!.isEmpty) {
    //         return "Please select a value";
    //       }
    //       return null;
    //     },
    //     onSaved: (value) {
    //       _Repeat = value;
    //     },
    //   );
    // }

    // //widget function for Time
    // Widget _buildTimeField() {
    //   return TextFormField(
    //     keyboardType: TextInputType.datetime,
    //     decoration: InputDecoration(
    //         border: OutlineInputBorder(),
    //         labelText: 'Time',
    //         hintText: 'Select time'
    //     ),
    //     validator: (text) {
    //       if (text!.isEmpty) {
    //         return "Please enter a valid Dosage";
    //       }
    //       return null;
    //     },
    //     onSaved: (value) {
    //       _Time = value as DateTime;
    //     },
    //   );
    // }



    return Scaffold(
        appBar: AppBar(
          title: const Text("New Injection Reminder"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              margin: const EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  //text field functions
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: _buildInjectionNameField(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: _buildDosageField(),
                  ),Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: _buildQuantityField(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Repeat", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                  // Padding(
                  //   padding: const EdgeInsets.all(4.0),
                  //   child: _buildRepeatField(),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(4.0),
                  //   child:  _buildTimeField(),
                  // ),

            Padding(
              padding: const EdgeInsets.all(24.0),
            ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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

                  const SizedBox(
                    height: 80,
                    width: 200,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                  ElevatedButton(onPressed: () async{
                      await _addInjectionReminder();
                      Navigator.of(context).pushNamed(InjectionReminders.routeName);
                    // Navigator.of(context).pushNamed(AddInjectionReminder.routeName);
                    // if(_formKey.currentState!.validate()){
                    //   _formKey.currentState?.save();
                    //   print('Injectionname');

                  },
                    child: const Text('Save'),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(120, 50),
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        ),
                      textStyle: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                      )
                    ),
                  ),
                  ElevatedButton(
                      onPressed:() {
                        _formKey.currentState!.reset();
                      },
                    child: const Text('Reset'),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(120, 50),
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        textStyle: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                        )
                    ),
                  ),]),
                  // Container(color: Colors.amber, height: 300),
                  // Container(color: Colors.red, height: 300),
                  // Container(color: Colors.blueAccent, height: 300),
                ],
              ),
              // children: [
              //   const Padding(
              //     padding: EdgeInsets.all(20.0),
              //     child: TextField(
              //       maxLength: 20,
              //       autofocus: true,
              //       autocorrect: true,
              //       keyboardType: TextInputType.text,
              //       style: TextStyle(fontSize: 21.0),
              //     ),
              //   ),
              //   const Padding(
              //     padding: EdgeInsets.all(20.0),
              //     child: TextField(
              //       keyboardType: TextInputType.number,
              //       style: TextStyle(fontSize: 21.0),
              //     ),
              //   ),
              //   const SizedBox(width:double.infinity,
              //   ),
              //   ElevatedButton(onPressed: () {
              //     Navigator.of(context).pushNamed(InjectionReminders.routeName);
              //   }, child: const Text('Add Reminder +'),
              //   ),
              // ],
            ),
          ),
        ),

    );
  }
  // Update an existing list item
  Future<void> _updateInjectionReminder(int id) async {
    await SQLHelperInjectionReminder.updateInjectionReminder(
      id,
      _nameController.text,
      _dosageController.text,
        _quantityController.text,
        _repeatController.text,
        _timeController.text
    );
    _repeatController;
  }
}
