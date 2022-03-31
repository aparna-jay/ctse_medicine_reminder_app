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
  //create map to store data
  List<Map<String, dynamic>> RefillReminderList = [];

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
    _refreshList(); // Loading the list when the app starts
  }

  late String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  late String formattedTime = DateFormat('AA:BB').format(DateTime.now());

  void _deleteItem(int id) async {
    await SQL_helper_ReFillReminder.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted!'),
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
          ? const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ListView.builder(
              itemCount: RefillReminderList.length,
              itemBuilder: (context, index) => Card(
                color: Colors.indigo,
                margin: const EdgeInsets.all(15),
                child: ListTile(
                    title: Text('Title : ' + RefillReminderList[index]['name'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      ' Date : ' +
                          RefillReminderList[index]['date'] +
                          "\n" +
                          ' time : ' +
                          RefillReminderList[index]['time'],
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => {
                                    // _showForm(RefillReminderList[index]['id']),
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RefillReminderForm(
                                                id: RefillReminderList[index]
                                                        ['id']
                                                    .toString()),
                                      ),
                                    )
                                  }),
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => {
                                    _deleteItem(
                                        RefillReminderList[index]['id']),
                                  }),
                        ],
                      ),
                    )),
              ),
            ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () =>
              Navigator.of(context).pushNamed(RefillReminderForm.routeName)),
    );
  }
}
