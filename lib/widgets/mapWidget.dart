// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com

import 'package:flutter/material.dart';

class mapWidget extends StatelessWidget {
  const mapWidget({
    super.key,this.width = 320, this.height = 180,
 
  });
  
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {

    return Container(
                    clipBehavior: Clip.antiAlias,
                    width: width,
                    height: height,
                    decoration:
                        BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black,
                          
                        ),
                        
                  );
  }
}