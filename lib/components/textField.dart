import 'package:flutter/material.dart';

class defaultTextField extends StatelessWidget {
  defaultTextField(
      {required this.label, required this.onchanged, this.obsecure = false});

  String label;
  Function(String)? onchanged;
  bool? obsecure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is required';
        }
      },
      onChanged: onchanged,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Pacifico',
        ),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        border: OutlineInputBorder(),
      ),
    );
  }
}
