import 'package:flutter/cupertino.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../common/app_colors.dart';
import '../../common/style/gaps.dart';
import '../../constants/app/app_constants.dart';
import 'custom_text.dart';

class PrecentageShow extends StatelessWidget {
  final int prescentageValue;
  const PrecentageShow({Key? key,required this.prescentageValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            child: CustomText(
              text: "$prescentageValue %",
              color: AppColors.white,
              fontSize: AppConstants.textSize14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gaps.hGap8,
           Expanded(
            flex: 5,
            child: Center(
              child: StepProgressIndicator(
                totalSteps: 100,
                currentStep: prescentageValue,
                size: 8,
                padding: 0,
                selectedColor: AppColors.accentColorLight,
                unselectedColor: AppColors.unselectedColor,
                roundedEdges: Radius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
