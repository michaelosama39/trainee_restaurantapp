import 'package:flutter/painting.dart';
import 'package:get_it/get_it.dart';
import '../style/text_styles.dart';
/// Extension on [Color] class to make an easy predefined [TextStyle] from a
/// specific color
extension TextStyleExt on Color {
  TextStyle get bodyText1 => AppTextStyles().bodyText1.copyWith(color: this);
  TextStyle get bodyText2 => AppTextStyles().bodyText2.copyWith(color: this);
  TextStyle get button => AppTextStyles().button.copyWith(color: this);
  TextStyle get caption => AppTextStyles().caption.copyWith(color: this);
  TextStyle get headline1 => AppTextStyles().headline1.copyWith(color: this);
  TextStyle get headline2 => AppTextStyles().headline2.copyWith(color: this);
  TextStyle get headline3 => AppTextStyles().headline3.copyWith(color: this);
  TextStyle get headline4 => AppTextStyles().headline4.copyWith(color: this);
  TextStyle get headline5 => AppTextStyles().headline5.copyWith(color: this);
  TextStyle get headline6 => AppTextStyles().headline6.copyWith(color: this);
  TextStyle get overline => AppTextStyles().overline.copyWith(color: this);
  TextStyle get subtitle1 => AppTextStyles().subtitle1.copyWith(color: this);
  TextStyle get subtitle2 => AppTextStyles().subtitle2.copyWith(color: this);
}
