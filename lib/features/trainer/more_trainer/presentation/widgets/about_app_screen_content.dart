import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:trainee_restaurantapp/core/common/style/gaps.dart';

import '../../../../../core/constants/app/app_constants.dart';
import '../../../../../core/ui/widgets/blur_widget.dart';
import '../../../../../core/ui/widgets/custom_text.dart';


class AboutAppScreenContent extends StatefulWidget {
  const AboutAppScreenContent({super.key});

  @override
  State<AboutAppScreenContent> createState() => _AboutAppScreenContentState();
}

class _AboutAppScreenContentState extends State<AboutAppScreenContent> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Gaps.vGap16,
            Image.asset(
              AppConstants.APP_LOGO_IMG,
              width: 117.w,
              fit: BoxFit.contain,
            ),
            Gaps.vGap40,
            BlurWidget(
              width: 1.sw,
              child: Padding(
                padding: EdgeInsets.all(14.w),
                child: CustomText(
                  text: "",
                  fontSize: AppConstants.textSize16,
                  textAlign: TextAlign.center,
                  height: 2.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
