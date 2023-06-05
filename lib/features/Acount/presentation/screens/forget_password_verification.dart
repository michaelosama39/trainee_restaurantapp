import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee_restaurantapp/features/Acount/presentation/controller/auth_cubit.dart';
import 'package:trainee_restaurantapp/features/Acount/presentation/screens/reset_password_screen.dart';
import '../../../../../core/common/app_colors.dart';
import '../../../../../core/common/style/gaps.dart';
import '../../../../../core/constants/app/app_constants.dart';
import '../../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../../core/ui/widgets/custom_pinput_widget.dart';
import '../../../../../core/ui/widgets/custom_text.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/navigation/route_generator.dart';
import '../../../../core/ui/toast.dart';
import 'general_auth.dart';

class ForgetPasswordVerificationScreenContent extends StatefulWidget {
  const ForgetPasswordVerificationScreenContent(
      {super.key, required this.phone, required this.userType});

  final String phone;
  final int userType;

  @override
  State<ForgetPasswordVerificationScreenContent> createState() =>
      _ForgetPasswordVerificationScreenContentState();
}

class _ForgetPasswordVerificationScreenContentState
    extends State<ForgetPasswordVerificationScreenContent> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return GeneralAuthScreen(
            onButtonTap: () => _verify(context),
            isloading: AuthCubit.of(context).isLoading,
            additionalTapText: Translation.of(context).login2,
            buttonText: Translation.of(context).verify,
            onAdditionalTextTapped: _offLoginScreen,
            appBar: TransparentAppBar(
              title: Translation.of(context).account_verification,
            ),
            additionalText: Translation.of(context).account_exist,
            child: Form(
              key: AuthCubit.of(context).formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 0.0578.sh,
                  ),
                  CustomText(
                    text: Translation.of(context).verification_code_sent,
                    fontSize: AppConstants.textSize14,
                  ),
                  Gaps.vGap4,
                  CustomText(
                    text: Translation.of(context).insert_verification_code,
                    fontSize: AppConstants.textSize14,
                  ),
                  SizedBox(
                    height: 0.0615.sh,
                  ),
                  CustomPinPut(
                    onChanged: (OTPVal) =>
                        AuthCubit.of(context).otpValue = OTPVal,
                    controller: AuthCubit.of(context).codeController,
                  ),
                  Gaps.vGap30,
                  Row(
                    children: [
                      CustomText(
                        text: Translation.of(context).no_code_received,
                      ),
                      Gaps.hGap4,
                      GestureDetector(
                        onTap: () {
                          AuthCubit.of(context).resendCode(
                              context, widget.phone, widget.userType);
                        },
                        child: CustomText(
                          text: Translation.of(context).resend_code,
                          color: AppColors.accentColorLight,
                          fontSize: AppConstants.textSize14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _offLoginScreen() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.mainLoginScreen,
      (route) => false,
    );
  }

  void _verify(context) {
    if (AuthCubit.of(context).codeController.text.length == 6) {
      AuthCubit.of(context).submitOTP(AuthCubit.of(context).codeController.text);
      // AuthCubit.of(context).verifyAccount(context, widget.phone, widget.userType);
      Navigator.of(context).pushNamed(
        Routes.resetPass,
        arguments: ResetPasswordScreen(
          userType: widget.userType,
          phone: widget.phone,
          code: AuthCubit.of(context).codeController.text,
        ),
      );
    } else {
      Toast.show('برجاء كتابه كود التحقق');
    }
  }
}
