import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:trainee_restaurantapp/features/restaurant/restaurant_profile/rest_profile_controller/rest_profile_cubit.dart';
import 'package:trainee_restaurantapp/features/trainer/home_trainer/presentation/home_trainer_controller/home_trainer_cubit.dart';
import 'package:trainee_restaurantapp/features/trainer/my_courses/presentation/courses_controller/courses_cubit.dart';
import 'package:trainee_restaurantapp/features/trainer/profile_details/presentation/trainer_profile_controller/trainer_profile_cubit.dart';

import 'core/common/app_config.dart';
import 'core/common/provider_list.dart';
import 'core/constants/app/app_constants.dart';
import 'core/localization/flutter_localization.dart';
import 'core/navigation/route_generator.dart';
import 'features/splash/presentation/screen/splash_screen.dart';
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
        child: MultiBlocProvider(
          providers: [
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
                  HomeTrainerCubit()..getMostWantedCourses(context),
            ),
            BlocProvider(create: (context) => TrainerProfileCubit()..getTrainerProfile(context),),
            BlocProvider(create: (context) => HomeTrainerCubit()..getMostWantedCourses(context)..getNewTrainees(context),),
            BlocProvider(create: (context) => CoursesCubit()),
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
      ),
    );
  }

  @override
  void dispose() {
    ApplicationProvider().dispose(context);
    super.dispose();
  }
}
