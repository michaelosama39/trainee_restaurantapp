import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/app_colors.dart';
import '../../constants/app/app_constants.dart';
import 'custom_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final double? borderRadius;
  final double? textSize;
  final int? textMaxLines;

  const CustomElevatedButton(
      {Key? key,
      required this.onTap,
      required this.text,
      this.borderRadius,
      this.textSize,
      this.textMaxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(borderRadius ?? AppConstants.borderRadius2),
      ))),
      child: CustomText(
        text: text,
        fontSize: textSize ?? AppConstants.textSize16,
        fontWeight: FontWeight.bold,
        maxLines: textMaxLines,
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final Function onTap;
  final String text;

  const CustomTextButton({Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius2),
      ))),
      child: CustomText(
        text: text,
        fontSize: AppConstants.textSize16,
      ),
    );
  }
}

class NewElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Color? color;

  const NewElevatedButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightGrey.withOpacity(0)),
            gradient:color==null? LinearGradient(colors: [
              AppColors.transparent.withOpacity(0.3),
              AppColors.transparent.withOpacity(0),
            ]):null,
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: MaterialButton(
          onPressed: onTap,
          child: Center(
            child: CustomText(
              text: text,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
