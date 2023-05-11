import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee_restaurantapp/core/navigation/route_generator.dart';
import 'package:trainee_restaurantapp/features/Acount/presentation/controller/auth_cubit.dart';
import 'package:trainee_restaurantapp/features/Acount/presentation/screens/register_screen_trainer.dart';

import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../core/ui/widgets/custom_text.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../generated/l10n.dart';
import 'forget_password.dart';
import 'general_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen(
      {Key? key,
      required this.userType,
      required this.phone,
      required this.code})
      : super(key: key);

  final int userType;
  final String phone;
  final String code;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (previous, current) =>
            previous != current ||
            current is ForgetPasswordVerifyLoaded ||
            current is ForgetPasswordVerifyLoading ||
            current is PasswordSecureState,
        builder: (context, state) {
          return GeneralAuthScreen(
            isloading: AuthCubit.of(context).isLoading,
            onButtonTap: () => AuthCubit.of(context).confirmForgotPassword(
                context, widget.phone, widget.code, widget.userType),
            additionalTapText: '',
            buttonText: Translation.of(context).send,
            onAdditionalTextTapped: () {},
            appBar: TransparentAppBar(
              title: Translation.of(context).forgot_password,
            ),
            additionalText: '',
            child: Form(
              key: AuthCubit.of(context).formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 0.16.sh,
                  ),
                  PasswordTextField(
                    controller: AuthCubit.of(context).passwordController,
                    passwordSecure: AuthCubit.of(context).passwordSecure,
                    textInputAction: TextInputAction.next,
                    focusNode: AuthCubit.of(context).passwordFocusNode,
                    onFiledSubmitted: () {
                      FocusScope.of(context).requestFocus(
                          AuthCubit.of(context).confirmPasswordFocusNode);
                    },
                    hidePassword: (bool) {
                      AuthCubit.of(context).passwordSecure = bool;
                      AuthCubit.of(context).emit(PasswordSecureState());
                    },
                  ),
                  Gaps.vGap8,
                  PasswordTextField(
                    controller: AuthCubit.of(context).confirmPasswordController,
                    passwordSecure: AuthCubit.of(context).confirmPasswordSecure,
                    textInputAction: TextInputAction.done,
                    focusNode: AuthCubit.of(context).confirmPasswordFocusNode,
                    isConfirmPassword: true,
                    otherPasswordController:
                        AuthCubit.of(context).passwordController,
                    onFiledSubmitted: () {},
                    hidePassword: (bool) {
                      AuthCubit.of(context).confirmPasswordSecure = bool;
                      AuthCubit.of(context).emit(PasswordSecureState());
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
