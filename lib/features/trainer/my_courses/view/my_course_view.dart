import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_appbar.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';

import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/navigation/route_generator.dart';
import '../../../../core/ui/widgets/blur_widget.dart';
import '../../../../core/ui/widgets/custom_rating_bar_widget.dart';
import '../../../../generated/l10n.dart';

class MyCoursesView extends StatefulWidget {
  const MyCoursesView({Key? key}) : super(key: key);

  @override
  State<MyCoursesView> createState() => _MyCoursesViewState();
}

class _MyCoursesViewState extends State<MyCoursesView>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  int tabbed = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        title: Translation.of(context).courses,
      ),
      body: Column(
        children: [
          Container(
            height: 60.h,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          tabbed = 1;
                          tabController!.animateTo(0);
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: tabbed == 1
                                  ? AppColors.accentColorLight
                                  : null,
                              border:
                                  Border.all(color: AppColors.accentColorLight),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )),
                          child: Center(
                            child: CustomText(
                              text: "قيد الأنتظار",
                              color: tabbed == 1
                                  ? AppColors.primaryColorLight
                                  : AppColors.accentColorLight,
                              fontWeight: FontWeight.w600,
                              fontSize: AppConstants.textSize16,
                            ),
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          tabbed = 2;
                          tabController!.animateTo(1);
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: tabbed == 2
                                  ? AppColors.accentColorLight
                                  : null,
                              border:
                                  Border.all(color: AppColors.accentColorLight),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )),
                          child: Center(
                            child: CustomText(
                              text: "فعاله",
                              color: tabbed == 2
                                  ? AppColors.primaryColorLight
                                  : AppColors.accentColorLight,
                              fontWeight: FontWeight.w600,
                              fontSize: AppConstants.textSize16,
                            ),
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          tabbed = 3;
                          tabController!.animateTo(2);
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: tabbed == 3
                                  ? AppColors.accentColorLight
                                  : null,
                              border:
                                  Border.all(color: AppColors.accentColorLight),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )),
                          child: Center(
                            child: CustomText(
                              text: "منتهيه",
                              color: tabbed == 3
                                  ? AppColors.primaryColorLight
                                  : AppColors.accentColorLight,
                              fontWeight: FontWeight.w600,
                              fontSize: AppConstants.textSize16,
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: const <Widget>[
                WaitingList(),
                AcceptedList(),
                RefusedList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaitingList extends StatelessWidget {
  const WaitingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: CardDetails(selectedCard: false),
            );
          }),
    );
  }
}

class AcceptedList extends StatelessWidget {
  const AcceptedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: CardDetails(selectedCard: false),
            );
          }),
    );
  }
}

class RefusedList extends StatelessWidget {
  const RefusedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: CardDetails(selectedCard: true),
            );
          }),
    );
  }
}

class ImageWithNameTrainee extends StatelessWidget {
  const ImageWithNameTrainee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius10),
        image: DecorationImage(
          image: AssetImage(AppConstants.COACH_COVER_IMG),
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
                child: Center(
                  child: CustomText(
                    text: "مصطفي محمد",
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                    fontSize: AppConstants.textSize16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardDetails extends StatelessWidget {
  final bool selectedCard;

  const CardDetails({Key? key, required this.selectedCard}) : super(key: key);

  Widget _buildRatingWidget({
    required double average,
  }) {
    return SizedBox(
      child: Row(
        children: [
          SizedBox(
              height: 16.h,
              child: CustomRatingBarWidget(rate: average, itemSize: 12.w)),
          CustomText(
            text: '$average',
            fontSize: AppConstants.textSize18,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.MyCourseDetailsScreen);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 140.h,
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
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: CustomText(
                              text: "كورس يوجا محترف مخصص لمن لديهم خبره",
                              fontSize: AppConstants.textSize16,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.user,
                                    color: AppColors.lightGrey,
                                    size: 16,
                                  ),
                                  CustomText(
                                    text: "1",
                                    fontSize: AppConstants.textSize16,
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.accentColorLight,
                                  ),
                                ],
                              )))
                        ],
                      ),
                      CustomText(
                        text: "2000 ريال",
                        fontSize: AppConstants.textSize16,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w400,
                        color: AppColors.accentColorLight,
                      ),
                      _buildRatingWidget(average: 4.2),
                      selectedCard
                          ? SizedBox()
                          : CustomText(
                              text: "المده المتبقيه: يوم و 3 ساعات",
                              fontSize: AppConstants.textSize16,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            )
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
                          image: AssetImage(AppConstants.YOGA_IMG),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
