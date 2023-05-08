import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:trainee_restaurantapp/core/common/app_colors.dart';
import 'package:trainee_restaurantapp/core/common/style/gaps.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/navigation/route_generator.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_appbar.dart';
import 'dart:ui' as ui;

import '../../../../core/ui/widgets/custom_text.dart';
import '../../../../core/ui/widgets/precentage_show.dart';

class AllTraineeScreen extends StatelessWidget {
  const AllTraineeScreen({Key? key}) : super(key: key);

  Widget traineeCard({required context}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.traineeProfileScreen);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 140.h,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        AppColors.linearCardTrainee1Color.withOpacity(1),
                        AppColors.linearCardTrainee2Color.withOpacity(1),
                        AppColors.linearCardTrainee3Color.withOpacity(1),
                        AppColors.linearCardTrainee4Color.withOpacity(1),
                      ]),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                        text: "رامي المصري",
                        fontSize: AppConstants.textSize18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                      CustomText(
                        text: "كورس يوجا محترف مخصص لمن لديهم خبره",
                        fontSize: AppConstants.textSize16,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                      CustomText(
                        text: "2000 ريال",
                        fontSize: AppConstants.textSize16,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w400,
                        color: AppColors.accentColorLight,
                      ),
                      const PrecentageShow(prescentageValue: 32,)
                    ],
                  ),
                ),
              ),
              Gaps.hGap4,
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppConstants.COACH1_IMAGE),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        title: 'المتدريبين',
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return traineeCard(context: context);
                }),
          )
        ],
      ),
    );
  }
}
