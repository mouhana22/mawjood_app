// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com

import 'package:flutter/material.dart';
import 'btnTypes.dart';



class button extends StatelessWidget {
  const button({
    super.key,
    required this.text, 
    required this.type,
    this.height = 34,
    this.width = 137.5, required Null Function() onPressed
  });
  final double width;
  final double height;
  final String text;
  final btnType type;
  @override
  Widget build(BuildContext context) {
    var textColor;
    var backgroundColor;
          if(type == btnType.Primary){
              textColor = Color.fromRGBO(238, 242, 255, 1);
              backgroundColor = Color.fromRGBO(30, 27, 75, 1);
          }else if(type == btnType.Green){
              textColor = Color.fromRGBO(47, 216, 74, 1);
              backgroundColor = Color.fromRGBO(208, 255, 215, 1);
          }else if(type == btnType.Red){
              textColor = Color.fromRGBO(200, 59, 59, 1);
              backgroundColor = Color.fromRGBO(255, 222, 222, 1);
          }else{
              textColor = Color.fromRGBO(30, 27, 75, 1);
              backgroundColor = Color.fromRGBO(238, 242, 255, 1);
          }
    return ElevatedButton(
      onPressed: () {},
      child:  Text(text, style:TextStyle(color: textColor, fontSize: 10),),
      style:  ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: Size(width, height),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),)
      ),

    );
  }
}
