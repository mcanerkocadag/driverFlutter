import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/product/enums/image_constants.dart';

class CircleButton extends StatelessWidget {
  const CircleButton(
      {super.key,
      required this.onTap,
      required this.size,
      this.color,
      required this.image});

  final GestureTapCallback onTap;
  final double size;
  final Color? color;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Center(
          child: image,
        ),
      ),
    );
  }
}
