import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Sql_helper_pages/SQL_helper_ReFillReminder.dart';


class RefillReminder extends StatefulWidget {
  static const String routeName = '/RefillReminder';



  const RefillReminder({Key? key}) : super(key: key);

  @override
  State<RefillReminder> createState() => _RefillReminderState();
}

class _RefillReminderState extends State<RefillReminder> {


  List<Map<String, dynamic >> RefillReminderList = [];

  bool isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshList() async {
    final data = await SQLHelper.getItems();
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
  late DateTime Date ;
  late DateTime Time ;

  void _showForm(int? id) async {
    if (id != null) {

      final refilllist =
      RefillReminderList.firstWhere((element) => element['id'] == id);
      _nameController.text = refilllist['name'];
      // _doseController.text = refilllist['description'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
          // key: _formKey,
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
                    Date = newDateTime;
                  },
                ),
              ),

              SizedBox(
                height: 100,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime newDateTime) {
                    Time = newDateTime;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(25),
                child: OutlinedButton(
                  onPressed: (){
                    // if (_formKey.currentState!.validate()) {
                      addItem();
                    // }
                    Navigator.of(context).pop();
                  },

                  child: const Text("Add Reminder",
                    // style: TextStyle(fontSizb -e: 20.0)
                  ),
                ),
              )
            ],
          ),
        ));

  }


  Future<void> addItem() async {
    await SQLHelper.createItem(
        _nameController.text);
    _refreshList();
  }
  // void _click() {
  //   addItem();
  //   print(_nameController.text);
  //   print(_doseController.text);
  //   print(_QuantityController.text);
  //   print(Date);
  //   print(Time);
  //   // clear();
  // }

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
              // subtitle: Text(RefillReminderList[index]['description']),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showForm(RefillReminderList[index]['id']),
                    ),
                    // IconButton(
                    //   icon: const Icon(Icons.delete),
                    //   onPressed: () =>{}
                    //       // _deleteItem(RefillReminderList[index]['id']),
                    // ),
                  ],
                ),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>  _showForm(null),
      ),
    );
  }

}


