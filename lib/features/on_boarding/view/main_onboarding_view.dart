import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee_restaurantapp/core/common/app_colors.dart';
import 'package:trainee_restaurantapp/core/common/style/gaps.dart';
import 'package:trainee_restaurantapp/core/navigation/route_generator.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';
import 'package:trainee_restaurantapp/generated/l10n.dart';

import '../../../core/common/style/dimens.dart';
import '../../../core/constants/app/app_constants.dart';

class MainOnBoardingView extends StatelessWidget {
  const MainOnBoardingView({Key? key}) : super(key: key);

  Widget userSelectorContainer(
      {required String image,
      required String type,
      required void Function()? onTap}) {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(AppConstants.borderRadius10)),
                color: AppColors.white.withOpacity(0.05)),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(AppConstants.borderRadius10),
                              topRight: Radius.circular(
                                  AppConstants.borderRadius10))),
                      child: Center(
                        child: CustomText(
                          text: type,
                          fontWeight: FontWeight.w600,
                          fontSize: AppConstants.textSize18,
                        ),
                      ),
                    )),
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 73.0),
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: CustomText(
                    text: Translation.of(context).areYou,
                    color: AppColors.accentColorLight,
                    fontSize: AppConstants.textSize20,
                    fontWeight: FontWeight.w700,
                  )),
              userSelectorContainer(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(Routes.mainLoginScreen, arguments: 1);
                  },
                  image: AppConstants.TRAINER_SPLASH,
                  type: Translation.of(context).trainer),
              userSelectorContainer(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(Routes.mainLoginScreen, arguments: 1);
                  },
                  image: AppConstants.RESTAURANT_SPLASH,
                  type: Translation.of(context).restaurantOwner),
              userSelectorContainer(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(Routes.mainLoginScreen, arguments: 2);
                  },
                  image: AppConstants.RESTAURANT_SPLASH,
                  type: Translation.of(context).shopOwner),
            ],
          ),
        ),
      ),
    );
  }
}
