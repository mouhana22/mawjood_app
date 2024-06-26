// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com

import 'package:flutter/material.dart';
import 'btnTypes.dart';



class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.text,
    required this.icon, 
    required this.type,
    this.onPressed,
    this.height = 34,
    this.width = 137.5,
    this.fontSize = 14
  });
  final double width;
  final double height;
  final String text;
  final double fontSize;
  final IconData icon;
  final btnType type;
  final VoidCallback? onPressed;

  
  @override
  Widget build(BuildContext context) {
    Color textColor;
    Color iconColor;
    Color backgroundColor;
          if(type == btnType.Primary){
              textColor = const Color.fromRGBO(238, 242, 255, 1);
              iconColor = const Color.fromRGBO(238, 242, 255, 1);
              backgroundColor = const Color.fromRGBO(30, 27, 75, 1);
          }else if(type == btnType.Green){
              textColor = const Color.fromRGBO(47, 216, 74, 1);
              iconColor = const Color.fromRGBO(47, 216, 74, 1);
              backgroundColor = const Color.fromRGBO(208, 255, 215, 1);
          }else if(type == btnType.Red){
              textColor = const Color.fromRGBO(200, 59, 59, 1);
              iconColor = const Color.fromRGBO(200, 59, 59, 1);
              backgroundColor = const Color.fromRGBO(255, 222, 222, 1);
          }else{
              textColor = const Color.fromRGBO(30, 27, 75, 1);
              iconColor = const Color.fromRGBO(30, 27, 75, 1);
              backgroundColor = const Color.fromRGBO(238, 242, 255, 1);
          }
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: Text(text, style:TextStyle(color: textColor, fontSize: fontSize),),
      icon:  Icon(icon, color: iconColor,),
      style:  ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: Size(width, height),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),)
      ),

    );
  }
}
