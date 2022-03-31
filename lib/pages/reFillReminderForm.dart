import 'package:ctse_medicine_reminder_app/pages/reFillReminder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Sql_helper_pages/SQL_helper_ReFillReminder.dart';

class RefillReminderForm extends StatelessWidget {
  static const String routeName = '/RefillReminderForm ';
  const RefillReminderForm({Key? key, required this.id}) : super(key: key);
  final String id;

  static final TextEditingController _nameController = TextEditingController();
  static final TextEditingController _doseController = TextEditingController();
  static final TextEditingController _QuantityController = TextEditingController();
  static late String formattedDate =  DateFormat('yyyy-MM-dd' ).format(DateTime.now());
  static late String formattedTime = DateFormat('kk:mm').format(DateTime.now());

  static List<Map<String, dynamic  >> RefillReminderList = [];
  static bool isLoading = true;
  // fetch all data from the database
  static void _refreshList() async {
    final data = await SQL_helper_ReFillReminder.getItems();
    // setState(() {
      RefillReminderList = data;
      isLoading = false;
    // });
  }

  static void _showForm(String? id) async {
    late int id_Update  = int.parse(id!);
    if (id != null) {
      final refillList =
      RefillReminderList.firstWhere((element) => element['id'] == id_Update);
      _nameController.text = refillList['name'];
      _doseController.text = refillList['dose'];
      _QuantityController.text = refillList['quantity'];
    }
  }

  static void clearForm() async {
    _nameController.text = '';
    _doseController.text = '';
    _QuantityController.text = '';
  }

  static void initState(String? id) {
    _showForm(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refill Reminder Form"),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      border:OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.limeAccent)
                      ),
                      labelText: ('name')
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _doseController,
                  keyboardType: TextInputType.number,
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
                  keyboardType: TextInputType.number,
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
                      formattedDate = DateFormat('yyyy-MM-dd ').format(newDateTime);
                    },
                  ),
                ),

                SizedBox(
                  height: 100,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (DateTime newDateTime) {
                      formattedTime = DateFormat('kk:mm').format(newDateTime);
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(25),
                  child: OutlinedButton(
                    onPressed: ()async {
                      // if (_formKey.currentState!.validate()) {
                       if (this.id == "0") {
                        await _addItem();
                        clearForm();
                       }
                      if (this.id != null) {
                        late int idupdate  = int.parse(id);
                        await _updateItem(idupdate);
                        clearForm();
                      }
                      // Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(RefillReminder.routeName);
                    },
                    child:
                    const Text("Add Reminder",
                      // style: TextStyle(fontSizb -e: 20.0)
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ));
  }
  Future<void> _addItem() async {
    await SQL_helper_ReFillReminder.createItem(
      _nameController.text,
      _doseController.text,
      _QuantityController.text,
      formattedDate,
      formattedTime,
    );
    _refreshList();
  }

  // Update an existing list item
  Future<void> _updateItem(int id) async {
    await SQL_helper_ReFillReminder.updateItem(
      id,
      _nameController.text,
      _doseController.text,
      _QuantityController.text,
      formattedDate,
      formattedTime,
    );
    _refreshList();
  }
}

