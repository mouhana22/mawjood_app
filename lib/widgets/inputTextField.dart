// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com

import 'package:flutter/material.dart';

class inputTextField extends StatefulWidget {
  const inputTextField({super.key, this.lablel = "", this.content = "", this.readOnly = false,  this.width = 320, this.height = 40});
  final double width;
  final double height;
  final String lablel;
  final String content; 
  final bool readOnly;

  @override
  State<inputTextField> createState() => __inputTextFieldStateState();
}

class __inputTextFieldStateState extends State<inputTextField> {
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
          labelText: widget.lablel,
          fillColor: Color.fromRGBO(238, 242, 255, 1),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 10),
        ),
      ),
    );
  }
}
