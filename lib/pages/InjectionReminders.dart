import 'package:ctse_medicine_reminder_app/pages/AddInjectionReminder.dart';
import 'package:flutter/material.dart';
import 'Sql_helper_pages/sql_helper_InjectionReminder.dart';

class  InjectionReminders extends StatefulWidget {
  static const String routeName = '/InjectionReminders';
  const  InjectionReminders({Key? key}) : super(key: key);

  @override
  _InjectionRemindersState createState() => _InjectionRemindersState();
}


class _InjectionRemindersState extends State<InjectionReminders>{
  // All journals
  List<Map<String, dynamic>> _injectionReminders = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
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

  // Delete a injection reminder
  void _deleteItem(int id) async {
    await SQLHelperInjectionReminder.deleteInjectionReminder(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted an Injection Reminder!'),
    ));
    _refreshInjectionReminders();
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
          color: Colors.blue[200],
          margin: const EdgeInsets.all(15),
          child: ListTile(
              title: Text(_injectionReminders[index]['injectionName']),
              subtitle: Text(_injectionReminders[index]['dosage']),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit), onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddInjectionReminder(_injectionReminders[index]['id'])));
                    },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          _deleteItem(_injectionReminders[index]['id']),
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
