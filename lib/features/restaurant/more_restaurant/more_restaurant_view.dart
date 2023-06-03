import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:trainee_restaurantapp/features/restaurant/my_orders_restaurant/view/my_order_restaurant_view.dart';
import 'package:trainee_restaurantapp/features/restaurant/my_plates/view/all_plates_screen.dart';
import 'package:trainee_restaurantapp/features/trainer/subscription/presentation/view/subscription_screen.dart';
import '../../../../../core/common/app_colors.dart';
import '../../../../../core/common/style/gaps.dart';
import '../../../../../core/constants/app/app_constants.dart';
import '../../../../../core/ui/widgets/blur_widget.dart';
import '../../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../../core/ui/widgets/custom_checkBox.dart';
import '../../../../../core/ui/widgets/custom_text.dart';
import '../../../../../core/ui/widgets/title_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../core/datasources/shared_preference.dart';
import '../../../core/localization/localization_provider.dart';
import '../../Acount/data/repositories/auth_repo.dart';
import '../../Acount/presentation/screens/change_password_screen.dart';
import '../../trainer/more_trainer/presentation/view/about_app_screen.dart';
import '../../trainer/more_trainer/presentation/view/feedback_screen.dart';
import '../../trainer/more_trainer/presentation/view/privacy_policy_screen.dart';

class MoreRestaurantScreen extends StatelessWidget {
  const MoreRestaurantScreen({Key? key, required this.typeUser})
      : super(key: key);

  final int typeUser;

  Widget _buildChipWidget(
      {required String title,
      required String imgPath,
      required Function onPressed}) {
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
              Consumer<LocalizationProvider>(
                builder: (_, provider, __) {
                  return InkWell(
                    onTap: () async{
                      provider.changeLanguage(
                          const Locale(AppConstants.LANG_AR), context);
                    },
                    child: BlurWidget(
                      height: 20.h,
                      width: 57.w,
                      colorBorder: provider.appLocal.languageCode == 'ar'
                          ? AppColors.accentColorLight
                          : null,
                      child: Center(
                          child: CustomText(
                        text: Translation.of(context).arabic,
                        fontSize: AppConstants.textSize14,
                      )),
                    ),
                  );
                },
              ),
              Gaps.hGap32,
              Consumer<LocalizationProvider>(
                builder: (_, provider, __) {
                  return InkWell(
                    onTap: () async{
                      provider.changeLanguage(
                          const Locale(AppConstants.LANG_EN), context);
                    },
                    child: BlurWidget(
                      height: 20.h,
                      width: 60.w,
                      colorBorder: provider.appLocal.languageCode == 'en'
                          ? AppColors.accentColorLight
                          : null,
                      child: Center(
                        child: CustomText(
                          text: Translation.of(context).english,
                          fontSize: AppConstants.textSize14,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyScreen(),
                  ));
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FeedbackScreen(),
                  ));
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutAppScreen(),
                  ));
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
              AuthRepo().logout(context);
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
                      title: 'اطباقي',
                      imgPath: AppConstants.SWIMMING_IMG,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AllPlatesScreen()));
                      }),
                  _buildChipWidget(
                      title: Translation.of(context).my_orders,
                      imgPath: AppConstants.MOTCHY2_IMG,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const MyOrderRestaurantView()));
                      }),
                  _buildChipWidget(
                      title: Translation.of(context).bouquet,
                      imgPath: AppConstants.VEGGIE2_IMG,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SubscriptionScreen(
                                  typeUser: typeUser,
                                )));
                      }),
                  // _buildChipWidget(
                  //     title: Translation.of(context).supplements,
                  //     imgPath: AppConstants.KCAL2_IMG,
                  //     onPressed: () {}),
                  // _buildChipWidget(
                  //     title: Translation.of(context).my_orders,
                  //     imgPath: AppConstants.VEGGIE_IMG,
                  //     onPressed: () {}),
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen(
                            screenNumber: typeUser,
                          )));
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
