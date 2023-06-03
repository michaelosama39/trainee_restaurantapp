import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/common/app_colors.dart';
import '../../../../../core/common/style/gaps.dart';
import '../../../../../core/constants/app/app_constants.dart';
import '../../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../../core/ui/widgets/custom_checkBox.dart';
import '../../../../../core/ui/widgets/custom_text.dart';
import '../../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/common/style/dimens.dart';
import '../controller/auth_cubit.dart';
import 'general_auth.dart';

class RegisterShopScreenView extends StatefulWidget {
  const RegisterShopScreenView({super.key, required this.userType});

  final int userType;

  @override
  State<RegisterShopScreenView> createState() => _RegisterShopScreenViewState();
}

class _RegisterShopScreenViewState extends State<RegisterShopScreenView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (previous, current) =>
            previous != current ||
            current is RegisterShopLoaded ||
            current is RegisterShopLoading ||
            current is PasswordSecureState ||
            current is UploadSignUpFileState,
        builder: (context, state) {
          return GeneralAuthScreen(
            additionalText: Translation.of(context).account_exist,
            onButtonTap: () => _signup(context),
            additionalTapText: Translation.of(context).login2,
            buttonText: Translation.of(context).signUp,
            isloading: AuthCubit.of(context).isLoading,
            appBar: TransparentAppBar(
              title: Translation.of(context).signUp,
            ),
            onAdditionalTextTapped: _offToLoginScreen,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: AuthCubit.of(context).formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 0.16.sh,
                    ),
                    PhoneNumberTextField(
                      onInputChanged: (code) =>
                          AuthCubit.of(context).countryCode = code,
                      //onDialChanged: (dial)=>countryDial=dial,
                      textEditingController:
                          AuthCubit.of(context).phoneController,
                      isoCode: AuthCubit.of(context).countryCode,
                      focusNode: AuthCubit.of(context).phoneFocusNode,
                      onFieldSubmitted: () {
                        FocusScope.of(context)
                            .requestFocus(AuthCubit.of(context).emailFocusNode);
                      },
                    ),
                    Gaps.vGap8,
                    // EmailTextField(
                    //   text: Translation.of(context).userName,
                    //   onFiledSubmitted: () {
                    //     FocusScope.of(context)
                    //         .requestFocus(AuthCubit.of(context).emailFocusNode);
                    //   },
                    //   textInputAction: TextInputAction.next,
                    //   controller: AuthCubit.of(context).nameController,
                    //   focusNode: AuthCubit.of(context).userNameFocusNode,
                    // ),
                    EmailTextField(
                      text: Translation.of(context).email,
                      onFiledSubmitted: () {
                        FocusScope.of(context)
                            .requestFocus(AuthCubit.of(context).restaurantName);
                      },
                      textInputAction: TextInputAction.next,
                      controller: AuthCubit.of(context).emailController,
                      focusNode: AuthCubit.of(context).emailFocusNode,
                    ),
                    Gaps.vGap8,
                    EmailTextField(
                      text: Translation.of(context).shopName,
                      onFiledSubmitted: () {
                        FocusScope.of(context).requestFocus(
                            AuthCubit.of(context).commercialNumber);
                      },
                      textInputAction: TextInputAction.next,
                      controller:
                          AuthCubit.of(context).restaurantNameController,
                      focusNode: AuthCubit.of(context).restaurantName,
                    ),
                    Gaps.vGap8,
                    EmailTextField(
                      text: Translation.of(context).commericalNumber,
                      onFiledSubmitted: () {
                        // FocusScope.of(context).requestFocus(passwordFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                      controller:
                          AuthCubit.of(context).commercialNumberController,
                      focusNode: AuthCubit.of(context).commercialNumber,
                    ),
                    Gaps.vGap8,
                    uploadSignUpFile(
                      text: Translation.of(context).commericalFile,
                      file: AuthCubit.of(context).file,
                      onTap: () async {
                        AuthCubit.of(context).file =
                            await AuthCubit.of(context).getFile();
                        AuthCubit.of(context).uploadImage(context, AuthCubit.of(context).file!);
                        AuthCubit.of(context).emit(UploadSignUpFileState());
                      },
                    ),
                    Gaps.vGap8,
                    EmailTextField(
                      text: Translation.of(context).shopManagerName,
                      onFiledSubmitted: () {
                        FocusScope.of(context).requestFocus(
                            AuthCubit.of(context).phoneRestaurantFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                      controller:
                          AuthCubit.of(context).restaurantManagerNameController,
                      focusNode: AuthCubit.of(context).restaurantManagerName,
                    ),
                    Gaps.vGap8,
                    PhoneNumberTextField(
                      hint: Translation.of(context).shopPhoneNumber,
                      onInputChanged: (code) =>
                          AuthCubit.of(context).countryCode = code,
                      //onDialChanged: (dial)=>countryDial=dial,
                      textEditingController:
                          AuthCubit.of(context).phoneRestaurantController,
                      isoCode: AuthCubit.of(context).countryCode,
                      focusNode: AuthCubit.of(context).phoneRestaurantFocusNode,
                      onFieldSubmitted: () {
                        FocusScope.of(context).requestFocus(
                            AuthCubit.of(context).cityManagerName);
                      },
                    ),
                    Gaps.vGap8,
                    // EmailTextField(
                    //   text: Translation.of(context).cityName,
                    //   onFiledSubmitted: () {
                    //     FocusScope.of(context).requestFocus(
                    //         AuthCubit.of(context).passwordFocusNode);
                    //   },
                    //   textInputAction: TextInputAction.next,
                    //   controller: AuthCubit.of(context).cityNameController,
                    //   focusNode: AuthCubit.of(context).cityManagerName,
                    // ),
                    // Gaps.vGap8,
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
                      controller:
                          AuthCubit.of(context).confirmPasswordController,
                      passwordSecure:
                          AuthCubit.of(context).confirmPasswordSecure,
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
                    // InkWell(
                    //   onTap: (){
                    //     AuthCubit.of(context).onLocationClick(context);
                    //   },
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(
                    //       vertical: 10.h,
                    //     ),
                    //     child: Align(
                    //       alignment: AlignmentDirectional.centerStart,
                    //       child: Text(
                    //         'تحديد موقعك',
                    //         style: TextStyle(
                    //           fontSize: 16.sp,
                    //           color: AppColors.white,
                    //           decoration: TextDecoration.underline,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
                            value: AuthCubit.of(context).boxChecked,
                            onChanged: (value) => setState(() {
                              AuthCubit.of(context).boxChecked = value!;
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
        },
      ),
    );
  }

  unFocus() {
    if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
  }

  _signup(context) {
    AuthCubit.of(context).registerShop(context, widget.userType);
  }

  _offToLoginScreen() {
    Navigator.pop(context);
  }

  uploadSignUpFile(
      {required void Function()? onTap, required String text, File? file}) {
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
                radius: const Radius.circular(10),
                borderType: BorderType.Rect,
                strokeWidth: 3,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((Dimens.dp12))),
                  height: Dimens.dp80.h,
                  width: double.infinity,
                  child: file == null
                      ? const Center(
                          child: FaIcon(
                            FontAwesomeIcons.upload,
                            color: AppColors.accentColorLight,
                            size: Dimens.dp40,
                          ),
                        )
                      : Image.file(file),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
