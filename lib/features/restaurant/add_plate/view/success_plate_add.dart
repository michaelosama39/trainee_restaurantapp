import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_button.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';

import '../../../../core/common/app_colors.dart';

class SuccessPlateAdd extends StatelessWidget {
  const SuccessPlateAdd({Key? key}) : super(key: key);

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
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AvatarGlow(
                        endRadius: 100.0,
                        glowColor: AppColors.white,
                        child: Material(
                          // Replace this child with your own
                          elevation: 8.0,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[400],
                            child: const FaIcon(
                              FontAwesomeIcons.check,
                              size: 50,
                              color: AppColors.white,
                            ),
                            radius: 50.0,
                          ),
                        ),
                      ),
                      CustomText(
                        text: "تمت اضافة طبقك بنجاح",
                        color: AppColors.white,
                        fontSize: AppConstants.textSize18,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                )),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
                  child: NewElevatedButton(
              color: null,
              onTap: () {},
              text: "الذهاب الي كورساتي",
            ),
                ))
          ],
        ),
      ),
    );
  }
}
