// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com

import 'package:flutter/material.dart';

class imageWidget extends StatelessWidget {
  const imageWidget({
    super.key, required this.avatarURL, this.width = 120, this.height = 120,
 
  });
  final String avatarURL;
  final double width;
  final double height;
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
