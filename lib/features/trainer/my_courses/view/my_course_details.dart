import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee_restaurantapp/core/models/course_model.dart';
import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/navigation/route_generator.dart';
import '../../../../core/ui/loader.dart';
import '../../../../core/ui/widgets/blur_widget.dart';
import '../../../../core/ui/widgets/custom_rating_bar_widget.dart';
import '../../../../core/ui/widgets/custom_text.dart';
import '../../../../core/ui/widgets/precentage_show.dart';
import '../../../../core/ui/widgets/title_widget.dart';
import '../../../../generated/l10n.dart';
import '../../trainee/view/trainee_profile_view.dart';
import '../presentation/courses_controller/courses_cubit.dart';

class MyCourseDetails extends StatefulWidget {
  final int courseId;
  const MyCourseDetails({super.key, required this.courseId});

  @override
  State<MyCourseDetails> createState() => _MyCourseDetailsState();
}

class _MyCourseDetailsState extends State<MyCourseDetails> {

  @override
  void initState() {
    // TODO: implement initState
    CoursesCubit.of(context).getCourse(context, widget.courseId);
    CoursesCubit.of(context).getCourseReviews(context, widget.courseId);
    super.initState();
  }
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
                height: 68.h,
                decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadius10)),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: CustomText(
                          text: CoursesCubit.of(context).courseModel!.name ?? "",
                          fontSize: AppConstants.textSize16,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const Spacer(),
                      CustomText(
                        maxLines: 2,
                        text: CoursesCubit.of(context).courseModel!.description ?? "",
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
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomText(
                                text: "المشتركين:",
                                color: AppColors.white,
                                fontSize: AppConstants.textSize14,
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                text: "${CoursesCubit.of(context).courseModel!.traineesCount}",
                                color: AppColors.accentColorLight,
                                fontSize: AppConstants.textSize14,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          )),
                          Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomText(
                                    text: "الحد الأقصي للمشتركين:",
                                    color: AppColors.white,
                                    fontSize: AppConstants.textSize14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  CustomText(
                                    text: "${CoursesCubit.of(context).courseModel!.bookingRequestsCount}",
                                    color: AppColors.accentColorLight,
                                    fontSize: AppConstants.textSize14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              )),
                        ],
                      ),
                      CustomText(
                        text: "المده المتبقيه: ${CoursesCubit.of(context).courseModel!.trainingHoursCount}",
                        fontSize: AppConstants.textSize14,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                      CustomText(
                        text: "${CoursesCubit.of(context).courseModel!.fee} ${Translation.of(context).saudi_riyal}",
                        fontSize: AppConstants.textSize16,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                        color: AppColors.accentColorLight,
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
    );
  }

  Widget _buildCommentsWidget() {
    return BlocBuilder<CoursesCubit,CoursesState>(builder: (context, state) {
      if(state is GetCourseReviewsLoaded){
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
                      image:
                      state.reviews[index].reviewer!.imageUrl ?? "",
                      date: state.reviews[index].creationTime ?? "",
                      name: state.reviews[index].reviewer!.name ?? "",
                      body: state.reviews[index].comment ?? ""),
                );
              },
              separatorBuilder: (context, index) => Gaps.hGap16,
              itemCount: state.reviews.length),
        );
      }else if(state is GetCourseReviewsLoading){
        return const Loader();
      }else{
        return const SizedBox();
      }
    },);
  }
  Widget traineeCard(CourseTraineeModel courseTraineeModel,{required context}) {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.traineeProfileScreen, arguments: {
        "courseId" : courseTraineeModel.courseId,
        "traineeId" : courseTraineeModel.traineeId
        });
      },
      child: SizedBox(
        width: double.infinity,
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
                    CustomText(
                      text: courseTraineeModel.traineeName ?? "",
                      fontSize: AppConstants.textSize18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                    CustomText(
                      text: CoursesCubit.of(context).courseModel!.description ?? "",
                      fontSize: AppConstants.textSize16,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
                    ),
                     PrecentageShow(prescentageValue: courseTraineeModel.completedHoursCount ?? 0,)
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
                        image: NetworkImage(courseTraineeModel.traineeImage ?? ""),
                        fit: BoxFit.cover),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trainee() {
    return SizedBox(
      height: 200.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            TitleWidget(
              title: "المتدريبين",
              subtitleColorTapped: () {
                Navigator.pushNamed(context, Routes.traineeScreen);
              },
              titleColor: AppColors.white,
              subtitleColor: AppColors.accentColorLight,
              subtitle: "اظهار الكل",
              subtitleSize: AppConstants.textSize14,
            ),
            Expanded(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: CoursesCubit.of(context).courseModel!.traineesProgress!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: traineeCard(CoursesCubit.of(context).courseModel!.traineesProgress![index],context: context),
                    );
                  }),
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
      child: Scaffold(
        body: BlocBuilder<CoursesCubit,CoursesState>(
          builder: (context, state) {
            if(CoursesCubit.of(context).courseModel != null){
              return CustomScrollView(slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: CustomSliverDelegate(
                    image: AppConstants.YOGA_IMG,
                    expandedHeight: 230.h,
                    child: _buildSubscriptionWidget(),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Gaps.vGap10,
                        _trainee(),
                        _buildRatingWidget(
                            average: CoursesCubit.of(context).courseModel!.rate!.toDouble(),
                            fifthRate: CoursesCubit.of(context).courseModel!.ratingDetails!.i5!.toDouble(),
                            firstRate: CoursesCubit.of(context).courseModel!.ratingDetails!.i1!.toDouble(),
                            forthRate: CoursesCubit.of(context).courseModel!.ratingDetails!.i4!.toDouble(),
                            secondRate: CoursesCubit.of(context).courseModel!.ratingDetails!.i2!.toDouble(),
                            thirdRate: CoursesCubit.of(context).courseModel!.ratingDetails!.i3!.toDouble()),
                        Gaps.vGap24,
                        _buildCommentsWidget(),
                        Gaps.vGap24,
                      ],
                    ),
                  ),
                ),
              ]);
            }else{
              return const Loader();
            }
          },),
      )
    );
  }
}
