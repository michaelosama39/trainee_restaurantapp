import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainee_restaurantapp/core/common/app_colors.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_button.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';

import '../../../../core/appStorage/app_storage.dart';
import '../../../../core/common/style/dimens.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';

class AddCourseView extends StatefulWidget {
  AddCourseView({super.key});

  @override
  State<AddCourseView> createState() => _AddCourseViewState();
}

class _AddCourseViewState extends State<AddCourseView> {
  @override
  void initState() {
    print(AppStorage.getUserInfo!.result!.userId);
    print("AppStorage.getUserId");
    super.initState();
  }
  uploadSignUpFile({required void Function()? onTap, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 120.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.hGap20,
              CustomText(
                  text: text,
                  fontSize: AppConstants.textSize18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accentColorLight),
              Gaps.hGap12,
              DottedBorder(
                color: AppColors.white,
                dashPattern: const [10, 3],
                radius: Radius.circular(10),
                borderType: BorderType.Rect,
                strokeWidth: 3,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((Dimens.dp12))),
                  height: Dimens.dp80.h,
                  width: double.infinity,
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.upload,
                      color: AppColors.accentColorLight,
                      size: Dimens.dp40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FocusNode commercialNumber = FocusNode();

  TextEditingController commercialNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "أضافة كورس",
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: AppConstants.textSize18,
              ),
              Gaps.vGap16,
              EmailTextField(
                text: "اسم الكورس",
                onFiledSubmitted: () {
                  // FocusScope.of(context).requestFocus(passwordFocusNode);
                },
                textInputAction: TextInputAction.next,
                controller: commercialNumberController,
                focusNode: commercialNumber,
              ),
              Gaps.vGap16,
              uploadSignUpFile(
                  text: "ارفق صوره تعبيريه عن الكورس", onTap: () {}),
              Gaps.vGap16,
              EmailTextField(
                text: "عدد الساعات",
                onFiledSubmitted: () {
                  // FocusScope.of(context).requestFocus(passwordFocusNode);
                },
                textInputAction: TextInputAction.next,
                controller: commercialNumberController,
                focusNode: commercialNumber,
              ),
              Gaps.vGap16,
              EmailTextField(
                text: "عدد المشتركين",
                onFiledSubmitted: () {
                  // FocusScope.of(context).requestFocus(passwordFocusNode);
                },
                textInputAction: TextInputAction.next,
                controller: commercialNumberController,
                focusNode: commercialNumber,
              ),
              Gaps.vGap16,
              Spacer(),
              Expanded(
                  child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 45.0, horizontal: 20),
                  child: CustomElevatedButton(
                    borderRadius: 12,
                    onTap: () {},
                    text: 'اضافه',
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
