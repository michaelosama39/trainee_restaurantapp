import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../bloc/app_config/app_config_cubit.dart';
import '../localization/localization_provider.dart';
/// Centralizing all app providers in one class to be easy to adjust and read
class ApplicationProvider {
  static ApplicationProvider _instance = ApplicationProvider._init();

  factory ApplicationProvider() => _instance;

  ApplicationProvider._init();

  List<SingleChildWidget> singleItems = [];

  List<SingleChildWidget> dependItems = [
    /// Change notifier provider
    ChangeNotifierProvider.value(
      value: LocalizationProvider(),
    ),
    // ChangeNotifierProvider.value(
    //   value: getIt<SessionDataProvider>(),
    //),

    /// Bloc provider
    BlocProvider(
      create: (context) => AppConfigCubit(),
    ),
    // BlocProvider(
    //   create: (context) => AccountCubit(),
    //   lazy: true,
    // ),
  ];

  List<SingleChildWidget> uiChangesItems = [];

  void dispose(BuildContext context) {
    Provider.of<LocalizationProvider>(context).dispose();
    Provider.of<AppConfigCubit>(context).close();
    // Provider.of<AccountCubit>(context).close();
    // Provider.of<SessionDataProvider>(context).dispose();
  }
}
