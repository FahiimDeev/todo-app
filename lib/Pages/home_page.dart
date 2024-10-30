import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/Pages/data/database.dart';
import 'package:todoapp/utils/dialog_box.dart';
import 'package:todoapp/utils/todo_tiles.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ToDoDatabase db = ToDoDatabase();
  final _myBox = Hive.box('mybox');
  final _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // Define FocusNode here

  @override
  void initState() {
    super.initState();
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadDate();
    }
  }

  // Checkbox was taped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  // Save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // Plus button method
  void _createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          focusNode: _focusNode, // Use class-level focus node
          onSave: saveNewTask,
          onCancel: () {
            _controller.clear(); // Clear controller here
            Navigator.of(context).pop();
          },
        );
      },
    ).then((_) {
      _focusNode.requestFocus(); // Request focus when dialog is shown
    });
  }

  // Delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    // Date and time of today
    String formattedDate = DateFormat('EEEE, MMM d, y').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        title: Text(
          "Works List  \n$formattedDate",
          textAlign: TextAlign.justify,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewTask,
        child: const Icon(Icons.plus_one),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTiles(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            deleteFunction: (context) => deleteTask(index),
            onChanged: (value) => checkBoxChanged(value, index),
          );
        },
      ),
    );
  }
}
