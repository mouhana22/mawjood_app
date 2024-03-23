import 'package:flutter/material.dart';

class redButton extends StatelessWidget {
  const redButton({
    super.key,
    required this.text,
    required this.icon
  });

  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      label: Text(text, style:TextStyle(color: Color.fromRGBO(200, 59, 59, 1), fontSize: 10),),
      icon:  Icon(icon, color: Color.fromRGBO(200, 59, 59, 1),),
      style:  ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(255, 222, 222, 1),
          minimumSize: Size(137.5, 34),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),)
      ),

    );
  }
}