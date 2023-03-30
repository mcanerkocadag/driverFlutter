import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/product/constants/color_constants.dart';
import 'package:kartal/kartal.dart';

class SubTitleText extends StatelessWidget {
  SubTitleText(
      {required this.text,
      this.color = ColorConstants.black,
      super.key,
      this.textStyle});
  final String text;
  final Color color;
  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    textStyle ??= context.textTheme.titleMedium;
    return Text(
      text,
      style: textStyle?.copyWith(fontWeight: FontWeight.normal, color: color),
    );
  }
}
