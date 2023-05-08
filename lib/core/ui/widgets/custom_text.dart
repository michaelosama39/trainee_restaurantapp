import 'package:flutter/material.dart';

import '../../common/app_colors.dart';
import '../../constants/app/app_constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final double? height;
  const CustomText(
      {Key? key,
      required this.text,
      this.color,
      this.fontWeight,
      this.fontSize,
      this.textAlign,
      this.textOverflow,
      this.maxLines,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color ?? AppColors.textLight,
          height: height,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontSize: fontSize ?? AppConstants.textSize12,
          fontFamily: 'Tajawal',
          overflow: textOverflow ?? TextOverflow.visible),
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}
