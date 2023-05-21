import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee_restaurantapp/features/shop/my_orders_shop/view/my_order_shop_view.dart';
import 'package:trainee_restaurantapp/features/shop/my_products/view/all_products_screen.dart';
import '../../../../../core/common/app_colors.dart';
import '../../../../../core/common/style/gaps.dart';
import '../../../../../core/constants/app/app_constants.dart';
import '../../../../../core/ui/widgets/blur_widget.dart';
import '../../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../../core/ui/widgets/custom_checkBox.dart';
import '../../../../../core/ui/widgets/custom_text.dart';
import '../../../../../core/ui/widgets/title_widget.dart';
import '../../../../../generated/l10n.dart';

class MoreShopScreen extends StatelessWidget {
  const MoreShopScreen({Key? key}) : super(key: key);

  Widget _buildChipWidget(
      {required String title,
      required String imgPath,
      required Function onPressed}) {
    double? rightPosition;
    double? leftPosition;
    leftPosition = 0.0;
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          width: 143.w,
          height: 45.h,
          child: Row(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppConstants.borderRadius32),
                child: Image.asset(
                  imgPath,
                  height: 45.h,
                  width: 45.w,
                  fit: BoxFit.cover,
                ),
              ),
              Gaps.hGap12,
              SizedBox(
                height: 18.h,
                child: FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  child: CustomText(
                    textAlign: TextAlign.center,
                    text: title,
                    fontWeight: FontWeight.w600,
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

  Widget _buildAppSettingsWidget({required context}) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: Translation.of(context).language,
            fontSize: AppConstants.textSize16,
          ),
          Gaps.vGap16,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // sn.languagesEnum == LanguagesEnum.arabic
              //     ?
              BlurWidget(
                height: 20.h,
                width: 57.w,
                child: Center(
                    child: CustomText(
                  text: Translation.of(context).arabic,
                  fontSize: AppConstants.textSize14,
                )),
              ),
              Gaps.hGap32,
              // sn.languagesEnum == LanguagesEnum.english
              //     ?
              BlurWidget(
                height: 20.h,
                width: 60.w,
                child: Center(
                  child: Container(
                    child: CustomText(
                      text: Translation.of(context).english,
                      fontSize: AppConstants.textSize14,
                    ),
                  ),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              // Nav.to(PrivacyPolicyScreen.routeName);
            },
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: CustomText(
                text: Translation.of(context).privacy_policy,
                fontSize: AppConstants.textSize16,
              ),
            ),
          ),
          SizedBox(
            height: 19.h,
            child: Row(
              children: [
                CustomText(
                  text: Translation.of(context).enable_notifications,
                  fontSize: AppConstants.textSize16,
                ),
                const Spacer(),
                Transform.scale(
                  scale: 1.5,
                  child: CustomCheckbox(
                    value: true,
                    onChanged: (value) {},
                    checkColor: AppColors.white,
                    activeColor: AppColors.accentColorLight,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              //     Nav.to(FeedbackScreen.routeName);
            },
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
              child: CustomText(
                text: Translation.of(context).feedback,
                fontSize: AppConstants.textSize16,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              //   Nav.to(AboutAppScreen.routeName);
            },
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
              child: CustomText(
                text: Translation.of(context).about_app,
                fontSize: AppConstants.textSize16,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              //    logout();
            },
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
              child: CustomText(
                text: Translation.of(context).logOut,
                fontSize: AppConstants.textSize16,
              ),
            ),
          ),
          Gaps.vGap40,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        title: Translation.of(context).more,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: Translation.of(context).goto,
              ),
              Gaps.vGap16,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // spacing: 40.w,
                // runSpacing: 16.h,
                children: [
                  _buildChipWidget(
                    title: 'منتجاتي',
                    imgPath: AppConstants.SWIMMING_IMG,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AllProductsScreen()));
                    },
                  ),
                  _buildChipWidget(
                    title: Translation.of(context).my_orders,
                    imgPath: AppConstants.MOTCHY2_IMG,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MyOrderShopView()));
                    },
                  ),
                  _buildChipWidget(
                    title: Translation.of(context).bouquet,
                    imgPath: AppConstants.VEGGIE2_IMG,
                    onPressed: () {},
                  ),
                ],
              ),
              Gaps.vGap30,
              TitleWidget(
                title: Translation.of(context).account_settings,
              ),
              Gaps.vGap10,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  //Nav.to(ChangePasswordScreen.routeName);
                },
                child: Padding(
                  padding: EdgeInsets.all(6.h),
                  child: CustomText(
                    text: Translation.of(context).change_password,
                    fontSize: AppConstants.textSize14,
                  ),
                ),
              ),
              Gaps.vGap24,
              TitleWidget(
                title: Translation.of(context).app_settings,
              ),
              Gaps.vGap16,
              _buildAppSettingsWidget(context: context),
              Gaps.vGap30,
            ],
          ),
        ),
      ),
    );
  }
}
