import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_button.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';

import '../../../../../core/common/app_colors.dart';
import '../../../../../core/navigation/route_generator.dart';

class SuccessCourseAdd extends StatelessWidget {
  const SuccessCourseAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGrey2.withOpacity(0.5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AvatarGlow(
                      endRadius: 100.0,
                      glowColor: AppColors.white,
                      child: Material(
                        // Replace this child with your own
                        elevation: 8.0,
                        shape: const CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          radius: 50.0,
                          child: const FaIcon(
                            FontAwesomeIcons.check,
                            size: 50,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    CustomText(
                      text: "تمت اضافة الكورس بنجاح",
                      color: AppColors.white,
                      fontSize: AppConstants.textSize18,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                )),
            Expanded(
                child: NewElevatedButton(
              color: null,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, Routes.myCourseScreen, (route) => false);
              },
              text: "الذهاب الي كورساتي",
            ))
          ],
        ),
      ),
    );
  }
}
