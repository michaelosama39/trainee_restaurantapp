import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/common/app_config.dart';
import 'core/common/provider_list.dart';
import 'core/constants/app/app_constants.dart';
import 'core/localization/flutter_localization.dart';
import 'core/navigation/navigation_service.dart';
import 'core/navigation/route_generator.dart';
import 'features/navigator_home/view/navigator_home_view.dart';
import 'features/on_boarding/view/main_onboarding_view.dart';
import 'features/restaurant/add_plate/view/add_plate_view.dart';
import 'features/restaurant/add_plate/view/success_plate_add.dart';
import 'features/restaurant/home_restaurant/view/home_restaurant_view.dart';
import 'features/restaurant/my_orders_restaurant/view/my_order_view.dart';
import 'features/restaurant/my_plates/view/all_plates_screen.dart';
import 'features/restaurant/my_plates/view/plate_setails_view.dart';
import 'features/restaurant/restaurant_profile/view/edit_restaurant_profile.dart';
import 'features/restaurant/restaurant_profile/view/restaurant_profile.dart';
import 'features/splash/presentation/screen/splash_screen.dart';
import 'features/trainer/add_course/view/add_course_view.dart';
import 'features/trainer/add_course/view/success_course_add.dart';
import 'features/trainer/chat/view/chat_details_view.dart';
import 'features/trainer/chat/view/chat_view.dart';
import 'features/trainer/home_trainer/view/home_trainer_view.dart';
import 'features/trainer/my_courses/view/my_course_view.dart';
import 'features/trainer/my_orders/view/my_order_view.dart';
import 'features/trainer/profile_details/view/edit_profile_trainer_screen.dart';
import 'features/trainer/profile_details/view/profile_view_screen.dart';
import 'features/trainer/trainee/view/all_trainee_screen.dart';
import 'generated/l10n.dart';

class App extends StatefulWidget {
  static final GlobalKey<NavigatorState> globalKey =
      GlobalKey<NavigatorState>();

  const App({
    Key? key,
  }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return RestartWidget(
      child: MultiProvider(
        providers: [
          ...ApplicationProvider().dependItems,
          Provider.value(value: routeObserver),
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
                  navigatorKey: App.globalKey,
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
                    provider.changeLanguage(
                        const Locale(AppConstants.LANG_AR), context);

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
    );
  }

  @override
  void dispose() {
    ApplicationProvider().dispose(context);
    super.dispose();
  }
}
