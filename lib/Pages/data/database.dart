import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  // referencing the box
  final _myBox = Hive.box('mybox');

// method after first time opening the app
  void createInitialData() {
    toDoList = [
      ["This is demo tile 1", false],
      ["Demo tile 2", false],
    ];
  }

  // load the data from the database
  void loadDate() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
  // // plus button method
  // void _createNewTask() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return DialogBox(
  //           controller: _controller,
  //           onSave: saveNewTask,
  //           onCancel: () => Navigator.of(context).pop(),
  //         );
  //       });
  // }