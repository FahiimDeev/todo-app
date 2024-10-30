import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTiles extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  // final String taskTime;
  final Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  TodoTiles({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    // required this.taskTime,
  });

  // void deleteFunction() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.black,
            borderRadius: BorderRadius.circular(10),
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.brown[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              // Check box
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                // fillColor: MaterialStateProperty.all(Colors.black),
                activeColor: Colors.black,
              ),
              // Task name
              Text(
                taskName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              // Task time
              // Text(
              //   taskTime,
              //   style: TextStyle(color: Colors.grey, fontSize: 16),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
