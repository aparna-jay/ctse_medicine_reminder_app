import 'package:ctse_medicine_reminder_app/pages/reFillReminderForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Sql_helper_pages/SQL_helper_ReFillReminder.dart';


class RefillReminder extends StatefulWidget {
  static const String routeName = '/RefillReminder';
  const RefillReminder({Key? key}) : super(key: key);
  @override
  State<RefillReminder> createState() => _RefillReminderState();
}

class _RefillReminderState extends State<RefillReminder> {


  List<Map<String, dynamic  >> RefillReminderList = [];

  bool isLoading = true;
  // fetch all data from the database
  void _refreshList() async {
    final data = await SQL_helper_ReFillReminder.getItems();
    setState(() {
      RefillReminderList = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshList(); // Loading the diary when the app starts
  }


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  final TextEditingController _QuantityController = TextEditingController();
  late String formattedDate =  DateFormat('yyyy-MM-dd' ).format(DateTime.now());
  late String formattedTime = DateFormat('kk:mm').format(DateTime.now());

  // void _showForm(int? id) async {
  //   if (id != null) {
  //     final refillList =
  //     RefillReminderList.firstWhere((element) => element['id'] == id);
  //     _nameController.text = refillList['name'];
  //     _doseController.text = refillList['dose'];
  //     _QuantityController.text = refillList['quantity'];
  //   }

  //   showModalBottomSheet(
  //       context: context,
  //       elevation: 5,
  //       isScrollControlled: true,
  //       builder: (_) => Container(
  //         child: Column(
  //           children: [
  //             const SizedBox(height: 12),
  //             TextFormField(
  //               controller: _nameController,
  //               decoration: const InputDecoration(
  //                   border:OutlineInputBorder(
  //                       borderSide:BorderSide(color: Colors.limeAccent)
  //                   ),
  //                   labelText: ('name')
  //               ),
  //             ),
  //             const SizedBox(height: 12),
  //             TextFormField(
  //               controller: _doseController,
  //               decoration: const InputDecoration(
  //                   border:OutlineInputBorder(
  //                       borderSide:BorderSide(color: Colors.limeAccent)
  //                   ),
  //                   labelText: ('Dose')
  //               ),
  //             ),
  //             const SizedBox(height:12),
  //             TextFormField(
  //               controller: _QuantityController,
  //               decoration: const InputDecoration(
  //                   border:OutlineInputBorder(
  //                       borderSide:BorderSide(color: Colors.limeAccent)
  //                   ),
  //                   labelText: ('Total Quantity')
  //               ),
  //             ),
  //             Container(
  //                 margin: const EdgeInsets.all(25),
  //                 child: const Text("TODAY DATE AND TIME")),
  //             SizedBox(
  //               height: 100,
  //               child: CupertinoDatePicker(
  //                 mode: CupertinoDatePickerMode.date,
  //                 initialDateTime: DateTime.now(),
  //                 onDateTimeChanged: (DateTime newDateTime) {
  //                   formattedDate = DateFormat('yyyy-MM-dd ').format(newDateTime);
  //                 },
  //               ),
  //             ),
  //
  //             SizedBox(
  //               height: 100,
  //               child: CupertinoDatePicker(
  //                 mode: CupertinoDatePickerMode.time,
  //                 initialDateTime: DateTime.now(),
  //                 onDateTimeChanged: (DateTime newDateTime) {
  //                   formattedTime = DateFormat('kk:mm').format(newDateTime);
  //                 },
  //               ),
  //             ),
  //             Container(
  //               margin: const EdgeInsets.all(25),
  //               child: OutlinedButton(
  //                 onPressed: ()async {
  //                   // if (_formKey.currentState!.validate()) {
  //                   if (id == null) {
  //                     await _addItem();
  //                   }
  //                   if (id != null) {
  //                     await _updateItem(id);
  //                   }
  //                   // }
  //                   Navigator.of(context).pop();
  //                 },
  //                 child:
  //                 const Text("Add Reminder",
  //                   // style: TextStyle(fontSizb -e: 20.0)
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ));
  //
  // }

  //
  // Future<void> _addItem() async {
  //   await SQL_helper_ReFillReminder.createItem(
  //       _nameController.text,
  //       _doseController.text,
  //       _QuantityController.text,
  //       formattedDate,
  //       formattedTime,
  //   );
  //   _refreshList();
  // }
  // // Update an existing list item
  // Future<void> _updateItem(int id) async {
  //   await SQL_helper_ReFillReminder.updateItem(
  //       id,
  //       _nameController.text,
  //       _doseController.text,
  //       _QuantityController.text,
  //       formattedDate,
  //       formattedTime,
  //   );
  //   _refreshList();
  // }
  //
  // Delete an refillList item
  void _deleteItem(int id) async {
    await SQL_helper_ReFillReminder.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ReFill Reminder"),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: RefillReminderList.length,
        itemBuilder: (context, index) => Card(
          color: Colors.orange[200],
          margin: const EdgeInsets.all(15),
          child: ListTile(
              title: Text(RefillReminderList[index]['name']),
                    subtitle: Text('Date : ' +
                        RefillReminderList[index]['date'] +
                        "\n" +
                        'time : ' +
                        RefillReminderList[index]['time']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () =>{
                              // _showForm(RefillReminderList[index]['id']),
                            Navigator.push(
                            context,
                            MaterialPageRoute(

                            builder: (context) => RefillReminderForm(
                                id: RefillReminderList[index]['id'].toString()
                            ),
                            ),
                            )
                            }

                          ),
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>{
                          _deleteItem(RefillReminderList[index]['id']),
                      }
                    ),
                  ],
                ),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>  Navigator.of(context).pushNamed(RefillReminderForm.routeName)


        // _showForm(null),

      ),
    );
  }
}