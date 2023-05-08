import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee_restaurantapp/core/navigation/route_generator.dart';

import '../../../core/common/app_colors.dart';
import '../../../core/common/style/gaps.dart';
import '../../../core/constants/app/app_constants.dart';
import '../../../core/ui/widgets/custom_appbar.dart';
import '../../../core/ui/widgets/custom_text.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../generated/l10n.dart';
import 'general_auth.dart';

class LoginScreen extends StatefulWidget {
  final int screenNumber;

  const LoginScreen({Key? key, required this.screenNumber}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _login() {
    Navigator.pushNamedAndRemoveUntil(
            context, Routes.navigatorScreen, (route) => false,arguments:widget.screenNumber);
    // if (sn.formKey.currentState!.validate())
    //   sn.accountCubit.login(LoginRequest(
    //     userNameOrEmailAddress: sn.phoneController.text,
    //     password: sn.passwordController.text,
    //     rememberClient: true,
    //   ));
  }

  void _toForgotPassword() {
    Navigator.of(context).pushNamed(Routes.forgetPassScreen);
  }

  @override
  void dispose() {
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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool passwordSecure = true;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String countryCode = AppConstants.DEFAULT_COUNTRY_CODE;
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GeneralAuthScreen(
      appBar: TransparentAppBar(
        title: Translation.of(context).login,
      ),
      buttonText: Translation.of(context).login,
      additionalText: Translation.of(context).no_account,
      additionalTapText: Translation.of(context).signup2,
      isloading: isLoading,
      onButtonTap: _login,
      onAdditionalTextTapped: _offToSignupScreen,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 0.16.sh,
              ),
              PhoneNumberTextField(
                onInputChanged: (code) => countryCode = code,
                textEditingController: phoneController,
                isoCode: countryCode,
                focusNode: phoneFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: () {
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
              ),
              Gaps.vGap8,
              PasswordTextField(
                controller: passwordController,
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
  }
}
