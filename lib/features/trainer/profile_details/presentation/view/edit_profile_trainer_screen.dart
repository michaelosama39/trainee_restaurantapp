import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:trainee_restaurantapp/features/trainer/profile_details/presentation/trainer_profile_controller/trainer_profile_cubit.dart';
import '../../../../../core/common/app_colors.dart';
import '../../../../../core/common/style/dimens.dart';
import '../../../../../core/common/style/gaps.dart';
import '../../../../../core/constants/app/app_constants.dart';
import '../../../../../core/navigation/nav.dart';
import '../../../../../core/ui/loader.dart';
import '../../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../../core/ui/widgets/custom_button.dart';
import '../../../../../core/ui/widgets/custom_text.dart';
import '../../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../../navigator_home/view/navigator_home_view.dart';
import 'map_edit_user_profile.dart';

class EditProfileScreenContent extends StatefulWidget {
  @override
  State<EditProfileScreenContent> createState() =>
      _EditProfileScreenContentState();
}

class _EditProfileScreenContentState extends State<EditProfileScreenContent> {
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
                dashPattern: const [5, 3],
                radius: const Radius.circular(10),
                borderType: BorderType.Rect,
                strokeWidth: 1,
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

  @override
  void initState() {
    TrainerProfileCubit.of(context).getTrainerProfile(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        title: Translation.of(context).edit_profile,
      ),
      body: BlocConsumer<TrainerProfileCubit, TrainerProfileState>(
        listener: (context, state) {
          print('state 1 $state');
          TrainerProfileCubit.of(context).imageUrl =
              TrainerProfileCubit.of(context).trainerModel!.imageUrl ?? '';
          TrainerProfileCubit.of(context).nameController.text =
              TrainerProfileCubit.of(context).trainerModel!.name ?? '';
          TrainerProfileCubit.of(context).phoneController.text =
              TrainerProfileCubit.of(context).trainerModel!.phoneNumber ?? '';
          TrainerProfileCubit.of(context).idNumberController.text =
              TrainerProfileCubit.of(context)
                  .trainerModel!
                  .specializationId
                  .toString();
          TrainerProfileCubit.of(context).hourRateController.text =
              TrainerProfileCubit.of(context).trainerModel!.hourPrice ?? '';
          TrainerProfileCubit.of(context).coachSpecializationController.text =
              TrainerProfileCubit.of(context)
                      .trainerModel!
                      .specialization!
                      .text ??
                  '';
          TrainerProfileCubit.of(context).cvUrl =
              TrainerProfileCubit.of(context).trainerModel!.cvUrl ?? '';
          // TrainerProfileCubit.of(context).experienceFiles = TrainerProfileCubit.of(context).trainerModel!.experienceFiles!.first;
        },
        builder: (context, state) {
          print('state 2 $state');
          if (state is GetTrainerProfileLoading) {
            return const Loader();
          } else {
            return SizedBox(
              height: 1.sh,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      _buildImageWidget(),
                      SizedBox(
                        height: 55.h,
                      ),
                      _buildTextFiledWidget(
                          title: Translation.of(context).full_name,
                          textEditingController:
                              TrainerProfileCubit.of(context).nameController),
                      Gaps.vGap24,
                      _buildTextFiledWidget(
                          title: Translation.of(context).phone,
                          isPhoneNumber: true,
                          textEditingController:
                              TrainerProfileCubit.of(context).phoneController),
                      Gaps.vGap24,
                      _buildTextFiledWidget(
                          title: Translation.of(context).idNumber,
                          textEditingController: TrainerProfileCubit.of(context)
                              .idNumberController),
                      Gaps.vGap24,
                      _buildTextFiledWidget(
                          title: Translation.of(context).hourRate,
                          textEditingController: TrainerProfileCubit.of(context)
                              .hourRateController),
                      Gaps.vGap24,
                      _buildTextFiledWidget(
                          title: Translation.of(context).coach_specialization,
                          textEditingController: TrainerProfileCubit.of(context)
                              .coachSpecializationController),
                      Gaps.vGap24,
                      uploadSignUpFile(
                          text: Translation.of(context).cV, onTap: () {}),
                      Gaps.vGap8,
                      uploadSignUpFile(
                          onTap: () {},
                          text:
                              Translation.of(context).experienceCertification),
                      // Gaps.vGap8,
                      // _buildTextFiledWidget(
                      //     title: Translation.of(context).cityName,
                      //     textEditingController: heightController),
                      // Gaps.vGap24,
                      // _buildTextFiledWidget(
                      //     title: Translation.of(context).details,
                      //     textEditingController: heightController),
                      Gaps.vGap24,
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              final LatLng position = await Navigator.push(
                                  context, MaterialPageRoute(builder: (_) {
                                return MapScreen();
                              }));
                              print("pos:${position.latitude}");
                            },
                            child: CustomText(
                              text: "حدد موقعك علي الخريطه ",
                              color: AppColors.accentColorLight,
                              fontSize: AppConstants.textSize16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      Gaps.vGap24,
                      SizedBox(
                        height: 44.h,
                        width: 217.w,
                        child: CustomElevatedButton(
                          text: Translation.of(context).save,
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NavigatorScreen(homeType: 1)),
                                    (route) => false);
                            // TrainerProfileCubit.of(context)
                            //     .updateTrainerProfile(context);
                          },
                          textSize: AppConstants.textSize20,
                          borderRadius: AppConstants.borderRadius4,
                        ),
                      ),
                      Gaps.vGap24,
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  late final XFile? image;

  Widget _buildImageWidget() {
    return Container(
      height: 0.52.sh,
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius8),
        // image: DecorationImage(
        //     image: FileImage(
        //        image != null ? File(image!.path) :
        //       File(''),
        //     ),
        //     fit: BoxFit.cover),
      ),
      child: Container(
        color: AppColors.primaryColorLight.withOpacity(0.7),
        child: Center(
          child: GestureDetector(
            onTap: () async {},
            child: ImageIcon(
              const AssetImage(AppConstants.CAMERA_ICON),
              color: AppColors.white,
              size: 104.w,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFiledWidget(
      {required String title,
      bool isPhoneNumber = false,
      required TextEditingController textEditingController}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: AppConstants.textSize16,
        ),
        Gaps.vGap4,
        isPhoneNumber
            ? Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.white,
                    ),
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadius6)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: PhoneNumberTextField(
                    border: InputBorder.none,
                    hint: title,
                    textEditingController: textEditingController,
                    onInputChanged: (p0) {},
                  ),
                ),
              )
            : TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: title,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: AppColors.white,
                  )),
                  disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: AppColors.white,
                  )),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: AppColors.white,
                  )),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: AppColors.white,
                  )),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: AppColors.white,
                  )),
                ),
              ),
      ],
    );
  }
}
