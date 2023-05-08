import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/navigation/route_generator.dart';
import '../../../../core/ui/widgets/blur_widget.dart';
import '../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../core/ui/widgets/custom_rating_bar_widget.dart';
import '../../../../core/ui/widgets/custom_text.dart';
import '../../../../core/ui/widgets/precentage_show.dart';
import '../../../../core/ui/widgets/title_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../trainer/trainee/view/trainee_profile_view.dart';

class RestaurantProfile extends StatefulWidget {
  const RestaurantProfile({super.key});

  @override
  State<RestaurantProfile> createState() => _RestaurantProfileState();
}

class _RestaurantProfileState extends State<RestaurantProfile> {
  Widget _buildSubscriptionWidget() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 147.h,
            decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius:
                    BorderRadius.circular(AppConstants.borderRadius10)),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: CustomText(
                      text: "موتشي",
                      fontSize: AppConstants.textSize16,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.phone,
                                color: AppColors.accentColorLight,
                                size: 14,
                              ),
                              Gaps.hGap8,
                              CustomText(
                                maxLines: 2,
                                text: "4561234566",
                                color: AppColors.white,
                                fontSize: AppConstants.textSize14,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.locationDot,
                                color: AppColors.accentColorLight,
                                size: 14,
                              ),
                              Gaps.hGap8,
                              CustomText(
                                maxLines: 2,
                                text: "جده, شارع الملك",
                                color: AppColors.white,
                                fontSize: AppConstants.textSize14,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CustomText(
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    textOverflow: TextOverflow.ellipsis,
                    text:
                        "مطعم مختص بالأطباق الصحيه ووجبات فطور وغداء وعشاء يقدم الفواكه الصحيه والسلطات جميع الوجبات موجوده لدينا موجود لدينا تنوع كبير ف الأطباق",
                    color: AppColors.white,
                    fontSize: AppConstants.textSize12,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget traineeCard({required context}) {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.traineeProfileScreen);
      },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "العدد: ",
                        color: AppColors.white,
                        fontSize: AppConstants.textSize14,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: " 4",
                        color: AppColors.accentColorLight,
                        fontSize: AppConstants.textSize14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          text: "2000 ريال",
                          fontSize: AppConstants.textSize14,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w500,
                          color: AppColors.accentColorLight,
                        ),
                      ),
                      Expanded(
                        child: CustomText(
                          text: "${DateTime.now().toString().substring(0, 10)}",
                          fontSize: AppConstants.textSize14,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w500,
                          color: AppColors.backgroundColorLight,
                        ),
                      ),
                    ],
                  ),
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
    );
  }

  final List<String> _restaurantProfileConstantList = [
    "رقم الهاتف",
    "رقم السجل التجاري",
    "السجيل التجاري",
    "مدير المطعم",
    "البلد",
    "المدينه",
    "الشارع",
    "رقم البناء"
  ];
  final List<String> _restaurantProfileMochitDataList = [
    "01011153207",
    "4665122953322",
    "السجل التجاري.pdf",
    "مصطفي محمد",
    "السعوديه",
    "الرياض",
    "شارع الملك طلال",
    "بناء رقم 489"
  ];
  final List<WorkingHoursMochitoData>
      _restaurantProfileMochitWorkingHoursDataList = [
    WorkingHoursMochitoData(start: "8:00 Am", day: "السبت :", end: "8:00 PM"),
    WorkingHoursMochitoData(start: "8:00 Am", day: "الأحد :", end: "8:00 PM"),
    WorkingHoursMochitoData(start: "8:00 Am", day: "الاتنين :", end: "8:00 PM"),
    WorkingHoursMochitoData(
        start: "8:00 Am", day: "الثلاثاء :", end: "8:00 PM"),
    WorkingHoursMochitoData(
        start: "8:00 Am", day: "الاربعاء :", end: "8:00 PM"),
  ];

  Widget _restaurantProfileData() {
    return SizedBox(
      height: 450.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: _restaurantProfileConstantList[index],
                      color: AppColors.accentColorLight,
                      fontWeight: FontWeight.w500,
                      fontSize: AppConstants.textSize14,
                    ),
                    CustomText(
                      text: _restaurantProfileMochitDataList[index],
                      color: AppColors.white.withOpacity(0.6),
                      fontWeight: FontWeight.w500,
                      fontSize: AppConstants.textSize12,
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 2,
                color: AppColors.grey,
              );
            },
            itemCount: 8),
      ),
    );
  }

  Widget _restaurantProfileWorkingHours() {
    return SizedBox(
      height: 320.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: CustomText(
              text: "أيام وساعات العمل",
              fontWeight: FontWeight.w600,
              fontSize: AppConstants.textSize18,
              color: AppColors.white,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: AppColors.accentColorLight,
                                  ),
                                ),
                                Gaps.hGap8,
                                CustomText(
                                  text:
                                      _restaurantProfileMochitWorkingHoursDataList[
                                              index]
                                          .day,
                                  color: AppColors.accentColorLight,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppConstants.textSize14,
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText(
                                  text:
                                      "من ${_restaurantProfileMochitWorkingHoursDataList[index].start}",
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppConstants.textSize14,
                                ),
                                CustomText(
                                  text:
                                      "الي ${_restaurantProfileMochitWorkingHoursDataList[index].end}",
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppConstants.textSize14,
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 2,
                      color: AppColors.grey,
                    );
                  },
                  itemCount:
                      _restaurantProfileMochitWorkingHoursDataList.length),
            ),
          ),
        ],
      ),
    );
  }

  Widget _restaurantProfileSocialMedia() {
    return SizedBox(
      height: 300.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: CustomText(
              text: "مواقع التواصل الأجتماعي",
              fontWeight: FontWeight.w600,
              fontSize: AppConstants.textSize18,
              color: AppColors.white,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                            color: AppColors.accentColorLight,
                            child: Icon(
                              FontAwesomeIcons.facebook,
                              color: Colors.white,
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 2,
                              color: AppColors.grey,
                            ),
                          ),
                          Expanded(
                              flex: 10,
                              child: Container(
                                child: CustomText(
                                  textAlign: TextAlign.end,
                                  text: "mochto@facebook.com",
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppConstants.textSize14,
                                ),
                              )),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 2,
                      color: AppColors.grey,
                    );
                  },
                  itemCount: 4),
            ),
          ),
        ],
      ),
    );
  }

  TextEditingController commentController = TextEditingController();

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
              child: ImageIcon(AssetImage(AppConstants.EDIT_PROFILE_ICON))),
          Gaps.hGap16,
          const Icon(
            Icons.notifications,
            color: AppColors.white,
          ),
          Gaps.hGap20,
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: CustomSliverDelegate(
              image: AppConstants.RESTAURANT_IMG2,
              expandedHeight: 220.h,
              child: _buildSubscriptionWidget(),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Gaps.vGap10,
                  _restaurantProfileData(),
                  _restaurantProfileWorkingHours(),
                  _restaurantProfileSocialMedia()
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class WorkingHoursMochitoData {
  final String day;
  final String start;
  final String end;

  WorkingHoursMochitoData({
    required this.start,
    required this.day,
    required this.end,
  });
}
