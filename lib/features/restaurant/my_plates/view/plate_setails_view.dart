import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trainee_restaurantapp/core/ui/loader.dart';
import 'package:trainee_restaurantapp/features/restaurant/my_plates/controller/my_plates_cubit.dart';
import 'package:trainee_restaurantapp/features/restaurant/my_plates/models/order_model.dart';

import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/models/review_model.dart';
import '../../../../core/navigation/route_generator.dart';
import '../../../../core/ui/widgets/blur_widget.dart';
import '../../../../core/ui/widgets/custom_rating_bar_widget.dart';
import '../../../../core/ui/widgets/custom_text.dart';
import '../../../../core/ui/widgets/precentage_show.dart';
import '../../../../core/ui/widgets/title_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../trainer/trainee/view/trainee_profile_view.dart';
import '../../home_restaurant/data/models/dish_model.dart';

class MyPlateDetails extends StatefulWidget {
  final int dishId;

  const MyPlateDetails({super.key, required this.dishId});

  @override
  State<MyPlateDetails> createState() => _MyPlateDetailsState();
}

class _MyPlateDetailsState extends State<MyPlateDetails> {
  Widget _buildSubscriptionWidget(Items item) {
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
                      SizedBox(
                        width: double.infinity,
                        child: CustomText(
                          text: item.name ?? '',
                          fontSize: AppConstants.textSize16,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const Spacer(),
                      CustomText(
                        maxLines: 2,
                        text: item.components ?? '',
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
                            text: " ${item.orderCount}",
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
                              text: "${item.price} ريال",
                              fontSize: AppConstants.textSize14,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w500,
                              color: AppColors.accentColorLight,
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
                      child: Image.network(
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

  Widget _buildCommentsWidget(List<ReviewModel> review) {
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
                  image: review[index].reviewer!.imageUrl ?? '',
                  date: review[index].creationTime ?? '',
                  name: review[index].reviewer!.name ?? '',
                  body: review[index].comment ?? '',
                ));
          },
          separatorBuilder: (context, index) => Gaps.hGap16,
          itemCount: review.length,
        ),
      ),
    );
  }

  Widget traineeCard({required context, required OrderModel orderModel}) {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.traineeProfileScreen);
      },
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
                    text: orderModel.trainee!.name ?? '',
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
                        text: " ${orderModel.items!.length}",
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
                          text: "${orderModel.price ?? ''} ريال",
                          fontSize: AppConstants.textSize14,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w500,
                          color: AppColors.accentColorLight,
                        ),
                      ),
                      Expanded(
                        child: CustomText(
                          text: DateTime.now().toString().substring(0, 10),
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
              decoration: const BoxDecoration(
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

  Widget _trainee(List<OrderModel> listOfOrders) {
    return SizedBox(
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
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listOfOrders.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: traineeCard(
                          context: context, orderModel: listOfOrders[index]),
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
    return BlocProvider(
      create: (context) => MyPlatesCubit()
        ..getDishDetails(widget.dishId)
        ..getDishReviews(widget.dishId),
      child: BlocBuilder<MyPlatesCubit, MyPlatesState>(
        builder: (context, state) {
          Items? item = MyPlatesCubit.of(context).item;
          List<ReviewModel> listOfReviews =
              MyPlatesCubit.of(context).listOfReviews;
          List<OrderModel> listOfOrders =
              MyPlatesCubit.of(context).listOfOrders;
          if (state is GetDishDetailsLoading ||
              state is GetDishReviewsLoading ||
              state is GetDishOrdersLoading) {
            return const Loader();
          } else {
            return SafeArea(
              child: CustomScrollView(slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: CustomSliverDelegate(
                    image: item!.images!.first ?? '',
                    expandedHeight: 260.h,
                    child: _buildSubscriptionWidget(item),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Gaps.vGap10,
                        listOfOrders.isEmpty
                            ? const SizedBox()
                            : _trainee(listOfOrders),
                        _buildRatingWidget(
                          average: item.rate!.toDouble(),
                          fifthRate: item.ratingDetails!.i5!.toDouble(),
                          firstRate: item.ratingDetails!.i1!.toDouble(),
                          forthRate: item.ratingDetails!.i4!.toDouble(),
                          secondRate: item.ratingDetails!.i2!.toDouble(),
                          thirdRate: item.ratingDetails!.i3!.toDouble(),
                        ),
                        Gaps.vGap24,
                        listOfReviews.isEmpty
                            ? const SizedBox()
                            : _buildCommentsWidget(listOfReviews),
                        Gaps.vGap24,
                      ],
                    ),
                  ),
                ),
              ]),
            );
          }
        },
      ),
    );
  }
}
