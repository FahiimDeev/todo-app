import 'package:flutter/material.dart';
import 'package:todoapp/utils/my_buttons.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final FocusNode focusNode;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.focusNode,
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.brown[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get the user input
            TextField(
              controller: widget.controller,  
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),

            // buttons -> save and cancel button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                MyButtons(
                  text: "Save",
                  onPressed: widget.onSave, 
                ),
                const SizedBox(width: 7),
                
                // cancel button
                MyButtons(
                  text: "Cancel",
                  onPressed: widget.onCancel, 
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
