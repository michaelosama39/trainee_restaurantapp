import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../generated/l10n.dart';
import '../controller/auth_cubit.dart';
import 'general_auth.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key, required this.screenNumber}) : super(key: key);

  final int screenNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (previous, current) =>
            previous != current || current is PasswordSecureState,
        builder: (context, state) {
          return GeneralAuthScreen(
            appBar: TransparentAppBar(
              title: 'تغيير كلمه السر',
            ),
            buttonText: 'تغيير',
            additionalText: '',
            additionalTapText: '',
            isloading: AuthCubit.of(context).isLoading,
            onButtonTap: () {
              AuthCubit.of(context).changePassword(
                context,
                screenNumber,
              );
            },
            onAdditionalTextTapped: () {},
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: AuthCubit.of(context).formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 0.16.sh,
                    ),
                    PasswordTextField(
                      text: 'كلمه السر القديمه',
                      controller: AuthCubit.of(context).passwordController,
                      passwordSecure: AuthCubit.of(context).passwordSecure,
                      textInputAction: TextInputAction.done,
                      focusNode: AuthCubit.of(context).passwordFocusNode,
                      hidePassword: (bool) {
                        AuthCubit.of(context).passwordSecure = bool;
                        AuthCubit.of(context).emit(PasswordSecureState());
                      },
                    ),
                    Gaps.vGap8,
                    PasswordTextField(
                      text: 'كلمه السر الجديده',
                      controller: AuthCubit.of(context).confirmPasswordController,
                      passwordSecure:
                          AuthCubit.of(context).confirmPasswordSecure,
                      textInputAction: TextInputAction.done,
                      onFiledSubmitted: () {
                        AuthCubit.of(context).changePassword(
                          context,
                          screenNumber,
                        );
                      },
                      focusNode: AuthCubit.of(context).confirmPasswordFocusNode,
                      hidePassword: (bool) {
                        AuthCubit.of(context).confirmPasswordSecure = bool;
                        AuthCubit.of(context).emit(PasswordSecureState());
                      },
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
