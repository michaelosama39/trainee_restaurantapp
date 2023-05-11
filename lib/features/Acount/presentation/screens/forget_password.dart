import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/constants/app/app_constants.dart';
import '../controller/auth_cubit.dart';
import 'general_auth.dart';

class ForgotPasswordScreenContent extends StatefulWidget {
  const ForgotPasswordScreenContent({super.key, required this.userType});

  final int userType;

  @override
  State<ForgotPasswordScreenContent> createState() =>
      _ForgotPasswordScreenContentState();
}

class _ForgotPasswordScreenContentState
    extends State<ForgotPasswordScreenContent> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (previous, current) =>
            previous != current ||
            current is ForgetPasswordLoaded ||
            current is ForgetPasswordLoading ||
            current is PasswordSecureState,
        builder: (context, state) {
          return GeneralAuthScreen(
            isloading: AuthCubit.of(context).isLoading,
            onButtonTap: () => AuthCubit.of(context).forgetPassword(
              context,
              widget.userType,
            ),
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
                  PhoneNumberTextField(
                    onInputChanged: (code) => AuthCubit.of(context).countryCode = code,
                    textEditingController: AuthCubit.of(context).phoneController,
                    focusNode: AuthCubit.of(context).phoneFocusNode,
                    isoCode: AuthCubit.of(context).countryCode,
                    onFieldSubmitted: () {
                      AuthCubit.of(context).forgetPassword(
                        context,
                        widget.userType,
                      );
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
