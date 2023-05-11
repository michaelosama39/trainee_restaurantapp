import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_appbar.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';
import 'package:trainee_restaurantapp/features/trainer/my_courses/presentation/courses_controller/courses_cubit.dart';

import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/models/course_model.dart';
import '../../../../core/navigation/route_generator.dart';
import '../../../../core/ui/loader.dart';
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
    CoursesCubit.of(context).getCourses(context,isActive: false);
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
          SizedBox(
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
                          CoursesCubit.of(context).getCourses(context,isActive: false);
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
                              borderRadius: const BorderRadius.all(
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
                          CoursesCubit.of(context).getCourses(context,isActive: true);
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
                              borderRadius: const BorderRadius.all(
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
                          CoursesCubit.of(context).getCourses(context,isFinished: true);
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
                              borderRadius: const BorderRadius.all(
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
          )
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
      body: BlocBuilder<CoursesCubit,CoursesState>(
        builder: (context, state) {
          if(state is GetCoursesLoaded){
            if(state.courses.isNotEmpty){
              return ListView.builder(
                  itemCount: state.courses.length,
                  itemBuilder: (context, index) {
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CardDetails(selectedCard: false,courseModel: state.courses[index]),
                    );
                  });
            }else{
              return const Center(child: Text(
                  "لا يوجد كورسات"
              ),);
            }
          }else{
            return const Loader();
          }
        },
      ),
    );
  }
}

class AcceptedList extends StatelessWidget {
  const AcceptedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<CoursesCubit,CoursesState>(
        builder: (context, state) {
          if(state is GetCoursesLoaded){
            if(state.courses.isNotEmpty){
              return ListView.builder(
                  itemCount: state.courses.length,
                  itemBuilder: (context, index) {
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CardDetails(selectedCard: false,courseModel: state.courses[index]),
                    );
                  });
            }else{
              return const Center(child: Text(
                  "لا يوجد كورسات"
              ),);
            }
          }else{
            return const Loader();
          }
        },
      ),
    );
  }
}

class RefusedList extends StatelessWidget {
  const RefusedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<CoursesCubit,CoursesState>(
        builder: (context, state) {
          if(state is GetCoursesLoaded){
            if(state.courses.isNotEmpty){
              return ListView.builder(
                  itemCount: state.courses.length,
                  itemBuilder: (context, index) {
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CardDetails(selectedCard: false,courseModel: state.courses[index]),
                    );
                  });
            }else{
              return const Center(child: Text(
                  "لا يوجد كورسات"
              ),);
            }
          }else{
            return const Loader();
          }
        },
      ),
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
        image: const DecorationImage(
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
  final CourseModel courseModel;
  const CardDetails({Key? key, required this.selectedCard, required this.courseModel}) : super(key: key);

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
        child: SizedBox(
          height: 140.h,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        AppColors.linearCardTrainee1Color.withOpacity(1),
                        AppColors.linearCardTrainee2Color.withOpacity(1),
                        AppColors.linearCardTrainee3Color.withOpacity(1),
                        AppColors.linearCardTrainee4Color.withOpacity(1),
                      ]),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: CustomText(
                              text: courseModel.name ?? "",
                              fontSize: AppConstants.textSize16,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              const FaIcon(
                                FontAwesomeIcons.user,
                                color: AppColors.lightGrey,
                                size: 16,
                              ),
                              CustomText(
                                text: "${courseModel.viewsCount}",
                                fontSize: AppConstants.textSize16,
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w400,
                                color: AppColors.accentColorLight,
                              ),
                                ],
                              ))
                        ],
                      ),
                      CustomText(
                        text: "${courseModel.fee} ${Translation.of(context).saudi_riyal}",
                        fontSize: AppConstants.textSize16,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w400,
                        color: AppColors.accentColorLight,
                      ),
                      _buildRatingWidget(average: 4.2),
                      selectedCard
                          ? const SizedBox()
                          : CustomText(
                              text: "المده المتبقيه: ${courseModel.trainingHoursCount}",
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
                  decoration:  BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(courseModel.imageUrl ?? ""),
                          fit: BoxFit.cover),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
