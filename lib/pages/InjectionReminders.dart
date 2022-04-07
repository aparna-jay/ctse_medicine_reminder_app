import 'package:ctse_medicine_reminder_app/pages/AddInjectionReminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Sql_helper_pages/sql_helper_InjectionReminder.dart';
import 'package:flutter/src/material/colors.dart';

class  InjectionReminders extends StatefulWidget {
  static const String routeName = '/InjectionReminders';
  const  InjectionReminders({Key? key}) : super(key: key);

  @override
  _InjectionRemindersState createState() => _InjectionRemindersState();
}


class _InjectionRemindersState extends State<InjectionReminders>{
  // All reminders
  List<Map<String, dynamic>> _injectionReminders = [];

  bool _isLoading = true;
  // _refreshInjectionReminders() is used to fetch all data from the database
  void _refreshInjectionReminders() async {
    final data = await SQLHelperInjectionReminder.getInjectionReminders();
    setState(() {
      _injectionReminders = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshInjectionReminders(); // Loading the injection reminders when the app starts
  }

  // Delete an injection reminder
  void _deleteItem(int id) async {
    await SQLHelperInjectionReminder.deleteInjectionReminder(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted an Injection Reminder!'),
    ));
    _refreshInjectionReminders();
  }

  //alert dialog
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
      content: Text("Are you sure you want to delete this Injection reminder?"),
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
        title: const Text('Injection Reminders'),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _injectionReminders.length,
        itemBuilder: (context, index) => Card(
          color: Colors.grey[200],
          margin: const EdgeInsets.all(15),
          child: ListTile(
              title: Text(_injectionReminders[index]['injectionName'], style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),),

              subtitle: Text("\n" + 'Dosage(ml) : ' +_injectionReminders[index]['dosage'] +
                  "\n\n" +
                'Time : ' +
                  _injectionReminders[index]['time'],
                  style: TextStyle(color: Colors.black54, fontSize: 15)),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blueGrey), onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddInjectionReminder(_injectionReminders[index]['id'])));
                    },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () =>
                          showAlertDialog(context, _injectionReminders[index]['id']),
                    ),
                  ],
                ),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(AddInjectionReminder.routeName);
          }
      ),
    );
  }
}
