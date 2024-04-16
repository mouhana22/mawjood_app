// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com


import 'package:flutter/material.dart';


class CardWidget extends StatefulWidget {
  const CardWidget({super.key, required this.cardTitle, required this.cardBody});

  final String cardTitle;
  final List<Widget> cardBody;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {

  @override
  Widget build(BuildContext context) {
    

    return   Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
            surfaceTintColor: Colors.white,
            elevation: 4,
            child: ExpansionTile(
              shape: const Border(),
              childrenPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              iconColor: const Color.fromRGBO(99, 102, 241, 1),
              collapsedIconColor: const Color.fromRGBO(99, 102, 241, 1),
              title: Text(widget.cardTitle,style: const TextStyle(color: Color.fromRGBO(99, 102, 241, 1)),),
              children: widget.cardBody
              
            )
  );
  }


}
