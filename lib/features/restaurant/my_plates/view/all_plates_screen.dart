import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trainee_restaurantapp/core/common/app_colors.dart';
import 'package:trainee_restaurantapp/core/common/style/gaps.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/navigation/route_generator.dart';
import 'package:trainee_restaurantapp/core/ui/loader.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_appbar.dart';
import 'package:trainee_restaurantapp/features/restaurant/my_plates/controller/my_plates_cubit.dart';
import 'package:trainee_restaurantapp/features/restaurant/my_plates/view/plate_setails_view.dart';
import 'dart:ui' as ui;

import '../../../../core/ui/widgets/custom_text.dart';
import '../../home_restaurant/data/models/dish_model.dart';

class AllPlatesScreen extends StatelessWidget {
  const AllPlatesScreen({Key? key}) : super(key: key);

  Widget traineeCard({required context, required Items dish}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MyPlateDetails(
                  dishId: dish.id!,
                )));
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(
                        text: dish.name ?? '',
                        fontSize: AppConstants.textSize18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                      // CustomText(
                      //   text: "${dish.price} ريال سعودي",
                      //   fontSize: AppConstants.textSize16,
                      //   maxLines: 2,
                      //   textAlign: TextAlign.start,
                      //   fontWeight: FontWeight.w400,
                      //   color: AppColors.white,
                      // ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: "${dish.price} ريال",
                              fontSize: AppConstants.textSize16,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w400,
                              color: AppColors.accentColorLight,
                            ),
                          ),
                        ],
                      ),
                      RatingBarIndicator(
                        rating: dish.rate ?? 0,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 24.0,
                        direction: Axis.horizontal,
                      ),
                      CustomText(
                        text: "المده المتبقيه يوم و 3 ساعات",
                        fontSize: AppConstants.textSize16,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
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
                          image: NetworkImage(
                              dish.images!.isEmpty ? '' : dish.images!.first),
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyPlatesCubit()..getAllDishs(),
      child: Scaffold(
        appBar: const TransparentAppBar(
          title: 'أطباقي',
        ),
        body: BlocBuilder<MyPlatesCubit, MyPlatesState>(
          builder: (context, state) {
            List<Items> listOfDishs = MyPlatesCubit.of(context).listOfDishs;
            return state is GetAllDishLoading
                ? const Loader()
                : Column(
                    children: [
                      Expanded(
                        child: listOfDishs.isEmpty
                            ? const Center(
                                child: Text('no data'),
                              )
                            : ListView.builder(
                                itemCount: listOfDishs.length,
                                itemBuilder: (context, index) {
                                  return traineeCard(
                                      context: context,
                                      dish: listOfDishs[index]);
                                }),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
