// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com

import 'package:flutter/material.dart';


class InputTextField extends StatefulWidget {
  const InputTextField({
    super.key,
    this.label = "",
    this.content = "",
    this.readOnly = false,
    this.width = 320,
    this.height = 40,
    this.hintText = "", 
  });

  final double width;
  final double height;
  final String label;
  final String content;
  final bool readOnly;
  final String hintText; 

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        readOnly: widget.readOnly,
        controller: TextEditingController(text: widget.content),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText, 
          fillColor: Color.fromRGBO(238, 242, 255, 1),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 7, 20, 10),
        ),
      ),
    );
  }
}