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
  showAlertDialog(BuildContext context, int id) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: Text("Yes"),
      onPressed:  () {
        Navigator.of(context).pop();
        _deleteItem(id);
      },
    );
    Widget cancelButton = ElevatedButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm Delete"),
      content: Text("Do you want to delete this pill reminder?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
                color: Colors.grey[200],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                    title: Text(RefillReminderList[index]['name'],
                        style: const TextStyle(
                            // color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      ' Date : ' +
                          RefillReminderList[index]['date'] +
                          "\n" +
                          ' time : ' +
                          RefillReminderList[index]['time'],
                      // style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.edit , color: Colors.blueGrey),
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
                              icon: const Icon(Icons.delete , color: Colors.redAccent),
                              onPressed: () => {
                                showAlertDialog(context,
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
