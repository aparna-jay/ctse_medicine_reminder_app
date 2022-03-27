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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  final TextEditingController _QuantityController = TextEditingController();
  late DateTime Date ;
  late DateTime Time ;

  void clear() {
    _nameController.clear();
    _doseController.clear();
    _QuantityController.clear();
  }

  void _click() {
    print(_nameController.text);
    print(_doseController.text);
    print(_QuantityController.text);
    print(Date);
    print(Time);
    clear();
  }

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
                controller: _nameController,
                decoration: const InputDecoration(
                  border:OutlineInputBorder(
                    borderSide:BorderSide(color: Colors.limeAccent)
                  ),
                  labelText: ('Name')
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _doseController,
                decoration: const InputDecoration(
                    border:OutlineInputBorder(
                        borderSide:BorderSide(color: Colors.limeAccent)
                    ),
                    labelText: ('Dose')
                ),
              ),
              const SizedBox(height:12),
              TextFormField(
                controller: _QuantityController,
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
                        SizedBox(
                          height: 100,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (DateTime newDateTime) {
                              Date = newDateTime;
                            },
                          ),
                      ),

                  SizedBox(
                    height: 100,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (DateTime newDateTime) {
                        Time = newDateTime;
                      },
                    ),
                  ),
              Container(
                margin: const EdgeInsets.all(25),
                child: OutlinedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        _click();
                      }
                    },
                    child: const Text("Add Reminder",
                        // style: TextStyle(fontSizb -e: 20.0)
                    ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


