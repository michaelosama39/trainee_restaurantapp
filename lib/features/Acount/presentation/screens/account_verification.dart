import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/common/app_colors.dart';
import '../../../../../core/common/style/gaps.dart';
import '../../../../../core/constants/app/app_constants.dart';
import '../../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../../core/ui/widgets/custom_pinput_widget.dart';
import '../../../../../core/ui/widgets/custom_text.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/navigation/route_generator.dart';
import 'general_auth.dart';

class AccountVerificationScreenContent extends StatefulWidget {
  const AccountVerificationScreenContent();

  @override
  State<AccountVerificationScreenContent> createState() =>
      _AccountVerificationScreenContentState();
}

class _AccountVerificationScreenContentState
    extends State<AccountVerificationScreenContent> {
  // late AccountVerificationScreenNotifier sn;
  // late RegisterScreenNotifier sn2;
  bool isLoading = false;
  TextEditingController pinCodeController = TextEditingController();
  late String phoneNumber = "01011153207";
  late String otpValue;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // sn2 = Provider.of<RegisterScreenNotifier>(context);
    // sn = Provider.of<AccountVerificationScreenNotifier>(context);
    // sn.context = context;
    return GeneralAuthScreen(
      onButtonTap: _verifyAccount,
      isloading: isLoading,
      additionalTapText: Translation.of(context).login2,
      buttonText: Translation.of(context).verify,
      onAdditionalTextTapped: _offLoginScreen,
      appBar: TransparentAppBar(
        title: Translation.of(context).account_verification,
      ),
      additionalText: Translation.of(context).account_exist,
      child: Form(
        key: formKey,
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
              onChanged: (OTPVal) => otpValue = OTPVal,
              controller: pinCodeController,
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
                    // sn2.submitPhoneNumber(
                    //     newPhone:
                    //     "${sn2.countryDial}${sn2.phoneController.text}");
                    debugPrint("mmm");
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
  }

  void _offLoginScreen() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.mainLoginScreen,
      (route) => false,
    );
  }

  void _verifyAccount() {
    debugPrint("ds");
    //   if (sn.pinCodeController.text.length == 6) {
    //     sn.accountCubit.verifyAccount(VerifyAccountRequest(
    //         usernameOrEmailOrPhone: sn.phoneNumber, code: "000000"));
    //     sn2.submitOTP(sn.otpValue);
    //
    //   } else
    //     ErrorViewer.showError(
    //         errorViewerOptions:
    //         const ErrVSnackBarOptions(backgroundColor: AppColors.grey),
    //         context: context,
    //         error: CustomError(message: Translation.of(context).enter_pin_code),
    //         callback: () {});
  }
}
