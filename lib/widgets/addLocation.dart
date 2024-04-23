import 'package:flutter/material.dart';
import 'package:mawjood_app/cardsWidgets/locationCard.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/iconButton.dart';

class AddLocation extends StatelessWidget {
  const AddLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomIconButton(
          width: 200,
          text: 'Add New Location',
          icon: Icons.add,
          type: btnType.Primary,
          onPressed: (){
            LocationCard();
          },
    );
  }
}
