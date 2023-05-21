import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainee_restaurantapp/core/common/style/dimens.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';
import 'package:trainee_restaurantapp/features/restaurant/my_plates/view/all_plates_screen.dart';
import 'package:trainee_restaurantapp/features/shop/home_shop/controller/home_shop_cubit.dart';
import 'package:trainee_restaurantapp/features/shop/my_products/view/all_products_screen.dart';
import 'package:trainee_restaurantapp/features/shop/my_products/view/product_details_view.dart';
import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/library/carousel/custom_carousel.dart';
import '../../../../core/ui/loader.dart';
import '../../../../core/ui/physics/custom_scroll_physics.dart';
import '../../../../core/ui/widgets/blur_widget.dart';
import '../../../../core/ui/widgets/clock_widget.dart';
import '../../../../core/ui/widgets/custom_button.dart';
import '../../../../core/ui/widgets/title_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../trainer/trainee/presentation/view/trainee_profile_view.dart';
import '../../shop_profile/shop_profile_controller/shop_profile_cubit.dart';
import '../data/models/product_model.dart';

class HomeShopScreen extends StatefulWidget {
  const HomeShopScreen({Key? key}) : super(key: key);

  @override
  State<HomeShopScreen> createState() => _HomeShopScreenState();
}

class _HomeShopScreenState extends State<HomeShopScreen> {
  Widget _buildMyProductItemWidget(Items item) {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MyProductDetails(
                  productId: item.id!,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius12),
            image: DecorationImage(
              image:
                  NetworkImage(item.images!.isEmpty ? '' : item.images!.first),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 90.h,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    child: BlurWidget(
                      blurColor: AppColors.grey.withOpacity(0.5),
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
                                  text: item.name ?? '',
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white,
                                  fontSize: AppConstants.textSize14,
                                ),
                                Gaps.hGap4,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.cube,
                                      size: 16,
                                      color: AppColors.accentColorLight,
                                    ),
                                    SizedBox(
                                      height: 10,
                                      child: CustomText(
                                        text: "0 طلب",
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppConstants.textSize12,
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
                              text: "${item.price ?? ''} ريال سعودي",
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
                              ],
                            ),
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

  Widget mostWantedCourse(List<Items> listOfProducts) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: TitleWidget(
              title: "المنتجات الأكثر طلبا",
              subtitleColorTapped: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AllProductsScreen()));
              },
              titleColor: AppColors.accentColorLight,
              subtitle: "اظهار الكل",
            ),
          ),
          Gaps.vGap16,
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: CustomCarousel(
                items: List.generate(
                    listOfProducts.length,
                    (index) =>
                        _buildMyProductItemWidget(listOfProducts[index])),
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
          ),
        ],
      ),
    );
  }

  Widget restaurantBouquet() {
    return BlocBuilder<ShopProfileCubit, ShopProfileState>(
        builder: (context, state) {
      if (state is GetShopProfileLoading) {
        return const Loader();
      } else {
        var restaurantsModel = ShopProfileCubit.of(context).shopModel;
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
                              gradient: const LinearGradient(colors: [
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
                                  text: restaurantsModel!.subscription!.name ??
                                      '',
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                  fontSize: AppConstants.textSize16,
                                ),
                                CustomText(
                                  text:
                                      "${restaurantsModel.subscription!.fee} ريال سعودي",
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
                                  color:
                                      AppColors.transparent.withOpacity(0.2)),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(AppConstants.blurDegree10)),
                              gradient: LinearGradient(colors: [
                                AppColors.transparent.withOpacity(0.0),
                                AppColors.transparent.withOpacity(0.5)
                              ])),
                          child: Center(
                            child: MaterialButton(
                              onPressed: () {},
                              child: const Icon(
                                Icons.arrow_forward,
                                color: AppColors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    ShopProfileCubit.of(context).getShopProfile(context);
    super.initState();
  }

  Widget _buildSubscriptionWidget() {
    return BlocBuilder<ShopProfileCubit, ShopProfileState>(
      builder: (context, state) {
        if (state is GetShopProfileLoading) {
          return const Loader();
        } else {
          var shopModel = ShopProfileCubit.of(context).shopModel;
          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                          color: AppColors.grey,
                          gradient: LinearGradient(colors: [
                            AppColors.grey.withOpacity(0.9),
                            AppColors.grey.withOpacity(1),
                          ]),
                          borderRadius: BorderRadius.circular(
                              AppConstants.borderRadius10)),
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(shopModel?.logo ?? ''),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomText(
                                      text: shopModel?.name ?? "",
                                      color: AppColors.white,
                                      fontSize: AppConstants.textSize14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    CustomText(
                                      text: shopModel?.subscription?.name ?? "",
                                      color: AppColors.accentColorLight,
                                      fontSize: AppConstants.textSize14,
                                      fontWeight: FontWeight.w600,
                                    )
                                  ],
                                ))
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeShopCubit()..getAllProductMostOrderedHome(),
      child: BlocBuilder<ShopProfileCubit, ShopProfileState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is GetShopProfileLoading ||
              state is GetAllProductMostOrderedHomeLoading) {
            return const Loader();
          } else {
            var shopModel = ShopProfileCubit.of(context).shopModel;
            return SafeArea(
              child: CustomScrollView(slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: CustomSliverDelegate(
                    image: shopModel!.cover ?? '',
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
                        BlocBuilder<HomeShopCubit, HomeShopState>(
                          builder: (context, state) {
                            return mostWantedCourse(
                                HomeShopCubit.of(context).listOfProduct);
                          },
                        ),
                        Gaps.vGap16,
                        restaurantBouquet(),
                        Gaps.vGap60,
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
