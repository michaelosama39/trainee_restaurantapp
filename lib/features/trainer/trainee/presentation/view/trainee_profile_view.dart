import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trainee_restaurantapp/core/ui/loader.dart';
import 'package:trainee_restaurantapp/features/trainer/home_trainer/presentation/home_trainer_controller/home_trainer_cubit.dart';
import '../../../../../core/appStorage/app_storage.dart';
import '../../../../../core/common/app_colors.dart';
import '../../../../../core/common/style/gaps.dart';
import '../../../../../core/constants/app/app_constants.dart';
import '../../../../../core/ui/widgets/custom_button.dart';
import '../../../../../core/ui/widgets/custom_text.dart';
import '../../../../../core/ui/widgets/precentage_show.dart';
import '../../../../../generated/l10n.dart';
import '../../../chat/data/model/chat_model.dart';
import '../../../chat/view/chat_details_view.dart';
import '../../../chat/view/video_call_screen.dart';
import '../../../chat/view/voice_call_screen.dart';
import 'add_new_trainee_entry_screen.dart';


class TraineeProfileScreen extends StatefulWidget {
  final Map args;
  const TraineeProfileScreen({Key? key,required this.args}) : super(key: key);

  @override
  State<TraineeProfileScreen> createState() => _TraineeProfileScreenState();
}

class _TraineeProfileScreenState extends State<TraineeProfileScreen> {

  @override
  void initState() {
    // TODO: implement initState
    HomeTrainerCubit.of(context).getTrainee(widget.args["courseId"], widget.args["traineeId"]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<HomeTrainerCubit,HomeTrainerState>(builder: (context, state) {
          if(HomeTrainerCubit.of(context).trainee == null){
            return const Loader();
          }else{
            return CustomScrollView(
                slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: CustomSliverDelegate(
                      expandedHeight: 230.h,
                      image: HomeTrainerCubit.of(context).trainee!.trainee!.imageUrl ?? "",
                      child: _buildSubscriptionWidget(),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Gaps.vGap12,
                          _traineeStatistic(context: context),
                          Gaps.hGap12,
                          NewElevatedButton(
                            text: "ابدا التمرين",
                            onTap: () {},
                            color: AppColors.accentColorLight,
                          ),
                          NewElevatedButton(
                            text: "ادخل قيم جديده",
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewTraineeEntryScreen(),));
                            },
                            color: null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ]);
          }
        },),
      )
    );
  }

  // Widget _buildMapWidget({required LatLng? location}) {
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
                height: 95.h,
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
                        text: HomeTrainerCubit.of(context).trainee!.trainee!.name ?? "",
                        fontSize: AppConstants.textSize16,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.start,
                      ),
                      const Spacer(),
                      CustomText(
                        text: "متدرب في ${HomeTrainerCubit.of(context).trainee!.course!.text ?? ""}",
                        color: AppColors.accentColorLight,
                        fontSize: AppConstants.textSize14,
                        fontWeight: FontWeight.bold,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsView(chatModel: ChatModel(
                                traineeId: HomeTrainerCubit.of(context).trainee!.traineeId,
                                traineeImage: HomeTrainerCubit.of(context).trainee!.trainee!.imageUrl ?? "",
                                traineeName: HomeTrainerCubit.of(context).trainee!.trainee!.name,
                              )),));
                            },
                            child: ImageIcon(
                              const AssetImage(
                                AppConstants.CHAT_ICON,
                              ),
                              color: AppColors.white,
                              size: 20.h,
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return VoiceCallScreen(channelName:HomeTrainerCubit.of(context).trainee!.traineeId.toString() +AppStorage.getUserId.toString(),);
                              }));
                            },
                            child: ImageIcon(
                              const AssetImage(
                                AppConstants.PHONE_CALL_ICON,
                              ),
                              color: AppColors.white,
                              size: 20.h,
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return VideoCallScreen(channelName:HomeTrainerCubit.of(context).trainee!.traineeId.toString() +AppStorage.getUserId.toString(),);
                              }));
                            },
                            child: ImageIcon(
                              const AssetImage(
                                AppConstants.VIDEO_CALL_ICON,
                              ),
                              color: AppColors.white,
                              size: 20.h,
                            ),
                          ),
                        ],
                      )
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
                  child: Row(
                    children: [
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            AppConstants.TALL_ICON,
                          ),
                          CustomText(
                            text: "${HomeTrainerCubit.of(context).trainee!.length ?? 0} سم",
                            color: AppColors.accentColorLight,
                            fontSize: AppConstants.textSize14,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            AppConstants.WEIGHT_ICON,
                          ),
                          CustomText(
                            text: "${HomeTrainerCubit.of(context).trainee!.weight ?? 0} كيلو جرام",
                            color: AppColors.accentColorLight,
                            fontSize: AppConstants.textSize14,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )),
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

  Widget _traineeStatistic({required context}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      CustomText(
        text: Translation.of(context).course_statistic,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
        fontSize: AppConstants.textSize14,
      ),
      Gaps.vGap12,
      staticDetails(
          titleText: "عدد ساعات الكورس الكليه", trailingText: "${HomeTrainerCubit.of(context).trainee!.course!.trainingHoursCount} ساعه"),
      staticDetails(
          titleText: Translation.of(context).finishedHour,
          trailingText: "${HomeTrainerCubit.of(context).trainee!.completedHours ?? 0} ساعه"),
      staticDetails(
          titleText: Translation.of(context).remainsHours,
          trailingText: "${(HomeTrainerCubit.of(context).trainee!.course!.trainingHoursCount ?? 0) - (HomeTrainerCubit.of(context).trainee!.completedHours ?? 0) } ساعه"),
      staticDetails(
          titleText: Translation.of(context).numberOfAbsenece,
          trailingText: "${HomeTrainerCubit.of(context).trainee!.absenceCount} مره"), SizedBox(
          height: 50,
          child: PrecentageShow(
            prescentageValue: HomeTrainerCubit.of(context).trainee!.progress ?? 0,
          )),
      const SizedBox(
        height: 200,
        child: Statistic(),
      ),
        ],
      ),
    );
  }
}

staticDetails({required String titleText, required String trailingText}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: titleText,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
          fontSize: AppConstants.textSize12,
        ),
        CustomText(
          text: trailingText,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
          fontSize: AppConstants.textSize12,
        )
      ],
    ),
  );
}

//todo refactoring
class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  final Widget child;
  final String? image;
  final Widget? mainTopWidget;

  CustomSliverDelegate(
      {required this.child,
      required this.expandedHeight,
      this.hideTitleWhenExpanded = true,
        this.mainTopWidget,
      this.image});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset / 1.1.h;
    final cardTopPosition = expandedHeight - 40.h - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;

    final appBarSize2 = expandedHeight - shrinkOffset / 2.5.h;
    final proportion2 = 2 - (expandedHeight / appBarSize2);
    final percent2 = proportion2 < 0 || proportion2 > 1 ? 0.0 : proportion2;
    return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 0,
            child: Opacity(
              opacity: percent2,
              child:
                  // coachModel != null
                  //     ? Image.network(
                  //         coachModel.imageUrl!,
                  //         fit: BoxFit.cover,
                  //         height: 250.h,
                  //       )
                  //     :
                mainTopWidget??  Image.network(
                image ?? "",
                fit: BoxFit.cover,
                height: 250.h,
              ),
            ),
          ),
          // SizedBox(
          //   height:
          //       appBarSize < kToolbarHeight.h ? kToolbarHeight.h : appBarSize,
          //   child: AppBar(
          //     backgroundColor: AppColors.primaryColorLight
          //         .withOpacity(percent2 == 0 ? 1 : 0),
          //     elevation: 0.0,
          //     title: CustomText(
          //       text: "رامي المصري",
          //       fontSize: AppConstants.textSize18,
          //     ),
          //   ),
          // ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: Visibility(
              visible: percent == 0 ? false : true,
              child: Opacity(
                opacity: percent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w * percent),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class Statistic extends StatefulWidget {
  const Statistic({Key? key}) : super(key: key);

  @override
  State<Statistic> createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SfCartesianChart(
                backgroundColor: AppColors.primaryColorLight,
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'تغيرات كتلة الجسم BMI'),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: _tooltipBehavior,
                series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
              dataSource: <SalesData>[
            SalesData('Jan', 35),
            SalesData('Feb', 28),
            SalesData('Mar', 34),
            SalesData('Apr', 32),
            SalesData('May', 40)
              ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales,
              color: AppColors.accentColorLight,
              dataLabelSettings: const DataLabelSettings(isVisible: true))
        ])));
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
