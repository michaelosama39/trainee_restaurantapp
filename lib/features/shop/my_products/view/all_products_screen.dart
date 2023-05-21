import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee_restaurantapp/core/common/app_colors.dart';
import 'package:trainee_restaurantapp/core/common/style/gaps.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/ui/loader.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_appbar.dart';
import 'package:trainee_restaurantapp/features/shop/my_products/controller/my_products_cubit.dart';
import 'package:trainee_restaurantapp/features/shop/my_products/view/product_details_view.dart';
import 'dart:ui' as ui;
import '../../../../core/ui/widgets/custom_text.dart';
import '../../home_shop/data/models/product_model.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  Widget productCard({required context, required Items product}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MyProductDetails(
                  productId: product.id!,
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
                        text: product.name ?? '',
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
                              text: "${product.price} ريال سعودي",
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
                        rating: product.rate ?? 0,
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
                              product.images!.isEmpty ? '' : product.images!.first),
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
      create: (context) => MyProductsCubit()..getAllProduct(),
      child: Scaffold(
        appBar: const TransparentAppBar(
          title: 'منتجاتي',
        ),
        body: BlocBuilder<MyProductsCubit, MyProductsState>(
          builder: (context, state) {
            List<Items> listOfProducts = MyProductsCubit.of(context).listOfDishs;
            return state is GetAllProductLoading
                ? const Loader()
                : Column(
                    children: [
                      Expanded(
                        child: listOfProducts.isEmpty
                            ? const SizedBox()
                            : ListView.builder(
                                itemCount: listOfProducts.length,
                                itemBuilder: (context, index) {
                                  return productCard(
                                      context: context,
                                      product: listOfProducts[index]);
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
