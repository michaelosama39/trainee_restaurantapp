import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:trainee_restaurantapp/features/restaurant/my_orders_restaurant/controller/my_orders_restaurant_cubit.dart';
import 'package:trainee_restaurantapp/features/restaurant/restaurant_profile/rest_profile_controller/rest_profile_cubit.dart';
import 'package:trainee_restaurantapp/features/shop/my_orders_shop/controller/my_orders_shop_cubit.dart';
import 'package:trainee_restaurantapp/features/trainer/chat/view/video_screen.dart';
import 'package:trainee_restaurantapp/features/trainer/chat/view/voice_screen.dart';
import 'package:trainee_restaurantapp/features/trainer/home_trainer/presentation/home_trainer_controller/home_trainer_cubit.dart';
import 'package:trainee_restaurantapp/features/trainer/my_courses/presentation/courses_controller/courses_cubit.dart';
import 'package:trainee_restaurantapp/features/trainer/profile_details/presentation/trainer_profile_controller/trainer_profile_cubit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import 'core/appStorage/app_storage.dart';
import 'core/common/app_config.dart';
import 'core/common/provider_list.dart';
import 'core/constants/app/app_constants.dart';
import 'core/localization/flutter_localization.dart';
import 'core/navigation/route_generator.dart';
import 'features/restaurant/home_restaurant/controller/home_restaurant_cubit.dart';
import 'features/restaurant/my_plates/controller/my_plates_cubit.dart';
import 'features/shop/my_products/controller/my_products_cubit.dart';
import 'features/shop/shop_profile/shop_profile_controller/shop_profile_cubit.dart';
import 'features/splash/presentation/screen/splash_screen.dart';
import 'features/trainer/my_orders/presentation/controller/booking_request_cubit.dart';
import 'generated/l10n.dart';

class App extends StatefulWidget {
  static final GlobalKey<NavigatorState> globalKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> navigatorKey;

  const App({
    Key? key, required this.navigatorKey,
  }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();



class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    getToken();
  }

  void getToken()async{

    if (AppStorage.isLogged) {
      onUserLogin();
    }
  }
  /// on App's user login
  void onUserLogin() {
    /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged in or re-logged in
    /// We recommend calling this method as soon as the user logs in to your app.
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: 172297515 /*input your AppID*/,
      appSign: "7088d2ea9432e77970a85beeb177953cbee5b6a7b41845280e1a1c4d39ac813e" /*input your AppSign*/,
      userID: AppStorage.getUserId.toString(),
      userName:HomeTrainerCubit.of(context)
          .trainee!.trainee!.name ?? "",
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }

  /// on App's user logout
  void onUserLogout() {
    /// 1.2.2. de-initialization ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged out
    ZegoUIKitPrebuiltCallInvitationService().uninit();
  }
  @override
  Widget build(BuildContext context) {
    return RestartWidget(
      child: MultiProvider(
        providers: [
          ...ApplicationProvider().dependItems,
          Provider.value(value: routeObserver),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => BookingRequestCubit()),
            BlocProvider(
              create: (context) =>
                  TrainerProfileCubit()..getTrainerProfile(context),
            ),
            BlocProvider(
              create: (context) =>
              RestProfileCubit()..getRestaurantProfile(context),
            ),
            BlocProvider(
              create: (context) =>
              ShopProfileCubit()..getShopProfile(context),
            ),
            BlocProvider(
              create: (context) =>
                  HomeTrainerCubit()..getMostWantedCourses(context),
            ),
            BlocProvider(create: (context) => TrainerProfileCubit()..getTrainerProfile(context),),
            BlocProvider(create: (context) => HomeTrainerCubit()..getMostWantedCourses(context)..getNewTrainees(context),),
            BlocProvider(create: (context) => CoursesCubit()),
            BlocProvider(create: (context) => MyOrdersRestaurantCubit()),
            BlocProvider(create: (context) => HomeRestaurantCubit()),
            BlocProvider(create: (context) => MyPlatesCubit()),
            BlocProvider(create: (context) => MyProductsCubit()),
            BlocProvider(create: (context) => MyOrdersShopCubit()),
          ],
          child: Consumer<LocalizationProvider>(
            builder: (_, provider, __) {
              return ScreenUtilInit(
                designSize: AppConfig.screenUtilDesignSize(),
                builder: (context, Widget? child) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: AppConstants.TITLE_APP_NAME,

                    /// Routing
                    // navigatorKey: App.globalKey,
                    navigatorKey: widget.navigatorKey,
                    onGenerateRoute: AppRoute().generateRoute,
                    initialRoute: "/",

                    navigatorObservers: [routeObserver],

                    /// Setup app localization
                    supportedLocales: Translation.delegate.supportedLocales,
                    locale: provider.appLocal,

                    localizationsDelegates: const [
                      Translation.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      // Built-in localization of basic text for Material widgets
                      // GlobalMaterialLocalizations.delegate,
                      // // Built-in localization for text direction LTR/RTL
                      // GlobalWidgetsLocalizations.delegate,
                      // GlobalCupertinoLocalizations.delegate,
                      // DefaultCupertinoLocalizations.delegate,
                      // GlobalCupertinoLocalizations.delegate
                    ],

                    /// Run app at first time on device language
                    localeResolutionCallback: (locale, supportedLocales) {
                      // if (provider.firstStart) {
                      //   provider.changeLanguage(
                      //       const Locale(AppConstants.LANG_AR), context);
                      //   provider.firstStartOff();
                      // provider.changeLanguage(
                      //     const Locale(AppConstants.LANG_AR), context);

                      /// Check if the current device locale is supported
                      /*for (var supportedLocale in supportedLocales) {
                              if (supportedLocale.languageCode ==
                                  locale!.languageCode) {
                                /// Set _firstStart false
                                provider.firstStartOff();

                                /// Change language
                                provider.changeLanguage(
                                  Locale(locale.languageCode),
                                  context,
                                );
                                return supportedLocale;
                              }
                            }

                            /// If the locale of the device is not supported, use the first one
                            /// from the list (English, in this case).
                            provider.changeLanguage(
                              supportedLocales.first,
                              context,
                            );
                            return supportedLocales.first;*/
                      //    }
                    },

                    /// Theming
                    theme: AppConfig().themeData,
                    themeMode: AppConfig().themeMode,

                    /// Init screen
                    home: SplashScreen(),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    ApplicationProvider().dispose(context);
    super.dispose();
  }
}
