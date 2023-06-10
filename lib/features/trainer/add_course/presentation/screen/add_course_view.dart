import 'dart:io';

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
import '../../../../../core/models/categories_model.dart';
import '../../../../../core/ui/widgets/custom_text_field.dart';

class AddCourseView extends StatefulWidget {
  AddCourseView({super.key});

  @override
  State<AddCourseView> createState() => _AddCourseViewState();
}

class _AddCourseViewState extends State<AddCourseView> {
  uploadSignUpFile(
      {required void Function()? onTap, required String text, File? file}) {
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
                radius: const Radius.circular(10),
                borderType: BorderType.Rect,
                strokeWidth: 3,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((Dimens.dp12))),
                  height: Dimens.dp80.h,
                  width: double.infinity,
                  child: Center(
                    child: file == null
                        ? const Center(
                            child: FaIcon(
                              FontAwesomeIcons.upload,
                              color: AppColors.accentColorLight,
                              size: Dimens.dp40,
                            ),
                          )
                        : Image.file(file),
                  ),
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
    return BlocProvider(
      create: (context) => AddCourseCubit()..getCategories(),
      child: BlocBuilder<AddCourseCubit, AddCourseState>(
        buildWhen: (previous, current) =>
            previous != current ||
            current is AddCourseLoading ||
            current is UploadSignUpFileState,
        builder: (context, state) {
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
                          text: "أضافة كورس",
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: AppConstants.textSize18,
                        ),
                        Gaps.vGap16,
                        EmailTextField(
                          text: "اسم الكورس باللغه العربيه",
                          onFiledSubmitted: () {
                            FocusScope.of(context).requestFocus(
                                AddCourseCubit.of(context).enNameFocusNode);
                          },
                          textInputAction: TextInputAction.next,
                          controller:
                              AddCourseCubit.of(context).arNameController,
                          focusNode: AddCourseCubit.of(context).arNameFocusNode,
                        ),
                        Gaps.vGap16,
                        EmailTextField(
                          text: "اسم الكورس باللغه الانجليزيه",
                          onFiledSubmitted: () {
                            FocusScope.of(context).requestFocus(
                                AddCourseCubit.of(context).feeFocusNode);
                          },
                          textInputAction: TextInputAction.next,
                          controller:
                              AddCourseCubit.of(context).enNameController,
                          focusNode: AddCourseCubit.of(context).enNameFocusNode,
                        ),
                        Gaps.vGap16,
                        uploadSignUpFile(
                          text: "ارفق صوره تعبيريه عن الكورس",
                          file: AddCourseCubit.of(context).file,
                          onTap: () async {
                            AddCourseCubit.of(context).file =
                                await AddCourseCubit.of(context).getFile();
                            AddCourseCubit.of(context).uploadImage(
                                context, AddCourseCubit.of(context).file!);
                            AddCourseCubit.of(context)
                                .emit(UploadSignUpFileState());
                          },
                        ),
                        Gaps.vGap16,
                        DropdownButton<Items>(
                          isExpanded: true,
                          value: AddCourseCubit.of(context).dropdownValueCate,
                          hint: const Text(
                            'اختار التصنيف',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          dropdownColor: Colors.grey,
                          underline: Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          onChanged: (Items? value) {
                            setState(() {
                              AddCourseCubit.of(context).dropdownValueCate =
                                  value!;
                            });
                          },
                          items: AddCourseCubit.of(context)
                              .listOfCates
                              .map<DropdownMenuItem<Items>>((Items value) {
                            return DropdownMenuItem<Items>(
                              value: value,
                              child: Text(
                                value.name ?? '',
                              ),
                            );
                          }).toList(),
                        ),
                        Gaps.vGap16,
                        EmailTextField(
                          text: "سعرالكورس",
                          onFiledSubmitted: () {
                            FocusScope.of(context).requestFocus(
                                AddCourseCubit.of(context)
                                    .discountPercentageFocusNode);
                          },
                          textInputAction: TextInputAction.next,
                          controller: AddCourseCubit.of(context).feeController,
                          focusNode: AddCourseCubit.of(context).feeFocusNode,
                        ),
                        Gaps.vGap16,
                        EmailTextField(
                          text: "نسبه الخصم",
                          onFiledSubmitted: () {
                            FocusScope.of(context).requestFocus(
                                AddCourseCubit.of(context)
                                    .trainingHoursCountFocusNode);
                          },
                          textInputAction: TextInputAction.next,
                          controller: AddCourseCubit.of(context)
                              .discountPercentageController,
                          focusNode: AddCourseCubit.of(context)
                              .discountPercentageFocusNode,
                        ),
                        Gaps.vGap16,
                        EmailTextField(
                          text: "عدد الساعات",
                          onFiledSubmitted: () {
                            FocusScope.of(context).requestFocus(
                                AddCourseCubit.of(context)
                                    .arDescriptionFocusNode);
                          },
                          textInputAction: TextInputAction.next,
                          controller: AddCourseCubit.of(context)
                              .trainingHoursCountController,
                          focusNode: AddCourseCubit.of(context)
                              .trainingHoursCountFocusNode,
                        ),
                        Gaps.vGap16,
                        EmailTextField(
                          text: "تفاصيل الكورس باللغه العربيه",
                          onFiledSubmitted: () {
                            FocusScope.of(context).requestFocus(
                                AddCourseCubit.of(context)
                                    .enDescriptionFocusNode);
                          },
                          textInputAction: TextInputAction.next,
                          controller: AddCourseCubit.of(context)
                              .arDescriptionController,
                          focusNode:
                              AddCourseCubit.of(context).arDescriptionFocusNode,
                        ),
                        Gaps.vGap16,
                        EmailTextField(
                          text: "تفاصيل الكورس باللغه الانجليزيه",
                          onFiledSubmitted: () {
                            // FocusScope.of(context).requestFocus(passwordFocusNode);
                          },
                          textInputAction: TextInputAction.next,
                          controller: AddCourseCubit.of(context)
                              .enDescriptionController,
                          focusNode:
                              AddCourseCubit.of(context).enDescriptionFocusNode,
                        ),
                        Gaps.vGap16,
                        // EmailTextField(
                        //   text: "عدد المشتركين",
                        //   onFiledSubmitted: () {
                        //     // FocusScope.of(context).requestFocus(passwordFocusNode);
                        //   },
                        //   textInputAction: TextInputAction.next,
                        //   controller: commercialNumberController,
                        //   focusNode: commercialNumber,
                        // ),
                        // Gaps.vGap16,
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
                                AddCourseCubit.of(context)
                                    .addCourse(context);
                              },
                              text: 'اضافه',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
