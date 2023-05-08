import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/ui/error_ui/error_viewer/error_viewer.dart';
import '../../../../core/ui/error_ui/error_viewer/snack_bar/errv_snack_bar_options.dart';
import '../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../core/ui/widgets/custom_checkBox.dart';
import '../../../../core/ui/widgets/custom_text.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../generated/l10n.dart';
import '../../../core/common/style/dimens.dart';
import '../../../core/navigation/route_generator.dart';
import 'general_auth.dart';

class RegisterTrainerScreenView extends StatefulWidget {
  const RegisterTrainerScreenView({super.key});

  @override
  State<RegisterTrainerScreenView> createState() => _RegisterTrainerScreenViewState();
}

class _RegisterTrainerScreenViewState extends State<RegisterTrainerScreenView> {
  @override
  Widget build(BuildContext context) {
    // sn = Provider.of<RegisterScreenNotifier>(context);
    // sn.context = context;
    return _buildScreen();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool passwordSecure = true;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String countryCode = AppConstants.DEFAULT_COUNTRY_CODE;
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode idNumber = FocusNode();
  FocusNode userName = FocusNode();
  FocusNode coatchSpecialist = FocusNode();
  FocusNode hourRate = FocusNode();
  bool confirmPasswordSecure = true;
  bool boxChecked = false;
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController coatchSpecialistController = TextEditingController();
  TextEditingController hourRateController = TextEditingController();
  late String countryDial = AppConstants.DEFAULT_COUNTRY_DIAL;

  FocusNode confirmPasswordFocusNode = FocusNode();

  _buildScreen() {
    return GeneralAuthScreen(
      additionalText: Translation.of(context).account_exist,
      onButtonTap: _signup,
      additionalTapText: Translation.of(context).login2,
      buttonText: Translation.of(context).signUp,
      isloading: isLoading,
      appBar: TransparentAppBar(
        title: Translation.of(context).signUp,
      ),
      onAdditionalTextTapped: _offToLoginScreen,
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
                //onDialChanged: (dial)=>countryDial=dial,
                textEditingController: phoneController,
                isoCode: countryCode,
                focusNode: phoneFocusNode,
                onFieldSubmitted: () {
                  FocusScope.of(context).requestFocus(userName);
                },
              ),
              Gaps.vGap8,
              EmailTextField(
                text: Translation.of(context).userName,
                onFiledSubmitted: () {
                  FocusScope.of(context).requestFocus(idNumber);
                },
                textInputAction: TextInputAction.next,
                controller: nameController,
                focusNode: userName,
              ),
              EmailTextField(
                text: Translation.of(context).idNumber,
                onFiledSubmitted: () {
                  FocusScope.of(context).requestFocus(hourRate);
                },
                textInputAction: TextInputAction.next,
                controller: idController,
                focusNode: idNumber,
              ),
              Gaps.vGap8,
              EmailTextField(
                text: Translation.of(context).hourRate,
                onFiledSubmitted: () {
                  FocusScope.of(context).requestFocus(coatchSpecialist);
                },
                textInputAction: TextInputAction.next,
                controller: hourRateController,
                focusNode: hourRate,
              ),
              Gaps.vGap8,
              EmailTextField(
                text: Translation.of(context).coach_specialization,
                onFiledSubmitted: () {
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
                textInputAction: TextInputAction.next,
                controller: coatchSpecialistController,
                focusNode: coatchSpecialist,
              ),
              Gaps.vGap8,
              PasswordTextField(
                controller: passwordController,
                passwordSecure: passwordSecure,
                textInputAction: TextInputAction.next,
                focusNode: passwordFocusNode,
                onFiledSubmitted: () {
                  FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
                },
                hidePassword: (bool) {
                  // setState(() {
                  //   sn.passwordSecure = bool;
                  // });
                },
              ),
              Gaps.vGap8,
              PasswordTextField(
                controller: confirmPasswordController,
                passwordSecure: confirmPasswordSecure,
                textInputAction: TextInputAction.done,
                focusNode: confirmPasswordFocusNode,
                isConfirmPassword: true,
                otherPasswordController: passwordController,
                onFiledSubmitted: () {},
                hidePassword: (bool) {
                  setState(() {
                    confirmPasswordSecure = bool;
                  });
                },
              ),
              Gaps.vGap8,
              uploadSignUpFile(text: Translation.of(context).cV, onTap: () {}),
              Gaps.vGap8,
              uploadSignUpFile(
                  onTap: () {},
                  text: Translation.of(context).experienceCertification),
              Gaps.vGap8,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text: Translation.of(context).accept_on,
                  ),
                  Gaps.hGap4,
                  CustomText(
                    text: Translation.of(context).terms,
                    color: AppColors.accentColorLight,
                    fontSize: AppConstants.textSize14,
                    fontWeight: FontWeight.bold,
                  ),
                  Gaps.hGap4,
                  CustomText(
                    text: Translation.of(context).following,
                  ),
                  const Spacer(),
                  Transform.scale(
                    scale: 1.5,
                    child: CustomCheckbox(
                      checkColor: AppColors.white,
                      activeColor: AppColors.accentColorLight,
                      value: boxChecked,
                      onChanged: (value) => setState(() {
                        boxChecked = value!;
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  unFocus() {
    if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
  }

  _signup() {
    unFocus();
    if (formKey.currentState!.validate()) ;
    if (boxChecked) {
      // sn.accountCubit.register(RegisterRequest(
      //   phoneNumber: sn.phoneController.text,
      //   countryCode: sn.countryCode,
      //   password: sn.passwordController.text,
      // ));
      // debugPrint("${sn.countryDial}${sn.phoneController.text}");
      // sn.submitPhoneNumber(newPhone: "${sn.countryDial}${sn.phoneController.text}");
      Navigator.of(context).pushNamed(Routes.verificationOtpScreen);
    } else {
      ErrorViewer.showError(
          errorViewerOptions:
              const ErrVSnackBarOptions(backgroundColor: AppColors.grey),
          context: context,
          error: CustomError(
              message: Translation.of(context).accept_terms_conditions),
          callback: () {});
    }
  }

  _offToLoginScreen() {
    Navigator.pop(context);
  }

  uploadSignUpFile({required void Function()? onTap, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 120.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.hGap20,
              CustomText(
                  text: text,
                  fontSize: AppConstants.textSize18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accentColorLight),
              Gaps.hGap12,
              DottedBorder(
                color: AppColors.white,
                dashPattern: const [10, 3],
                radius: Radius.circular(10),
                borderType: BorderType.Rect,
                strokeWidth: 3,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((Dimens.dp12))),
                  height: Dimens.dp80.h,
                  width: double.infinity,
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.upload,
                      color: AppColors.accentColorLight,
                      size: Dimens.dp40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
