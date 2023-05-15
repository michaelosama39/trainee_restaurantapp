
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainee_restaurantapp/core/common/app_colors.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_button.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';
import 'package:trainee_restaurantapp/features/trainer/add_course/presentation/controller/add_course_cubit.dart';
import '../../../../../core/common/style/dimens.dart';
import '../../../../../core/common/style/gaps.dart';
import '../../../../../core/ui/widgets/custom_text_field.dart';

class AddNewTraineeEntryScreen extends StatefulWidget {
  const AddNewTraineeEntryScreen({super.key});

  @override
  State<AddNewTraineeEntryScreen> createState() => _AddNewTraineeEntryScreenState();
}

class _AddNewTraineeEntryScreenState extends State<AddNewTraineeEntryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Form(
              key: AddCourseCubit.of(context).formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "ادخال قيم جديدة",
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: AppConstants.textSize18,
                  ),
                  Gaps.vGap16,
                  EmailTextField(
                    text: "الوزن",
                    onFiledSubmitted: () {

                    },
                    textInputAction: TextInputAction.next,
                    controller: TextEditingController(),
                    // focusNode: AddCourseCubit.of(context).arNameFocusNode,
                  ),
                  Gaps.vGap16,
                  EmailTextField(
                    text: "نسبة الدهون",
                    onFiledSubmitted: () {
                      // FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                    textInputAction: TextInputAction.next,
                    controller: TextEditingController(),
                    // focusNode: AddCourseCubit.of(context).enNameFocusNode,
                  ),
                  Gaps.vGap16,
                  EmailTextField(
                    text: "الساعات المنجزة",
                    onFiledSubmitted: () {
                      // FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                    textInputAction: TextInputAction.next,
                    controller: TextEditingController()
                    // focusNode: AddCourseCubit.of(context).feeFocusNode,
                  ),
                  Gaps.vGap16,
                  EmailTextField(
                    text: "عدد مرات الغياب",
                    onFiledSubmitted: () {
                      // FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                    textInputAction: TextInputAction.next,
                    controller: TextEditingController(),
                    // focusNode: AddCourseCubit.of(context)
                    //     .discountPercentageFocusNode,
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 45.0,
                        horizontal: 20,
                      ),
                      child: CustomElevatedButton(
                        borderRadius: 12,
                        onTap: () {
                          AddCourseCubit.of(context).addCourse(context);
                        },
                        text: 'اضافه',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
