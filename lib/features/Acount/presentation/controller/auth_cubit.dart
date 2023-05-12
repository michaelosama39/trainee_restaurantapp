import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:trainee_restaurantapp/features/Acount/data/models/register_restaurant_model.dart';
import '../../../../core/common/app_colors.dart';
import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/navigation/route_generator.dart';
import '../../../../core/ui/error_ui/error_viewer/error_viewer.dart';
import '../../../../core/ui/error_ui/error_viewer/snack_bar/errv_snack_bar_options.dart';
import '../../../../core/ui/toast.dart';
import '../../../../generated/l10n.dart';
import '../../data/repositories/auth_repo.dart';
import '../screens/account_verification.dart';
import '../screens/forget_password_verification.dart';
import 'package:file_picker/file_picker.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit of(context) => BlocProvider.of(context);

  final authRepo = AuthRepo();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController commercialNumberController = TextEditingController();
  TextEditingController restaurantManagerNameController =
      TextEditingController();
  TextEditingController phoneRestaurantController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();

  late String countryCode = AppConstants.DEFAULT_COUNTRY_CODE;

  bool isLoading = false;
  bool boxChecked = false;

  bool passwordSecure = true;
  bool confirmPasswordSecure = true;

  FocusNode phoneFocusNode = FocusNode();
  FocusNode idNumberFocusNode = FocusNode();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode cityManagerName = FocusNode();
  FocusNode restaurantName = FocusNode();
  FocusNode commercialNumber = FocusNode();
  FocusNode restaurantManagerName = FocusNode();
  FocusNode phoneRestaurantFocusNode = FocusNode();

  late String otpValue;
  File? file;

  Future resendCode(BuildContext context, String phone, int userType) async {
    unFocus(context);
    emit(ResendCodeLoading());
    final res = await authRepo.resendCode(phone, userType);
    res.fold(
      (err) {
        Toast.show(err);
        emit(ResendCodeError());
      },
      (res) async {
        Toast.show('تم ارسال الكود بنجاح');
        emit(ResendCodeLoaded());
      },
    );
  }

  Future verifyAccount(BuildContext context, String phone, int userType) async {
    if (formKey.currentState!.validate() && codeController.text.length == 6) {
      unFocus(context);
      emit(VerifyAccountLoading());
      isLoading = true;
      final res = await authRepo.verifyAccount(
        phone,
        codeController.text,
      );
      res.fold(
        (err) {
          isLoading = false;
          Toast.show(err);
          emit(VerifyAccountError());
        },
        (res) async {
          isLoading = false;
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.navigatorScreen, (route) => false,
              arguments: userType);
          emit(VerifyAccountLoaded());
        },
      );
    }
  }

  Future registerShop(BuildContext context, int userType) async {
    RegisterRestaurantModel model = RegisterRestaurantModel(
      name: restaurantNameController.text,
      email: emailController.text,
      password: passwordController.text,
      phoneNumber: phoneController.text,
      commercialRegisterDocument: file,
      commercialRegisterNumber: commercialNumberController.text,
      cityId: 1,
      managerCountryCode: countryCode,
      managerName: restaurantManagerNameController.text,
      managerPhoneNumber: phoneRestaurantController.text,
    );

    if (formKey.currentState!.validate()) {
      if (boxChecked) {
        unFocus(context);
        emit(RegisterShopLoading());
        isLoading = true;
        final res = await authRepo.registerShop(model);
        res.fold(
          (err) {
            isLoading = false;
            Toast.show(err);
            emit(RegisterShopError());
          },
          (res) async {
            await AppStorage.cacheUserInfo(res);
            Navigator.of(context).pushNamed(Routes.verificationOtpScreen,
                arguments: AccountVerificationScreenContent(
                    phone: phoneController.text, userType: userType));
            isLoading = false;
            emit(RegisterShopLoaded());
          },
        );
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
  }

  Future registerRestaurant(BuildContext context, int userType) async {
    RegisterRestaurantModel model = RegisterRestaurantModel(
      name: restaurantNameController.text,
      email: emailController.text,
      password: passwordController.text,
      phoneNumber: phoneController.text,
      commercialRegisterDocument: file,
      commercialRegisterNumber: commercialNumberController.text,
      cityId: 1,
      managerCountryCode: countryCode,
      managerName: restaurantManagerNameController.text,
      managerPhoneNumber: phoneRestaurantController.text,
    );

    if (formKey.currentState!.validate()) {
      if (boxChecked) {
        unFocus(context);
        emit(RegisterRestaurantLoading());
        isLoading = true;
        final res = await authRepo.registerRestaurant(model);
        res.fold(
          (err) {
            isLoading = false;
            Toast.show(err);
            emit(RegisterRestaurantError());
          },
          (res) async {
            await AppStorage.cacheUserInfo(res);
            Navigator.of(context).pushNamed(Routes.verificationOtpScreen,
                arguments: AccountVerificationScreenContent(
                    phone: phoneController.text, userType: userType));
            isLoading = false;
            emit(RegisterRestaurantLoaded());
          },
        );
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
  }

  Future registerTrainer(BuildContext context, int userType) async {
    if (formKey.currentState!.validate()) {
      if (boxChecked) {
        unFocus(context);
        emit(RegisterTrainerLoading());
        isLoading = true;
        final res = await authRepo.registerTrainer(
          phoneController.text,
          nameController.text,
          emailController.text,
          passwordController.text,
        );
        res.fold(
          (err) {
            isLoading = false;
            Toast.show(err);
            emit(RegisterTrainerError());
          },
          (res) async {
            await AppStorage.cacheUserInfo(res);
            Navigator.of(context).pushNamed(Routes.verificationOtpScreen,
                arguments: AccountVerificationScreenContent(
                    phone: phoneController.text, userType: userType));
            isLoading = false;
            emit(RegisterTrainerLoaded());
          },
        );
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
  }

  Future confirmForgotPassword(
      BuildContext context, String phone, String code, int userType) async {
    if (formKey.currentState!.validate()) {
      unFocus(context);
      emit(ForgetPasswordVerifyLoading());
      isLoading = true;
      final res = await authRepo.forgetPasswordVerify(
          phone, code, passwordController.text);
      res.fold(
        (err) {
          isLoading = false;
          Toast.show(err);
          emit(ForgetPasswordVerifyError());
        },
        (res) async {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.navigatorScreen, (route) => false,
              arguments: userType);
          isLoading = false;
          emit(ForgetPasswordVerifyLoaded());
        },
      );
    }
  }

  Future forgetPassword(BuildContext context, int userType) async {
    if (formKey.currentState!.validate()) {
      unFocus(context);
      emit(ForgetPasswordLoading());
      isLoading = true;
      final res = await authRepo.forgetPassword(
        phoneController.text,
      );
      res.fold(
        (err) {
          isLoading = false;
          Toast.show(err);
          emit(ForgetPasswordError());
        },
        (res) async {
          Navigator.pushNamed(
            context,
            Routes.forgetPassVerificationScreen,
            arguments: ForgetPasswordVerificationScreenContent(
              phone: phoneController.text,
              userType: userType,
            ),
          );
          isLoading = false;
          emit(ForgetPasswordLoaded());
        },
      );
    }
  }

  Future login(BuildContext context, int type) async {
    if (formKey.currentState!.validate()) {
      unFocus(context);
      emit(LoginLoading());
      isLoading = true;
      final res = await authRepo.login(
        phoneController.text,
        passwordController.text,
        type,
      );
      res.fold(
        (err) {
          isLoading = false;
          Toast.show(err);
          emit(LoginError());
        },
        (res) async {
          if (formKey.currentState!.validate());
          await AppStorage.cacheUserInfo(res);
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.navigatorScreen, (route) => false,
              arguments: type);
          isLoading = false;
          emit(LoginLoaded());
        },
      );
    }
  }

  unFocus(context) {
    if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
  }

  Future<File?> getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    }
    return null;
  }
}
