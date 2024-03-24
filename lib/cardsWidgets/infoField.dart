// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com


import 'package:flutter/material.dart';

class infoField extends StatelessWidget {
  const infoField({
    super.key,
    required this.data,
    this.height = 25,
    this.width = 170,
    this.textColor = const Color.fromARGB(128, 0, 0, 0),
  });
  final double width;
  final double height;
  final String data;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
        
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Color.fromRGBO(238, 242, 255, 1),
          borderRadius: BorderRadius.circular(10)
        ),
        
        child:
        Align(
          child: 
          Text(data,textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: textColor),)
          ),
        );
  }
}
