import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainee_restaurantapp/core/common/app_colors.dart';
import 'package:trainee_restaurantapp/core/navigation/route_generator.dart';
import 'package:trainee_restaurantapp/core/ui/loader.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/blur_widget.dart';
import 'package:trainee_restaurantapp/features/trainer/profile_details/presentation/trainer_profile_controller/trainer_profile_cubit.dart';

import '../../../../../core/common/style/gaps.dart';
import '../../../../../core/constants/app/app_constants.dart';
import '../../../../../core/ui/widgets/clock_widget.dart';
import '../../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../../core/ui/widgets/custom_button.dart';
import '../../../../../core/ui/widgets/custom_rating_bar_widget.dart';
import '../../../../../core/ui/widgets/custom_text.dart';
import '../../../../../core/ui/widgets/title_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../notification/presentation/view/notification_screen.dart';

class ProfileTrainerScreenView extends StatefulWidget {
  const ProfileTrainerScreenView({super.key});

  @override
  State<ProfileTrainerScreenView> createState() =>
      _ProfileTrainerScreenViewState();
}

class _ProfileTrainerScreenViewState extends State<ProfileTrainerScreenView> {
  @override
  void initState() {
    TrainerProfileCubit.of(context).getTrainerProfile(context);
    TrainerProfileCubit.of(context).getTrainerReviews(context);
    super.initState();
  }

  Widget profileScreenDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300.h,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          image: TrainerProfileCubit.of(context).trainerModel!.imageUrl != null
              ? DecorationImage(
                  image: NetworkImage(
                    TrainerProfileCubit.of(context).trainerModel!.imageUrl ??
                        "",
                  ),
                  fit: BoxFit.cover,
                )
              : const DecorationImage(
                  image: AssetImage(AppConstants.AVATER_IMG),
                ),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 130.h,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: BlurWidget(
                    blurColor: AppColors.grey.withOpacity(0.6),
                    height: 100.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 14.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: TrainerProfileCubit.of(context)
                                        .trainerModel!
                                        .name ??
                                    "",
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                                fontSize: AppConstants.textSize16,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: TrainerProfileCubit.of(context)
                                        .trainerModel!
                                        .specialization!
                                        .text ??
                                    "",
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                                fontSize: AppConstants.textSize14,
                              ),
                              CustomText(
                                text:
                                    "${TrainerProfileCubit.of(context).trainerModel!.hourPrice ?? 0} ${Translation.of(context).pricePerHour}",
                                fontWeight: FontWeight.w600,
                                color: AppColors.accentColorLight,
                                fontSize: AppConstants.textSize12,
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding:
                        //       EdgeInsetsDirectional.fromSTEB(8.w, 0, 8.w, 0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: [
                        //       const FaIcon(
                        //         FontAwesomeIcons.locationDot,
                        //         color: AppColors.accentColorLight,
                        //         size: 14,
                        //       ),
                        //       Gaps.hGap8,
                        //       CustomText(
                        //         text: "جدة,شارع الملك",
                        //         fontWeight: FontWeight.w500,
                        //         color: AppColors.white,
                        //         fontSize: AppConstants.textSize14,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(8.w, 0, 8.w, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.phone,
                                color: AppColors.accentColorLight,
                                size: 14,
                              ),
                              Gaps.hGap8,
                              CustomText(
                                text: TrainerProfileCubit.of(context)
                                        .trainerModel!
                                        .phoneNumber ??
                                    "",
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                                fontSize: AppConstants.textSize14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRateIndicatorWidget(String title, double percent) {
    return Row(
      children: [
        CustomText(
          text: title,
        ),
        Gaps.hGap4,
        SizedBox(
          width: 150.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius10),
            child: LinearProgressIndicator(
              value: percent,
            ),
          ),
        )
      ],
    );
  }

  Widget trainerBouquet() {
    if (TrainerProfileCubit.of(context).trainerModel!.subscription != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 70.h,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(AppConstants.borderRadius10)),
                            gradient: const LinearGradient(colors: [
                              AppColors.lightColor,
                              AppColors.accentColorLight
                            ])),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                text: TrainerProfileCubit.of(context)
                                        .trainerModel!
                                        .subscription!
                                        .name ??
                                    "",
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                                fontSize: AppConstants.textSize16,
                              ),
                              CustomText(
                                text:
                                    "${TrainerProfileCubit.of(context).trainerModel!.subscription!.fee ?? 0} ${Translation.of(context).saudi_riyal}",
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                                fontSize: AppConstants.textSize16,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // widgets.length > 3
                    //     ?
                    // : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildCommentItemWidget({
    required String body,
    required String name,
    required String image,
    required String date,
  }) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 56.h,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadius8),
                    child: Image.network(
                      image,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(AppConstants.COACH3_IMAGE);
                      },
                      height: 56.h,
                      width: 46.w,
                    ),
                  ),
                  Gaps.hGap8,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CustomText(
                        text: name,
                        fontWeight: FontWeight.bold,
                        fontSize: AppConstants.textSize12,
                      ),
                      CustomText(text: date.substring(0, 10))
                    ],
                  ),
                ],
              ),
            ),
            Gaps.vGap8,
            CustomText(
              text: body,
              fontSize: AppConstants.textSize10,
              maxLines: 2,
              height: 2.5,
              textOverflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCommentsWidget() {
    return BlocBuilder<TrainerProfileCubit, TrainerProfileState>(
      builder: (context, state) {
        if (state is GetTrainerReviewsLoaded) {
          return SizedBox(
            height: 128.h,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return BlurWidget(
                    width: 268.w,
                    height: 128.h,
                    borderRadius: AppConstants.borderRadius4,
                    child: _buildCommentItemWidget(
                        image: state.reviews[index].reviewer!.imageUrl ?? "",
                        date: state.reviews[index].creationTime ?? "",
                        name: state.reviews[index].reviewer!.name ?? "",
                        body: state.reviews[index].comment ?? ""),
                  );
                },
                separatorBuilder: (context, index) => Gaps.hGap16,
                itemCount: state.reviews.length),
          );
        } else if (state is GetTrainerReviewsLoading) {
          return const Loader();
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildRatingWidget({
    required double average,
    required double firstRate,
    required double secondRate,
    required double thirdRate,
    required double forthRate,
    required double fifthRate,
  }) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: TitleWidget(
              title: Translation.of(context).rating_average,
              subtitleColorTapped: _rate,
              titleColor: AppColors.white,
              subtitleColor: AppColors.accentColorLight,
              subtitleSize: AppConstants.textSize14,
            ),
          ),
          Gaps.vGap24,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Row(
              children: [
                Column(
                  children: [
                    CustomText(
                      text: '$average',
                      fontSize: AppConstants.textSize48,
                      color: AppColors.accentColorLight,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                        height: 16.h,
                        child: CustomRatingBarWidget(
                            rate: average, itemSize: 12.w)),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    _buildRateIndicatorWidget('5', firstRate),
                    _buildRateIndicatorWidget('4', secondRate),
                    _buildRateIndicatorWidget('3', thirdRate),
                    _buildRateIndicatorWidget('2', forthRate),
                    _buildRateIndicatorWidget('1', fifthRate),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionWidget(bool subbed) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 122.h,
            decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius:
                    BorderRadius.circular(AppConstants.borderRadius10)),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "test",
                    fontSize: AppConstants.textSize16,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      CustomText(
                        text: "test",
                        color: AppColors.accentColorLight,
                        fontSize: AppConstants.textSize14,
                        fontWeight: FontWeight.bold,
                      ),
                      const Spacer(),
                      CustomText(
                        text: 'test' + ' ريال سعودي/ساعة',
                        fontSize: AppConstants.textSize14,
                        color: AppColors.accentColorLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const Spacer(),
                  subbed
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ImageIcon(
                              const AssetImage(
                                AppConstants.CHAT_ICON,
                              ),
                              color: AppColors.white,
                              size: 20.h,
                            ),
                            ImageIcon(
                              const AssetImage(
                                AppConstants.PHONE_CALL_ICON,
                              ),
                              color: AppColors.white,
                              size: 20.h,
                            ),
                            ImageIcon(
                              const AssetImage(
                                AppConstants.VIDEO_CALL_ICON,
                              ),
                              color: AppColors.white,
                              size: 20.h,
                            ),
                          ],
                        )
                      : const Spacer(),
                ],
              ),
            ),
          ),
        ),
        !subbed
            ? Positioned(
                bottom: 8.h,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 217.w,
                      height: 44.h,
                      child: CustomElevatedButton(
                        text: Translation.of(context).subscribe,
                        onTap: _subscribe,
                      ),
                    ),
                  ],
                ))
            : const SizedBox.shrink()
      ],
    );
  }

  void _subscribe() {
    showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.transparent,
          body: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: BlurWidget(
              blurColor: AppColors.transparent,
              blurDegree: AppConstants.blurDegree10,
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadius10),
                    child: Container(
                      width: 0.9.sw,
                      color: AppColors.grey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 24.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: Translation.of(context).course_subscription,
                              fontSize: AppConstants.textSize16,
                              fontWeight: FontWeight.bold,
                            ),
                            Gaps.vGap24,
                            CustomText(
                              text: Translation.of(context).subscription_type,
                              fontSize: AppConstants.textSize16,
                            ),
                            Container(
                              height: 44.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      AppConstants.borderRadius6)),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: AppColors.grey,
                                ),
                                child: DropdownButton<String>(
                                  items: [],
                                  onChanged: (c) {},
                                  isExpanded: true,
                                  underline: const SizedBox.shrink(),
                                ),
                              ),
                            ),
                            Gaps.vGap24,
                            CustomText(
                              text: Translation.of(context).weekly_hours,
                              fontSize: AppConstants.textSize16,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.white),
                                  borderRadius: BorderRadius.circular(
                                      AppConstants.borderRadius6)),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            Gaps.vGap40,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 44.h,
                                    width: 217.w,
                                    child: CustomElevatedButton(
                                      text: Translation.of(context).subscribe,
                                      onTap: _setSubscriptionInfo,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _setSubscriptionInfo() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.transparent,
          body: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: BlurWidget(
              blurColor: AppColors.transparent,
              blurDegree: AppConstants.blurDegree10,
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadius10),
                    child: Container(
                      width: 0.9.sw,
                      color: AppColors.grey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 24.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: Translation.of(context).bill,
                              fontSize: AppConstants.textSize16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.accentColorLight,
                            ),
                            Gaps.vGap24,
                            CustomText(
                              text: " sn.courses.first.title",
                              fontSize: AppConstants.textSize14,
                              fontWeight: FontWeight.w500,
                            ),
                            Gaps.vGap8,
                            Row(
                              children: [
                                CustomText(
                                  text: "sn.courses.first.cost.toString()" +
                                      Translation.of(context).saudi_riyal,
                                  fontSize: AppConstants.textSize15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.accentColorLight,
                                ),
                                const Spacer(),
                                const ClockWidget(duration: 20.0)
                              ],
                            ),
                            const Divider(
                              color: AppColors.white,
                              thickness: 1,
                            ),
                            Gaps.vGap24,
                            CustomText(
                              text: Translation.of(context).payment_way,
                              fontSize: AppConstants.textSize14,
                            ),
                            Gaps.vGap16,
                            Row(
                              children: [
                                Image.asset(
                                  AppConstants.MASTER_CARD_IMG,
                                  width: 32.w,
                                ),
                                Gaps.hGap4,
                                Column(
                                  children: [
                                    CustomText(
                                      text: 'ماستر كارد',
                                      fontSize: AppConstants.textSize14,
                                    ),
                                    CustomText(
                                      text: '32423*****',
                                      fontSize: AppConstants.textSize14,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Gaps.vGap40,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 44.h,
                                    width: 217.w,
                                    child: CustomElevatedButton(
                                      text: Translation.of(context).pay,
                                      onTap: () {},
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  TextEditingController commentController = TextEditingController();

  void _rate() {
    showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.transparent,
          body: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: BlurWidget(
              blurColor: AppColors.transparent,
              blurDegree: AppConstants.blurDegree10,
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadius10),
                    child: Container(
                      width: 0.8.sw,
                      color: AppColors.grey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 24.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: Translation.of(context).whats_ur_rating,
                              fontSize: AppConstants.textSize16,
                              fontWeight: FontWeight.bold,
                            ),
                            Gaps.vGap16,
                            Center(
                              child: CustomRatingBarWidget(
                                rate: TrainerProfileCubit.of(context)
                                        .trainerModel!
                                        .rate ??
                                    0.0,
                                itemSize: 30.w,
                                onRatingUpdate: (value) {
                                  setState(() {
                                    // sn.rate = value.toInt();
                                  });
                                },
                              ),
                            ),
                            Gaps.vGap24,
                            CustomText(
                              text: Translation.of(context).whats_ur_opinion,
                              fontSize: AppConstants.textSize16,
                            ),
                            Gaps.vGap8,
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.white),
                                  borderRadius: BorderRadius.circular(
                                      AppConstants.borderRadius6)),
                              child: TextFormField(
                                controller: commentController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                maxLines: 4,
                              ),
                            ),
                            Gaps.vGap40,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                    height: 30.h,
                                    width: 104.w,
                                    child: CustomTextButton(
                                      text: Translation.of(context).skip,
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    )),
                                SizedBox(
                                    height: 30.h,
                                    width: 104.w,
                                    child: CustomElevatedButton(
                                      text: Translation.of(context).send,
                                      onTap: () {
                                        // CourseCubit.get(context)
                                        //     .createReview(
                                        //     RefId: sn.coachEntity.id!,
                                        //     comment: commentController
                                        //         .text,
                                        //     rate: sn.rate);
                                      },
                                    )),
                              ],
                            )
                            // BlocProvider(
                            //   create: (context) => CourseCubit(),
                            //   child: BlocConsumer<CourseCubit, CourseState>(
                            //     listener: (context, state) {
                            //       if (state is ErrorCreateReviewData) {
                            //         Navigator.pop(context);
                            //         showErrorSnackBar(
                            //           context: context, message: "You already reviewed this item",);
                            //
                            //       }
                            //       state is SuccessCreateReviewData
                            //           ? Navigator.pop(context)
                            //           : null;
                            //     },
                            //     builder: (context, state) {
                            //       return
                            //         Row(
                            //         mainAxisAlignment: MainAxisAlignment.end,
                            //         children: [
                            //           SizedBox(
                            //               height: 30.h,
                            //               width: 104.w,
                            //               child: CustomTextButton(
                            //                 text: Translation.of(context).skip,
                            //                 onTap: () {
                            //                   Nav.pop();
                            //                 },
                            //               )),
                            //           SizedBox(
                            //               height: 30.h,
                            //               width: 104.w,
                            //               child: CustomElevatedButton(
                            //                 text: Translation.of(context).send,
                            //                 onTap: () {
                            //                   CourseCubit.get(context)
                            //                       .createReview(
                            //                       RefId: sn.coachEntity.id!,
                            //                       comment: commentController
                            //                           .text,
                            //                       rate: sn.rate);
                            //                 },
                            //               )),
                            //         ],
                            //       );
                            //     },
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget myFile() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              text: Translation.of(context).myFiles,
              color: AppColors.accentColorLight,
              fontWeight: FontWeight.w700,
              fontSize: AppConstants.textSize18),
          Gaps.vGap12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: Translation.of(context).cv,
                color: AppColors.accentColorLight,
                fontSize: AppConstants.textSize14,
                fontWeight: FontWeight.w700,
              ),
              CustomText(
                text: TrainerProfileCubit.of(context).trainerModel!.cvUrl ?? "",
                color: AppColors.white,
                fontSize: AppConstants.textSize14,
                fontWeight: FontWeight.w700,
              )
            ],
          ),
          // Gaps.vGap12,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     CustomText(
          //       text: Translation.of(context).certificate,
          //       color: AppColors.accentColorLight,
          //       fontSize: AppConstants.textSize14,
          //       fontWeight: FontWeight.w700,
          //     ),
          //     CustomText(
          //       text: TrainerProfileCubit.of(context).trainerModel!.cvUrl ?? "",
          //       color: AppColors.white,
          //       fontSize: AppConstants.textSize14,
          //       fontWeight: FontWeight.w700,
          //     )
          //   ],
          // )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        title: Translation.of(context).welcome,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.editProfileScreen);
              },
              child:
                  const ImageIcon(AssetImage(AppConstants.EDIT_PROFILE_ICON))),
          Gaps.hGap16,
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ));
            },
            child: const Icon(
              Icons.notifications,
              color: AppColors.white,
            ),
          ),
          Gaps.hGap20,
        ],
      ),
      body: BlocBuilder<TrainerProfileCubit, TrainerProfileState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (TrainerProfileCubit.of(context).trainerModel != null) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    profileScreenDetails(),
                    myFile(),
                    trainerBouquet(),
                    Gaps.vGap24,
                    _buildRatingWidget(
                      average:
                          TrainerProfileCubit.of(context).trainerModel!.rate ??
                              0.0,
                      fifthRate: TrainerProfileCubit.of(context)
                          .trainerModel!
                          .ratingDetails!
                          .i5!
                          .toDouble(),
                      firstRate: TrainerProfileCubit.of(context)
                          .trainerModel!
                          .ratingDetails!
                          .i1!
                          .toDouble(),
                      forthRate: TrainerProfileCubit.of(context)
                          .trainerModel!
                          .ratingDetails!
                          .i4!
                          .toDouble(),
                      secondRate: TrainerProfileCubit.of(context)
                          .trainerModel!
                          .ratingDetails!
                          .i2!
                          .toDouble(),
                      thirdRate: TrainerProfileCubit.of(context)
                          .trainerModel!
                          .ratingDetails!
                          .i3!
                          .toDouble(),
                    ),
                    Gaps.vGap24,
                    _buildCommentsWidget(),
                    Gaps.vGap60,
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
