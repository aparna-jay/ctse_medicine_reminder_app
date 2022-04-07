import 'package:ctse_medicine_reminder_app/pages/addPillReminder.dart';
import 'package:flutter/material.dart';

import 'Sql_helper_pages/sql_helper_pillReminder.dart';
import 'home.dart';

class PillReminders extends StatefulWidget {
  static const String routeName = '/pillReminders';
  const PillReminders({Key? key}) : super(key: key);

  @override
  _PillRemindersState createState() => _PillRemindersState();
}

class _PillRemindersState extends State<PillReminders> {
  // All journals
  List<Map<String, dynamic>> _pillReminders = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshPillReminders() async {
    final data = await SQLHelperPillReminder.getPillReminders();
    setState(() {
      _pillReminders = data;
      _isLoading = false;
    });
  }

  // Delete a pill reminder
  void _deleteItem(int id) async {
    await SQLHelperPillReminder.deletePillReminder(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a pill reminder!'),
    ));
    _refreshPillReminders();
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
  void initState() {
    super.initState();
    _refreshPillReminders(); // Loading the pill reminders when the app starts
  }



  @override
  Widget build(BuildContext context) {
    String backNavEnabled = "true";
    return WillPopScope(

      onWillPop: () async {
        if(backNavEnabled == "true"){
          Navigator.of(context).pushNamed(Home.routeName);
          return true;
        }
        else {
          return false;
        }

      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pill Reminders'),
        ),
        body: _isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: _pillReminders.length,
          itemBuilder: (context, index) => Card(
            color: Colors.grey[200],
            margin: const EdgeInsets.all(15),
            child: ListTile(
                title: Text(_pillReminders[index]['name']),
                subtitle: Text(_pillReminders[index]['dosage']),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blueGrey), onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPillReminder(_pillReminders[index]['id'])));
                      },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () =>
                            showAlertDialog(context, _pillReminders[index]['id']),
                      ),
                    ],
                  ),
                )),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPillReminder.routeName);
            }
        ),
      ),
    );
  }
}
