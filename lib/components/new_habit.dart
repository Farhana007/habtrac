import 'package:flutter/material.dart';

class EnterNewHabit extends StatelessWidget {

  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;


  const EnterNewHabit ({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel
});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.teal,

      content: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),

          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),

          ),
        ),

      ),
      actions: [
        MaterialButton(
            elevation: 5,
            onPressed: onSave,
          child: Text("Save",style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700
          ),),
          color: Colors.tealAccent,
        ),

        MaterialButton(
          elevation: 5,
          onPressed: onCancel,
          child: Text("Cancel",style: TextStyle(
            color: Colors.black,
              fontWeight: FontWeight.w700
          ),),
          color: Colors.tealAccent,
        ),
      ],
    );
  }
}
