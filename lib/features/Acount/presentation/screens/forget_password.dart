import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/common/utils.dart';
import '../../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/constants/app/app_constants.dart';
import 'general_auth.dart';

class ForgotPasswordScreenContent extends StatefulWidget {
  const ForgotPasswordScreenContent({super.key});

  @override
  State<ForgotPasswordScreenContent> createState() =>
      _ForgotPasswordScreenContentState();
}

class _ForgotPasswordScreenContentState
    extends State<ForgotPasswordScreenContent> {
 // late ForgotPasswordScreenNotifier sn;
  bool isLoading = false;
  TextEditingController phoneController = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();
  late String countryCode = AppConstants.DEFAULT_COUNTRY_CODE;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
  //  sn = Provider.of<ForgotPasswordScreenNotifier>(context);
  //.  sn.context = context;
    return GeneralAuthScreen(
      isloading: isLoading,
      onButtonTap: _forgotPassword,
      additionalTapText: '',
      buttonText: Translation.of(context).send,
      onAdditionalTextTapped: () {},
      appBar: TransparentAppBar(
        title: Translation.of(context).forgot_password,
      ),
      additionalText: '',
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 0.16.sh,
            ),
            PhoneNumberTextField(
              onInputChanged: (code) => countryCode = code,
              textEditingController: phoneController,
              focusNode: phoneFocusNode,
              isoCode: countryCode,
              onFieldSubmitted: () {
                _forgotPassword();
              },
            ),
          ],
        ),
      ),
    );
  }

  unFocus() {
    unFocusList(focus: [
      phoneFocusNode,
    ]);
  }

  void _forgotPassword() {
    unFocus();
    if (formKey.currentState!.validate());
      // sn.accountCubit.forgotPassword(ForgotPasswordRequest(
      //   usernameOrEmailOrPhone: sn.phoneController.text,
      // ));
  }
}
