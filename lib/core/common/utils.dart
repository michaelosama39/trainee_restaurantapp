import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app/app_constants.dart';
import '../constants/enums/app_theme_enum.dart';
import '../localization/localization_provider.dart';
import '../localization/restart_widget.dart';
import '../navigation/navigation_service.dart';
import '../theme/theme_colors.dart';
import '../theme/theme_config.dart';
import 'app_config.dart';

/// This function for move cursor from A to B
/// and will be take 3 parameter
/// [context] to know which screen we are
/// [currentFocus] where are you now ? which text form field
/// [nextFocus] where will be when called this function
/// [changeTheme] to change application theme
fieldFocusChange(
  BuildContext context,
  FocusNode currentFocus,
  FocusNode nextFocus,
) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

/// This for unFocus nodes
unFocusList({required List<FocusNode> focus}) {
  focus.forEach((element) {
    element.unfocus();
  });
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

changeTheme(BuildContext context) async {
  var brightness = Theme.of(context).brightness;
  await AppConfig().persistAppTheme(
    brightness == Brightness.light ? AppThemes.DARK : AppThemes.LIGHT,
  );
  ThemeSwitcher.of(context).changeTheme(
    theme: brightness == Brightness.light
        ? ThemeConfig().darkTheme
        : ThemeConfig().lightTheme,
    isReversed: brightness == Brightness.dark ? true : false,
  );
  ThemeColors().updateThemeMode();
}

Future<LocationData?> getMyLocation() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
  }
  _locationData = await location.getLocation();
  print(_locationData.longitude.toString() +
      ' ' +
      _locationData.latitude.toString());
  return _locationData;
}

String getTranslation(
    {required BuildContext context,
    String? arText,
    String? enText,
    String? alternativeText}) {
  return Provider.of<LocalizationProvider>(context).appLocal.languageCode ==
              AppConstants.LANG_EN &&
          enText != null
      ? enText
      : arText != null
          ? arText
          : alternativeText ?? '';
}

logout() async {
  RestartWidget.restartApp(NavigationService().appContext!);
}
