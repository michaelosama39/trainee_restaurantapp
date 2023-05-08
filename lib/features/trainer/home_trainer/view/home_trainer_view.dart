import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainee_restaurantapp/core/common/style/dimens.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/navigation/route_generator.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';
import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/library/carousel/custom_carousel.dart';
import '../../../../core/ui/physics/custom_scroll_physics.dart';
import '../../../../core/ui/widgets/blur_widget.dart';
import '../../../../core/ui/widgets/clock_widget.dart';
import '../../../../core/ui/widgets/custom_button.dart';
import '../../../../core/ui/widgets/title_widget.dart';
import '../../../../generated/l10n.dart';

class HomeTrainerScreen extends StatefulWidget {
  const HomeTrainerScreen({Key? key}) : super(key: key);

  @override
  State<HomeTrainerScreen> createState() => _HomeTrainerScreenState();
}

class _HomeTrainerScreenState extends State<HomeTrainerScreen> {
  Widget trainerProfile() {
    return Container(
      height: 192.h,
      decoration: const BoxDecoration(
        color: AppColors.darkBrownColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dimens.dp10),
            bottomRight: Radius.circular(Dimens.dp10)),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(AppConstants.COACH1_IMAGE),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 23.0, left: 23, right: 23),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CustomText(
                      text: "مصطفي محمد",
                      fontSize: Dimens.dp20,
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    CustomText(
                      text: "الذهبيه",
                      fontSize: Dimens.dp20,
                      color: AppColors.accentColorLight,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                  onPressed: () {},
                  icon: FaIcon(
                   FontAwesomeIcons.solidBell,
                    color: AppColors.white,
                    size: 30,
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCourseItemWidget() {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        //   return CourseView(
        //     courseModel: courseModel,
        //   );
        // }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius12),
            image: DecorationImage(
              image: AssetImage(AppConstants.COACH1_IMAGE),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.white.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 80.h,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    child: BlurWidget(
                      height: 63.h,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "courseModel.name",
                                fontWeight: FontWeight.w500,
                                fontSize: AppConstants.textSize14,
                              ),
                              Gaps.vGap12,
                              CustomText(
                                text: ' ssxx' +
                                    Translation.of(context).saudi_riyal,
                                fontSize: AppConstants.textSize15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.accentColorLight,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16.w,
                    child: SizedBox(
                      height: 28.h,
                      child: CustomElevatedButton(
                        textMaxLines: 1,
                        text: Translation.of(context).book_now,
                        textSize: AppConstants.textSize12,
                        onTap: () {},
                        borderRadius: AppConstants.borderRadius4,
                      ),
                    ),
                  ),
                  Positioned(
                      left: 16.w,
                      bottom: 10.h,
                      child: ClockWidget(
                        duration: 10.0,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMyCourseItemWidget() {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        //   return CourseView(
        //     courseModel: courseModel,
        //   );
        // }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius12),
            image: DecorationImage(
              image: AssetImage(AppConstants.COACH1_IMAGE),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.white.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 120.h,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    child: BlurWidget(
                      height: 100.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 8.w, right: 8.w, top: 14.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "ركوب خيل",
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                  fontSize: AppConstants.textSize16,
                                ),
                                Gaps.hGap4,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.star,
                                        size: 20,
                                        color: AppColors.accentColorLight,
                                      ),
                                    ),
                                    Container(
                                      height: 10,
                                      child: CustomText(
                                        text: "4.2 ",
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppConstants.textSize16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(8.w, 0, 0, 0),
                            child: CustomText(
                              text: "2000 ريال سعودي",
                              fontWeight: FontWeight.w600,
                              color: AppColors.accentColorLight,
                              fontSize: AppConstants.textSize12,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(8.w, 0, 8.w, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "المده المتبقيه: يوم و 3 ساعات",
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white,
                                  fontSize: AppConstants.textSize14,
                                ),
                                InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: AppColors.greenColorButton,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CustomText(
                                          text: 'فعاله',
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            color: AppColors.accentColorLight,
                            height: 7.h,
                            width: 101.w,
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
      ),
    );
  }

  Widget mostWantedCourse() {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: TitleWidget(
              title: "الكورسات الأكثر طلبا",
              subtitleColorTapped: () {
                Navigator.pushNamed(context, Routes.myCourseScreen);
              },
              titleColor: AppColors.accentColorLight,
              subtitle: "اظهار الكل",
            ),
          ),
          Gaps.vGap16,
          Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: CustomCarousel(
              items: List.generate(
                  10,
                  (index) => false
                      ? _buildCourseItemWidget()
                      : _buildMyCourseItemWidget()),
              options: CarouselOptions(
                height: 344.h,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: false,
                scrollPhysics: const CustomScrollPhysics(itemDimension: 1),
                autoPlay: false,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 300.h,
        child: Column(
          children: [
            TitleWidget(
              title: "المتدربين الجدد",
              subtitleColorTapped: () {
                Navigator.pushNamed(context, Routes.traineeScreen);
              },
              subtitle: Translation.of(context).see_all,
              titleColor: AppColors.accentColorLight,
            ),
            Gaps.vGap14,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // widgets.length > 0
                        //     ?
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // widgets.length > 1
                              //     ?
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  // onItemSelected(1);
                                },
                                child: imageWithNameTrainee(),
                              )),
                              // : const SizedBox.shrink(),
                              SizedBox(
                                height: 8.w,
                              ),
                              // widgets.length > 2
                              //     ?
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  //  onItemSelected(2);
                                },
                                child: imageWithNameTrainee(),
                              ))
                              // : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),

                        Expanded(
                            flex: 2,
                            child: GestureDetector(
                                onTap: () {
                                  // onItemSelected(0);
                                },
                                child: imageWithNameTrainee())),
                        //: const SizedBox.shrink(),
                      ],
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
  }

  Widget imageWithNameTrainee() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius10),
        image: DecorationImage(
          image: AssetImage(AppConstants.COACH2_IMAGE),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 35.h,
          child: Stack(
            fit: StackFit.expand,
            children: [
              BlurWidget(
                height: 100.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: CustomText(
                        text: "مصطفي محمد",
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                        fontSize: AppConstants.textSize16,
                      ),
                    ),
                    Gaps.hGap4,
                    Container(
                      color: AppColors.accentColorLight,
                      height: 7.h,
                      width: 101.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget trainerBouquet() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100.h,
        child: Column(
          children: [
            TitleWidget(
              title: "الباقه الحاليه",
              subtitleColorTapped: () {},
              subtitle: "",
              titleColor: AppColors.accentColorLight,
            ),
            Gaps.vGap14,
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
                          gradient: LinearGradient(colors: [
                            AppColors.lightColor,
                            AppColors.accentColorLight
                          ])),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "الباقه الذهبيه",
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                              fontSize: AppConstants.textSize16,
                            ),
                            CustomText(
                              text: "20 ريال سعودي",
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                              fontSize: AppConstants.textSize16,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gaps.hGap16,
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.transparent.withOpacity(0.2)),
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppConstants.blurDegree10)),
                          gradient: LinearGradient(colors: [
                            AppColors.transparent.withOpacity(0.0),
                            AppColors.transparent.withOpacity(0.5)
                          ])),
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward,
                            color: AppColors.white,
                            size: 30,
                          ),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              trainerProfile(),
              Gaps.vGap16,
              mostWantedCourse(),
              Gaps.vGap16,
              _buildSectionWidget(),
              Gaps.vGap16,
              trainerBouquet(),
              Gaps.vGap60,

            ],
          ),
        ),
      ),
    );
  }
}
