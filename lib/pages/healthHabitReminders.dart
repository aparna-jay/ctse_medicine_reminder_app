import 'package:ctse_medicine_reminder_app/pages/addHealthHabitReminder.dart';
import 'package:flutter/material.dart';

import 'Sql_helper_pages/sql_helper_healthHabitReminder.dart';

class HealthHabitReminders extends StatefulWidget {
  static const String routeName = '/healthHabitReminders';
  const HealthHabitReminders({Key? key}) : super(key: key);

  @override
  _HealthHabitRemindersState createState() => _HealthHabitRemindersState();
}

class _HealthHabitRemindersState extends State<HealthHabitReminders> {
  // All journals
  List<Map<String, dynamic>> _healthHabitReminders = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshHealthHabitReminders() async {
    final data = await SQLHelperHealthHabitReminder.gethealthHabitReminders();
    setState(() {
      _healthHabitReminders = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshHealthHabitReminders(); // Loading the healthHabit reminders when the app starts
  }

  // Delete a healthHabit reminder
  void _deleteItem(int id) async {
    await SQLHelperHealthHabitReminder.deletehealthHabitReminder(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a healthHabit reminder!'),
    ));
    _refreshHealthHabitReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HealthHabit Reminders'),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _healthHabitReminders.length,
        itemBuilder: (context, index) => Card(
          color: Colors.blue[200],
          margin: const EdgeInsets.all(15),
          child: ListTile(
              title: Text(_healthHabitReminders[index]['name']),
              subtitle: Text(_healthHabitReminders[index]['dosage']),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit), onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddHealthHabitReminder(_healthHabitReminders[index]['id'])));
                    },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          _deleteItem(_healthHabitReminders[index]['id']),
                    ),
                  ],
                ),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(AddHealthHabitReminder.routeName);
          }
      ),
    );
  }
}