import 'package:flutter/material.dart';
import 'navigation_service.dart';

/// Class to make navigation calling shorter and faster to use
class Nav {
  /// Push
  static Future<T?> to<T extends Object?>(
    String routeName, {
    BuildContext? context,
    Object? arguments,
  }) {
    return Navigator.pushNamed(
      context ?? NavigationService().appContext!,
      routeName,
      arguments: arguments,
    );
  }

  /// Push replacement
  static Future<T?> off<T extends Object?, TO extends Object?>(
    String routeName, {
    BuildContext? context,
    TO? result,
    bool cleanHistory = false,
    Object? arguments,
  }) {
    if (cleanHistory) {
      return Navigator.pushNamedAndRemoveUntil(
          context ?? NavigationService().appContext!,
          routeName,
          (route) => false,
          arguments: arguments);
    } else
      return Navigator.pushReplacementNamed(
        context ?? NavigationService().appContext!,
        routeName,
        result: result,
        arguments: arguments,
      );
  }

  /// Pop
  static void pop<T extends Object?>([BuildContext? context, T? result]) {
    if (Navigator.canPop(context ?? NavigationService().appContext!))
      Navigator.pop(context ?? NavigationService().appContext!, result);
    else
      throw Exception("Can't go back to the previous screen");
  }

  static String? getCurrentPath(BuildContext context) {
    return ModalRoute.of(context)?.settings.name;
  }

  /// Pop until
  static void popTo(bool Function(Route<dynamic>) predicate,
      {BuildContext? context}) {
    Navigator.popUntil(
        context ?? NavigationService().appContext!, predicate);
  }
}
