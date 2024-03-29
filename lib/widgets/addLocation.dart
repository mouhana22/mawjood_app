import 'package:flutter/material.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/iconButton.dart';
import 'package:mawjood_app/widgets/mapWidget.dart';

class addLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold (
      body: Center(
        child: CustomIconButton(
          width: 200,
          text: 'Add New Location',
          icon: Icons.add,
          type: btnType.Primary,
          //onPressed: (),
        ),
    ));
  }
}
