import 'package:ctse_medicine_reminder_app/pages/addPillReminder.dart';
import 'package:flutter/material.dart';

import 'Sql_helper_pages/sql_helper_pillReminder.dart';

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

  @override
  void initState() {
    super.initState();
    _refreshPillReminders(); // Loading the pill reminders when the app starts
  }

  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _dosageController = TextEditingController();
  // final TextEditingController _quantityController = TextEditingController();
  // final TextEditingController _repeatController = TextEditingController();
  // final TextEditingController _timeController = TextEditingController();


// Insert a new pill reminder to the database
//   Future<void> _addPillReminder() async {
//     await SQLHelperPillReminder.createPillReminder(
//         _nameController.text, _dosageController.text, _quantityController.text, _repeatController.text, _timeController.text);
//     _refreshPillReminders();
//   }



  // Delete a pill reminder
  void _deleteItem(int id) async {
    await SQLHelperPillReminder.deletePillReminder(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshPillReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          color: Colors.orange[200],
          margin: const EdgeInsets.all(15),
          child: ListTile(
              title: Text(_pillReminders[index]['name']),
              subtitle: Text(_pillReminders[index]['dosage']),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit), onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPillReminder(_pillReminders[index]['id'])));
                    },
                      //onPressed: () => _showForm(_journals[index]['id']),

                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          _deleteItem(_pillReminders[index]['id']),
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
    );
  }
}
