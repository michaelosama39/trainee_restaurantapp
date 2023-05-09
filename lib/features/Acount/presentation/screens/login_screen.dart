import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee_restaurantapp/core/navigation/route_generator.dart';
import 'package:trainee_restaurantapp/features/Acount/presentation/controller/auth_cubit.dart';

import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../core/ui/widgets/custom_text.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../generated/l10n.dart';
import 'general_auth.dart';

class LoginScreen extends StatefulWidget {
  final int screenNumber;

  const LoginScreen({Key? key, required this.screenNumber}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _login(BuildContext context) {
    AuthCubit.of(context).login(
      context,
      widget.screenNumber,
    );
  }

  void _toForgotPassword() {
    Navigator.of(context).pushNamed(Routes.forgetPassScreen);
  }

  @override
  void dispose() {
    // AuthCubit.of(context).disposeData();
    super.dispose();
  }

  void _offToSignupScreen() {
    widget.screenNumber == 0
        ? Navigator.pushNamed(context, Routes.trainerSignUpScreen)
        : widget.screenNumber == 1
            ? Navigator.pushNamed(context, Routes.restaurantSignUpScreen)
            : Navigator.pushNamed(context, Routes.shopSignUpScreen);
    //  Nav.off(RegisterScreen.routeName, cleanHistory: true);
  }

  bool passwordSecure = true;
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (previous, current) =>
            previous != current ||
            current is LoginLoaded ||
            current is LoginLoading,
        builder: (context, state) {
          return GeneralAuthScreen(
            appBar: TransparentAppBar(
              title: Translation.of(context).login,
            ),
            buttonText: Translation.of(context).login,
            additionalText: Translation.of(context).no_account,
            additionalTapText: Translation.of(context).signup2,
            isloading: AuthCubit.of(context).isLoading,
            onButtonTap: () => _login(context),
            onAdditionalTextTapped: _offToSignupScreen,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: AuthCubit.of(context).formKeyLogin,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 0.16.sh,
                    ),
                    PhoneNumberTextField(
                      onInputChanged: (code) =>
                          AuthCubit.of(context).countryCode = code,
                      textEditingController:
                          AuthCubit.of(context).phoneController,
                      isoCode: AuthCubit.of(context).countryCode,
                      focusNode: phoneFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: () {
                        FocusScope.of(context).requestFocus(passwordFocusNode);
                      },
                    ),
                    Gaps.vGap8,
                    PasswordTextField(
                      controller: AuthCubit.of(context).passwordController,
                      passwordSecure: passwordSecure,
                      textInputAction: TextInputAction.done,
                      onFiledSubmitted: () {
                        //  _login();
                      },
                      focusNode: passwordFocusNode,
                      hidePassword: (bool) {
                        // setState(() {
                        //   sn.passwordSecure = bool;
                        // });
                      },
                    ),
                    Gaps.vGap14,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: _toForgotPassword,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CustomText(
                              text: Translation.of(context).forgot_password,
                              color: AppColors.accentColorLight,
                              fontSize: AppConstants.textSize14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
