// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com

import 'package:flutter/material.dart';

class avatar extends StatelessWidget {
  const avatar({
    super.key, required this.avatarURL,
 
  });
  final String avatarURL;
  @override
  Widget build(BuildContext context) {

    return Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Image(
                      image: NetworkImage(avatarURL),
                      fit: BoxFit.contain,
                      height: 120,
                      width: 120,
                    ),
                  );
  }
}
