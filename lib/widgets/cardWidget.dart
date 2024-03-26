// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com


import 'package:flutter/material.dart';


class cardWidget extends StatefulWidget {
  const cardWidget({super.key, required this.cardTitle, required this.cardBody});

  final String cardTitle;
  final List<Widget> cardBody;

  @override
  State<cardWidget> createState() => _cardWidgetState();
}

class _cardWidgetState extends State<cardWidget> {

  @override
  Widget build(BuildContext context) {
    

    return   Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
            surfaceTintColor: Colors.white,
            elevation: 4,
            child: ExpansionTile(
              shape: const Border(),
              childrenPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              iconColor: Color.fromRGBO(99, 102, 241, 1),
              collapsedIconColor: Color.fromRGBO(99, 102, 241, 1),
              title: Text(widget.cardTitle,style: TextStyle(color: Color.fromRGBO(99, 102, 241, 1)),),
              children: widget.cardBody
              
            )
  );
  }


}
