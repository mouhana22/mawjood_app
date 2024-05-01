import 'package:flutter/material.dart';
import 'package:mawjood_app/widgets/imageWidget.dart';
import 'package:mawjood_app/widgets/statusBox.dart';

class WrongLocation extends StatelessWidget {
  const WrongLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 242, 255, 1),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const ImageWidget(
                avatarURL: 'https://i.ibb.co/94RhRtG/logo.png',
                width: 50,
                height: 50,
              ),
              const SizedBox(height: 200.0),
              StatusBox(
                icon: Icons.pin_drop,
                iconColor: const Color.fromARGB(255, 255, 255, 255),
                title: 'Unregistered location',
                textColor: Color.fromARGB(255, 255, 255, 255),
                color: Color.fromARGB(215, 92, 94, 233),
                showDateTime: false,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
