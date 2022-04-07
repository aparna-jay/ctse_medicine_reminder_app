import 'package:ctse_medicine_reminder_app/pages/reFillReminder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Sql_helper_pages/SQL_helper_ReFillReminder.dart';

class RefillReminderForm extends StatefulWidget {
  static const String routeName = '/RefillReminderForm ';
  const RefillReminderForm({Key? key, required this.id}) : super(key: key);
  final String id;



  @override
  State<RefillReminderForm> createState() => _RefillReminderFormState();
}

class _RefillReminderFormState extends State<RefillReminderForm> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  final TextEditingController _QuantityController = TextEditingController();
  late String formattedDate =  DateFormat('yyyy-MM-dd' ).format(DateTime.now());
  late String formattedTime = DateFormat('HH:mm').format(DateTime.now());

  String title = "Add Refill Reminder";
  String btn_lbl = "Add Reminder";

  List<Map<String, dynamic  >> _RefillReminderList = [];
  bool isLoading = true;
  // fetch all data from the database
  void _refreshList() async {
    final data = await SQL_helper_ReFillReminder.getItems();
    setState(() {
    _RefillReminderList = data;
    isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    _refreshList();
    showForm();
    if (widget.id != '0') {
      title = "Update Refill Reminder";
      btn_lbl = "Update";
    }// Loading the data when the app starts
  }
  void clearForm() async {
    _nameController.text = '';
    _doseController.text = '';
    _QuantityController.text = '';
  }
  void showForm() async {
    late int id_Update  = int.parse(this.widget.id);
    final data = await SQL_helper_ReFillReminder.getItem(id_Update);
    if (id_Update != null) {
      print(id_Update);
      final refillList =
      _RefillReminderList.firstWhere((data) => data['id'] == id_Update);
      _nameController.text = refillList['name'];
      _doseController.text = refillList['dose'];
      _QuantityController.text = refillList['quantity'];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                const Text(
                  "Add Refill Reminder",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 2,
                      fontSize: 25,
                      // color: Colors.blue
                  ),
                ),
                const SizedBox(height: 35),

                TextFormField(
                  controller:_nameController,
                  decoration: const InputDecoration(
                      border:OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.limeAccent)
                      ),
                      labelText: ('name')
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller:_doseController,
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
                  controller:_QuantityController,
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
                    child: const Text("Select Date and Time")),
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
                  child: ElevatedButton(
                    onPressed: ()async {
                      // if (_formKey.currentState!.validate()) {
                       if (this.widget.id == "0") {
                        await _addItem();
                        clearForm();
                       }
                      if (this.widget.id != null) {
                        late int idupdate  = int.parse(widget.id);
                        await _updateItem(idupdate);
                        clearForm();
                      }
                      // Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(RefillReminder.routeName);
                    },
                    child:
                    Text(btn_lbl,
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

