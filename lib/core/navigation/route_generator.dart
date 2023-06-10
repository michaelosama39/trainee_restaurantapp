import 'package:flutter/material.dart';
import 'package:trainee_restaurantapp/features/Acount/presentation/screens/register_screen_restaurant.dart';
import 'package:trainee_restaurantapp/features/restaurant/home_restaurant/view/home_restaurant_view.dart';
import 'package:trainee_restaurantapp/features/shop/shop_profile/view/edit_shop_profile.dart';
import '../../features/Acount/presentation/screens/account_verification.dart';
import '../../features/Acount/presentation/screens/forget_password.dart';
import '../../features/Acount/presentation/screens/forget_password_verification.dart';
import '../../features/Acount/presentation/screens/login_screen.dart';
import '../../features/Acount/presentation/screens/register_screen_shop.dart';
import '../../features/Acount/presentation/screens/register_screen_trainer.dart';
import '../../features/Acount/presentation/screens/reset_password_screen.dart';
import '../../features/navigator_home/view/navigator_home_view.dart';
import '../../features/on_boarding/view/main_onboarding_view.dart';
import '../../features/restaurant/restaurant_profile/view/edit_restaurant_profile.dart';
import '../../features/trainer/add_course/presentation/screen/add_course_view.dart';
import '../../features/trainer/home_trainer/presentation/view/home_trainer_view.dart';
import '../../features/trainer/my_courses/presentation/view/my_course_details.dart';
import '../../features/trainer/my_courses/presentation/view/my_course_view.dart';
import '../../features/trainer/my_orders/presentation/view/my_order_view.dart';
import '../../features/trainer/profile_details/presentation/view/edit_profile_trainer_screen.dart';
import '../../features/trainer/trainee/presentation/view/all_trainee_screen.dart';
import '../../features/trainer/trainee/presentation/view/trainee_profile_view.dart';
import 'navigation_service.dart';

class Routes {
  static const String mainOnBoardingViewRoute = "/mainOnBoardingView";
  static const String mainLoginScreen = "/loginScreen";
  static const String trainerSignUpScreen = "/trainerSignUp";
  static const String restaurantSignUpScreen = "/restaurantSignUp";
  static const String shopSignUpScreen = "/shopSignUp";
  static const String verificationOtpScreen = "/verificationOtpScreen";
  static const String forgetPassScreen = "/forgetPassScreen";
  static const String forgetPassVerificationScreen =
      "/forgetPassVerificationScreen";
  static const String navigatorScreen = "/navigatorScreen";
  static const String homeTrainerScreen = "/homeTrainerScreen";
  static const String homeRestScreen = "/homeRestScreen";
  static const String traineeProfileScreen = "/traineeProfileScreen";
  static const String MyCourseDetailsScreen = "/myCourseDetails";
  static const String addCourseScreen = "/addCourseScreen";
  static const String myCourseScreen = "/myCourseScreen";
  static const String myOrderScreen = "/myOrderScreen";
  static const String traineeScreen = "/traineeScreen";
  static const String editProfileScreen = "/editProfileScreen";
  static const String editRestProfileScreen = "/editRestProfileScreen";
  static const String editShopProfileScreen = "/editShopProfileScreen";
  static const String resetPass = "/resetPass";
}

class AppRoute {
  Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          backgroundColor:
              Theme.of(NavigationService().getNavigationKey.currentContext!)
                  .scaffoldBackgroundColor,
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('ROUTE ERROR CHECK THE ROUTE GENERATOR'),
          ),
        );
      },
    );
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainOnBoardingViewRoute:
        return MaterialPageRoute(
            builder: (context) => const MainOnBoardingView());
      case Routes.mainLoginScreen:
        return MaterialPageRoute(
            builder: (context) => LoginScreen(
                  screenNumber: settings.arguments as int,
                ));
      case Routes.trainerSignUpScreen:
        var arg = settings.arguments as RegisterTrainerScreenView;
        return MaterialPageRoute(
            builder: (context) => RegisterTrainerScreenView(
                  userType: arg.userType,
                ));
      case Routes.verificationOtpScreen:
        var arg = settings.arguments as AccountVerificationScreenContent;
        return MaterialPageRoute(
          builder: (context) => AccountVerificationScreenContent(
            phone: arg.phone,
            userType: arg.userType,
          ),
        );
      case Routes.restaurantSignUpScreen:
        var arg = settings.arguments as RegisterRestaurantScreenView;
        return MaterialPageRoute(
            builder: (context) => RegisterRestaurantScreenView(
                  userType: arg.userType,
                ));
      case Routes.shopSignUpScreen:
        var arg = settings.arguments as RegisterShopScreenView;
        return MaterialPageRoute(
            builder: (context) => RegisterShopScreenView(
                  userType: arg.userType,
                ));
      case Routes.forgetPassScreen:
        var arg = settings.arguments as ForgotPasswordScreenContent;
        return MaterialPageRoute(
            builder: (context) => ForgotPasswordScreenContent(
                  userType: arg.userType,
                ));
      case Routes.forgetPassVerificationScreen:
        var arg = settings.arguments as ForgetPasswordVerificationScreenContent;
        return MaterialPageRoute(
            builder: (context) => ForgetPasswordVerificationScreenContent(
                  userType: arg.userType,
                  phone: arg.phone,
                ));
      case Routes.resetPass:
        var arg = settings.arguments as ResetPasswordScreen;
        return MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(
                  userType: arg.userType,
                  phone: arg.phone,
                  code: arg.code,
                ));
      // case Routes.homeTrainerScreen:
      //   return MaterialPageRoute(
      //       builder: (context) => const HomeTrainerScreen());
      // case Routes.homeRestScreen:
      //   return MaterialPageRoute(
      //       builder: (context) => const HomeRestaurantScreen());
      case Routes.traineeProfileScreen:
        return MaterialPageRoute(
            builder: (context) => TraineeProfileScreen(
                  args: settings.arguments as Map,
                ));
      case Routes.MyCourseDetailsScreen:
        return MaterialPageRoute(
            builder: (context) => MyCourseDetails(
                  courseId: settings.arguments as int,
                ));
      case Routes.myOrderScreen:
        return MaterialPageRoute(builder: (context) => const MyOrderView());
      case Routes.myCourseScreen:
        return MaterialPageRoute(builder: (context) => const MyCoursesView());
      case Routes.traineeScreen:
        return MaterialPageRoute(
            builder: (context) => const AllTraineeScreen());
      case Routes.editProfileScreen:
        return MaterialPageRoute(
            builder: (context) => EditProfileScreenContent());
      case Routes.editRestProfileScreen:
        return MaterialPageRoute(
            builder: (context) => EditRestaurantScreenContent());
      case Routes.editShopProfileScreen:
        return MaterialPageRoute(builder: (context) => EditShopScreenContent());
      case Routes.navigatorScreen:
        return MaterialPageRoute(
            builder: (context) => NavigatorScreen(
                  homeType: settings.arguments as int,
                ));
      case Routes.addCourseScreen:
        return MaterialPageRoute(builder: (context) => AddCourseView());

      // case Routes.campainScreenView:
      //   return MaterialPageRoute(
      //       builder: (context) =>
      //           CampainScreenView(campignData: settings.arguments as dynamic));
      // case Routes.phoneUpdatingScreen:
      //   return MaterialPageRoute(builder: (context) => PhoneUpdatingScreen());
      // case Routes.emailUpdateScreen:
      //   return MaterialPageRoute(builder: (context) => EmailUpdateScreen());
      // case Routes.blogScreenView:
      //   return MaterialPageRoute(
      //       builder: (context) => BlogScreenView(
      //         articleData: settings.arguments as dynamic,
      //       ));
      // case Routes.articlePregnancy:
      //   return MaterialPageRoute(
      //       builder: (context) => ArticlePregnancyView(
      //         articleData: settings.arguments as dynamic,
      //       ));
      // case Routes.homePage:
      //   return MaterialPageRoute(
      //       builder: (context) => ShowMoreScreen(
      //         index: settings.arguments as int,
      //       ));
      // case Routes.showMainSearch:
      //   return MaterialPageRoute(builder: (context) => SearchMainScreen());
      // case Routes.loginPage:
      //   return MaterialPageRoute(builder: (context) => LoginScreen());
      // case Routes.signUp:
      //   return MaterialPageRoute(builder: (context) => SignUpScreen());
      // case Routes.mainOnboarding:
      //   return MaterialPageRoute(builder: (context) => OnBoardingMainScreen());
      // case Routes.forgetPass:
      //   return MaterialPageRoute(builder: (context) => ForgetPassScreen());
      // case Routes.sendOtp:
      //   return MaterialPageRoute(
      //       builder: (context) => OTPChangePassScreen(
      //         email: settings.arguments as String,
      //       ));
      // case Routes.changePass:
      //   return MaterialPageRoute(
      //       builder: (context) => ChangePasswordScreen(
      //         otpCode: settings.arguments as String,
      //       ));
      // case Routes.notificationScreen:
      //   return MaterialPageRoute(
      //       builder: (context) => NotificationAlertScreen());
      // case Routes.termsAndCondition:
      //   return MaterialPageRoute(builder: (context) => TermsConditionScreen());
      // case Routes.changePassSettingScreen:
      //   return MaterialPageRoute(
      //       builder: (context) => ChangePasswordSettingScreen());
      // case Routes.settingScreen:
      //   return MaterialPageRoute(builder: (context) => SettingScreen());
      // case Routes.AboutScreen:
      //   return MaterialPageRoute(builder: (context) => AboutScreen());
      // case Routes.privacyScreen:
      //   return MaterialPageRoute(builder: (context) => PrivacyScreen());
      // case Routes.AccountSettingScreen:
      //   return MaterialPageRoute(builder: (context) => AccountSettingScreen());
      // case Routes.notificationSettingScreen:
      //   return MaterialPageRoute(builder: (context) => NotificationScreen());
      // case Routes.helpScreen:
      //   return MaterialPageRoute(builder: (context) => helpSettingScreen());
      // case Routes.onBoarding1:
      //   return MaterialPageRoute(builder: (context) => OnBoardingBody1());
      // case Routes.onBoarding2:
      //   return MaterialPageRoute(builder: (context) => OnBoardingBody2());
      // case Routes.onBoarding3:
      //   return MaterialPageRoute(builder: (context) => OnBoardingBody3());
      // case Routes.onBoarding4:
      //   return MaterialPageRoute(builder: (context) => OnBoardingBody4());
      // case Routes.onBoarding5:
      //   return MaterialPageRoute(builder: (context) => OnBoardingBody5());
      // case Routes.onBoarding6:
      //   return MaterialPageRoute(builder: (context) => OnBoardingBody6());
      // case Routes.periodRepeat:
      //   return MaterialPageRoute(builder: (context) => PeriodRepeat());
      // case Routes.flowRate:
      //   return MaterialPageRoute(builder: (context) => FLowRateScreen());
      // case Routes.myPageView:
      //   return MaterialPageRoute(builder: (context) => MyPageScreen());
      // case Routes.addSymptoms:
      //   return MaterialPageRoute(
      //       builder: (context) => AddSymptomsScreen(
      //         date: settings.arguments as String,
      //       ));
      // case Routes.otpSMS:
      //   return MaterialPageRoute(
      //       builder: (context) => OTPSMSScreen(
      //         email: settings.arguments as String,
      //       ));
      // case Routes.otpPhoneChange:
      //   return MaterialPageRoute(
      //       builder: (context) => OTPChangePhoneScreen(
      //           phoneNumber: settings.arguments as String));
      // case Routes.calenderDetailsScreen:
      //   return MaterialPageRoute(
      //       builder: (context) => CalenderScreenDetailsWithSymptoms(
      //         date: settings.arguments as String,
      //       ));
      // case Routes.changeLang:
      //   return MaterialPageRoute(
      //     builder: (context) => const ChangeLangScreen(),
      //   );
      // case Routes.homePage1:
      //   return MaterialPageRoute(builder: (context) => Add_symptoms_Screen());
      default:
        return errorRoute();
    }
  }
}
