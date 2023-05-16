import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/navigation/route_generator.dart';
import '../../../../core/ui/widgets/blur_widget.dart';
import '../../../../core/ui/widgets/custom_rating_bar_widget.dart';
import '../../../../core/ui/widgets/custom_text.dart';
import '../../../../core/ui/widgets/precentage_show.dart';
import '../../../../core/ui/widgets/title_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../trainer/trainee/presentation/view/trainee_profile_view.dart';

class MyPlateDetails extends StatefulWidget {
  @override
  State<MyPlateDetails> createState() => _MyPlateDetailsState();
}

class _MyPlateDetailsState extends State<MyPlateDetails> {
  Widget _buildSubscriptionWidget() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Container(
                height: 85.h,
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
                          text: "طبق دجاج بالخضار",
                          fontSize: AppConstants.textSize16,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const Spacer(),
                      CustomText(
                        maxLines: 2,
                        text:
                            "طبق شوفان , ربع كوب لوز مقطع وملعقتان صغيرتان زنجبيل و نصف كوب عسل نحل اربع ملاعق زبدة ورشه ملح , نصف كوب فاكهه , مجففه زبيب , مشمش, تفاح مجفف",
                        color: AppColors.white,
                        fontSize: AppConstants.textSize12,
                        fontWeight: FontWeight.w500,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              Gaps.vGap4,
              Container(
                decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadius10)),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "عدد الطلبات: ",
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
                      CustomText(
                        text: "المده المتبقيه: يوم و 3 ساعات",
                        fontSize: AppConstants.textSize14,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomText(
                                  text: "60 جرام",
                                  fontSize: AppConstants.textSize14,
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.accentColorLight,
                                ),
                                Gaps.hGap8,
                                SvgPicture.asset(
                                  height: 20.h,
                                  AppConstants.WEIGHT_ICON,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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

  Widget _buildCommentItemWidget({
    required String body,
    required String name,
    required String image,
    required String date,
  }) {
    return Container(
      child: Padding(
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
                      child: Image.asset(
                        image,
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
      ),
    );
  }

  Widget _buildCommentsWidget() {
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: SizedBox(
        height: 128.h,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return BlurWidget(
                  width: 268.w,
                  height: 128.h,
                  borderRadius: AppConstants.borderRadius4,
                  child: _buildCommentItemWidget(
                    image: AppConstants.COACH3_IMAGE,
                    date: "10-10-2023",
                    name: "مصطفي محمد",
                    body: "لا يوجد تعليق",
                  ));
            },
            separatorBuilder: (context, index) => Gaps.hGap16,
            itemCount: 3),
      ),
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
                          text: "${DateTime.now().toString().substring(0,10)}",
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

  Widget _trainee() {
    return Container(
      height: 200.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            TitleWidget(
              title: "الطلبات",
              subtitleColorTapped: () {},
              titleColor: AppColors.white,
              subtitleColor: AppColors.accentColorLight,
              subtitle: "اظهار الكل",
              subtitleSize: AppConstants.textSize14,
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: traineeCard(context: context),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
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
              subtitleColorTapped: () {},
              titleColor: AppColors.white,
              subtitleColor: AppColors.accentColorLight,
              subtitle: "",
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

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: CustomSliverDelegate(
            image: AppConstants.YOGA_IMG,
            expandedHeight: 260.h,
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
                _trainee(),
                _buildRatingWidget(
                    average: 2.4,
                    fifthRate: 4.2,
                    firstRate: 1.3,
                    forthRate: 2.2,
                    secondRate: 2.5,
                    thirdRate: 1),
                Gaps.vGap24,
                _buildCommentsWidget(),
                Gaps.vGap24,
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
