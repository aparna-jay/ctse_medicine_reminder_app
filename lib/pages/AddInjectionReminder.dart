import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class  AddInjectionReminder extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const String routeName = '/newInjectionReminder';
  AddInjectionReminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? _Injectionname;
    int _Dosage;
    int _Quantity;
    String? _Repeat;
    DateTime _Time;

    //widget function for Injection Name
    Widget _buildInjectionNameField(){
      return TextFormField(
        maxLength: 20,
        maxLines: 1,
        decoration: InputDecoration(labelText: 'Injection Name', hintText: 'Enter Injection Name'),
        validator: (InjectionName){
          if(InjectionName!.isEmpty){
            return 'Injection Name can not be empty';
          }
          return null;
        },
        onSaved: (value) {
          _Injectionname = value;
        },
      );
    }

    Widget _buildDosageField() {
      return TextFormField(
        maxLength: 10,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: 'Dosage', hintText: 'Enter Dosage (mg)'
        ),
        validator: (text) {
          if (text!.isEmpty) {
            return "Please enter a valid Dosage";
          }
          return null;
        },
        onSaved: (value) {
          _Dosage = int.parse(value!);
        },
      );
    }

    //widget function for Injection Dosage
    Widget _buildQuantityField(){
      return TextFormField(
        maxLength: 2,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: 'Quantity', hintText: 'Enter Quantity'
        ),
        validator: (text) {
          if (text!.isEmpty) {
            return "Please enter a valid Quantity";
          }
          return null;
        },
        onSaved: (value) {
          _Quantity = int.parse(value!);
        },
      );
    }

    //widget function for Repeat
    Widget _buildRepeatField() {
      return TextFormField(
        decoration: InputDecoration(
            labelText: 'Repeat', hintText: 'Select from the drop down'
        ),
        validator: (text) {
          if (text!.isEmpty) {
            return "Please select a value";
          }
          return null;
        },
        onSaved: (value) {
          _Repeat = value;
        },
      );
    }

    //widget function for Time
    Widget _buildTimeField() {
      return TextFormField(
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
            labelText: 'Time', hintText: 'Select time'
        ),
        validator: (text) {
          if (text!.isEmpty) {
            return "Please enter a valid Dosage";
          }
          return null;
        },
        onSaved: (value) {
          _Time = value as DateTime;
        },
      );
    }



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
                    padding: const EdgeInsets.all(4.0),
                    child: _buildInjectionNameField(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: _buildDosageField(),
                  ),Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: _buildQuantityField(),
                  ),Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: _buildRepeatField(),
                  ),Padding(
                    padding: const EdgeInsets.all(4.0),
                    child:  _buildTimeField(),
                  ),

                  const SizedBox(
                    height: 170,
                    width: 200,
                  ),
                  ElevatedButton(onPressed: () {
                    // Navigator.of(context).pushNamed(AddInjectionReminder.routeName);
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState?.save();
                      print('Injectionname');
                    }

                  },
                    child: const Text('Save'),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(120, 60),
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        ),
                      textStyle: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                      )
                    ),
                  )
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
}
