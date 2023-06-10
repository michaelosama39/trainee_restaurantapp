import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:trainee_restaurantapp/features/Acount/data/models/create_restaurant_model.dart';
import 'package:trainee_restaurantapp/features/Acount/data/models/create_shop_model.dart';
import 'package:trainee_restaurantapp/features/Acount/data/models/register_restaurant_model.dart';
import 'package:trainee_restaurantapp/features/Acount/presentation/screens/create_restaurant_screen.dart';
import 'package:trainee_restaurantapp/features/Acount/presentation/screens/create_shop_screen.dart';
import '../../../../core/common/app_colors.dart';
import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/location/LocationAddressImports.dart';
import '../../../../core/location/location_cubit/location_cubit.dart';
import '../../../../core/location/model/location_model.dart';
import '../../../../core/navigation/route_generator.dart';
import '../../../../core/ui/error_ui/error_viewer/error_viewer.dart';
import '../../../../core/ui/error_ui/error_viewer/snack_bar/errv_snack_bar_options.dart';
import '../../../../core/ui/toast.dart';
import '../../../../core/utils/Utils.dart';
import '../../../../generated/l10n.dart';
import '../../../navigator_home/view/navigator_home_view.dart';
import '../../../on_boarding/view/main_onboarding_view.dart';
import '../../data/models/specialization_model.dart';
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
  TextEditingController descArController = TextEditingController();
  TextEditingController descEnController = TextEditingController();
  TextEditingController commercialNumberController = TextEditingController();
  TextEditingController restaurantManagerNameController =
      TextEditingController();
  TextEditingController phoneRestaurantController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();

  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController buildNumController = TextEditingController();
  TextEditingController mangerController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instegramController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController nameArController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();
  TextEditingController commercialRegisterNumberController =
      TextEditingController();

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
  FocusNode descAr = FocusNode();
  FocusNode descEn = FocusNode();
  FocusNode restaurantManagerName = FocusNode();
  FocusNode phoneRestaurantFocusNode = FocusNode();

  File? fileLogoAr;
  File? fileLogoEn;
  File? fileCoveEn;
  File? fileCoveAr;
  File? fileCommercialRegisterDoc;

  String? imgLogoAr;
  String? imgLogoEn;
  String? imgCoveEn;
  String? imgCoveAr;
  String? imgCommercialRegisterDoc;

  String? logoArNetwork;
  String? logoEnNetwork;
  String? coveArNetwork;
  String? coveEnNetwork;

  List<Items> listSpecialization = [];
  Items? dropdownValueCate;

  final LocationCubit locationCubit = LocationCubit();

  late String otpValue;
  File? file;

  String? img;

  late String verificationId;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future assignSubscriptionToUser(
      BuildContext context, int subscriptionId, int type) async {
    emit(AssignSubscriptionToUserLoading());
    final res = await authRepo.assignSubscriptionToUser(subscriptionId, type);
    res.fold(
      (err) {
        Toast.show(err);
        emit(AssignSubscriptionToUserError());
      },
      (res) async {
        Toast.show('تم بنجاح');
        emit(AssignSubscriptionToUserLoaded());
      },
    );
  }

  Future<void> submitPhoneNumber({newPhone}) async {
    debugPrint("*" * 50);
    debugPrint("*" * 50);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: newPhone ?? "+2001011153207",
      timeout: const Duration(seconds: 5),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeRetrivalTimeOut,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    debugPrint("${credential.smsCode}");
    debugPrint("creadintial complated");
    await auth.signInWithCredential(credential);
  }

  void verificationFailed(FirebaseAuthException e) {
    debugPrint("Error in verification");
  }

  bool countState = false;

  codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    countState = true;
  }

  void codeRetrivalTimeOut(String verificationId) {
    debugPrint("code Auto rerival Time");
  }

  Future<bool> submitOTP(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);

    await smsSignIn(credential).whenComplete(() {
      return true;
    });
    return false;
  }

  Future<void> smsSignIn(PhoneAuthCredential credential) async {
    try {
      await auth.signInWithCredential(credential);
    } catch (error) {
      print(error);
    }
  }

  Future uploadImage(BuildContext context, File file) async {
    emit(UploadImageLoading());
    final res = await authRepo.uploadImage(file);
    res.fold(
      (err) {
        Toast.show(err);
        emit(AuthInitial());
      },
      (res) async {
        if (file == fileLogoAr) {
          imgLogoAr = res;
        } else if (file == fileLogoEn) {
          imgLogoEn = res;
        } else if (file == fileCoveEn) {
          imgCoveEn = res;
        } else if (file == fileCoveAr) {
          imgCoveAr = res;
        } else if (file == fileCommercialRegisterDoc) {
          imgCommercialRegisterDoc = res;
        }
        emit(UploadImageLoaded());
      },
    );
  }

  Future getSpecialization() async {
    emit(GetSpecializationLoading());
    final res = await authRepo.getSpecialization();
    res.fold(
      (err) {
        Toast.show(err);
      },
      (res) {
        listSpecialization.addAll(res.result!.items ?? []);
        emit(GetSpecializationLoaded());
      },
    );
  }

  Future logout(BuildContext context) async {
    emit(LogoutLoading());
    final res = await authRepo.logout(context);
    res.fold(
      (err) {
        Toast.show(err);
        emit(AuthInitial());
      },
      (res) async {
        AppStorage.signOut();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainOnBoardingView()),
            (route) => false);
        emit(LogoutLoaded());
      },
    );
  }

  Future changePassword(BuildContext context, int typeUser) async {
    if (formKey.currentState!.validate()) {
      emit(ChangePasswordLoading());
      isLoading = true;
      final res = await authRepo.changePassword(
          passwordController.text, confirmPasswordController.text);
      res.fold(
        (err) {
          isLoading = false;
          Toast.show(err);
          emit(AuthInitial());
        },
        (res) async {
          isLoading = false;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NavigatorScreen(
                    homeType: typeUser,
                  )));
          emit(ChangePasswordLoaded());
        },
      );
    }
  }

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
        '000000',
      );
      res.fold(
        (err) {
          isLoading = false;
          Toast.show(err);
          emit(VerifyAccountError());
        },
        (res) async {
          isLoading = false;
          if (userType == 1) {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.mainLoginScreen, (route) => false,
                arguments: userType);
            emit(VerifyAccountLoaded());
          } else if (userType == 3) {
            login(context, userType, phone);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    CreateRestaurantScreen(phone: phone, userType: userType)));
            emit(VerifyAccountLoaded());
          } else if (userType == 4) {
            login(context, userType, phone);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    CreateShopScreen(phone: phone, userType: userType)));
          }
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
      commercialRegisterDocument: imgCommercialRegisterDoc,
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
            print('$countryCode${phoneRestaurantController.text}');
            submitPhoneNumber(
                newPhone: "$countryCode${phoneRestaurantController.text}");
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AccountVerificationScreenContent(
                      phone: '${phoneRestaurantController.text}',
                      userType: userType,
                    )));
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
      commercialRegisterDocument: imgCommercialRegisterDoc,
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
        print(await model.toJson());
        res.fold(
          (err) {
            isLoading = false;
            Toast.show(err);
            emit(RegisterRestaurantError());
          },
          (res) async {
            submitPhoneNumber(
                newPhone: "$countryCode${phoneRestaurantController.text}");
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AccountVerificationScreenContent(
                      phone: '${phoneRestaurantController.text}',
                      userType: userType,
                    )));
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
          dropdownValueCate!.id!,
        );
        res.fold(
          (err) {
            print(err);
            isLoading = false;
            Toast.show(err);
            emit(RegisterTrainerError());
          },
          (res) async {
            submitPhoneNumber(newPhone: "$countryCode${phoneController.text}");
            Navigator.of(context).pushNamed(Routes.verificationOtpScreen,
                arguments: AccountVerificationScreenContent(
                  phone: "${phoneController.text}",
                  userType: userType,
                ));
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const MainOnBoardingView()));
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

  Future login(BuildContext context, int type, [String? phone]) async {
    if (formKey.currentState!.validate()) {
      int subId = 0;
      if (type == 1) {
        subId = 1000;
      } else if (type == 3) {
        subId = 1001;
      } else if (type == 4) {
        subId = 1002;
      }
      unFocus(context);
      emit(LoginLoading());
      isLoading = true;
      final res = await authRepo.login(
        phone ?? phoneController.text,
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
          assignSubscriptionToUser(context, subId, type);
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

  Future<XFile?> getImage() async {
    ImagePicker picker = ImagePicker();
    var result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      return result;
    }
  }

  onLocationClick(context) async {
    var _loc = await Utils.getCurrentLocation(context);
    locationCubit.onLocationUpdated(LocationModel(
      lat: _loc?.latitude ?? 32.4,
      lng: _loc?.longitude ?? 32.4,
      address: "",
    ));
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, __) {
          return FadeTransition(
              opacity: animation,
              child: BlocProvider.value(
                value: locationCubit,
                child: LocationAddress(),
              ));
        },
      ),
    );
  }

  Future createRestaurant(
      BuildContext context, int userType, String phone) async {
    CreateRestaurantModel model = CreateRestaurantModel(
      arName: nameArController.text,
      enName: nameEnController.text,
      arLogo: imgLogoAr!,
      enLogo: imgLogoEn!,
      arCover: imgCoveAr!,
      enCover: imgCoveEn!,
      arDescription: descArController.text,
      enDescription: descEnController.text,
      commercialRegisterDocument: imgCommercialRegisterDoc!,
      commercialRegisterNumber: commercialNumberController.text,
      managerName: restaurantManagerNameController.text,
      facebookUrl: facebookController.text,
      instagramUrl: instegramController.text,
      twitterUrl: twitterController.text,
      websiteUrl: websiteController.text,
      latitude: locationCubit.state.model!.lat,
      longitude: locationCubit.state.model!.lng,
    );

    if (formKey.currentState!.validate()) {
      unFocus(context);
      emit(RegisterRestaurantLoading());
      isLoading = true;
      final res = await authRepo.createRestaurant(model);
      res.fold(
        (err) {
          isLoading = false;
          Toast.show(err);
          emit(RegisterRestaurantError());
        },
        (res) async {
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.mainLoginScreen,
            (route) => false,
          );
          isLoading = false;
          emit(RegisterRestaurantLoaded());
        },
      );
    }
  }

  Future createShop(BuildContext context, int userType, String phone) async {
    CreateShopModel model = CreateShopModel(
      arName: nameArController.text,
      enName: nameEnController.text,
      arLogo: imgLogoAr!,
      enLogo: imgLogoEn!,
      arCover: imgCoveAr!,
      enCover: imgCoveEn!,
      arDescription: descArController.text,
      enDescription: descEnController.text,
      commercialRegisterDocument: imgCommercialRegisterDoc!,
      commercialRegisterNumber: commercialNumberController.text,
      managerName: restaurantManagerNameController.text,
      facebookUrl: facebookController.text,
      instagramUrl: instegramController.text,
      twitterUrl: twitterController.text,
      websiteUrl: websiteController.text,
      latitude: locationCubit.state.model!.lat,
      longitude: locationCubit.state.model!.lng,
    );

    if (formKey.currentState!.validate()) {
      unFocus(context);
      emit(RegisterShopLoading());
      isLoading = true;
      final res = await authRepo.createShop(model);
      res.fold(
        (err) {
          isLoading = false;
          Toast.show(err);
          emit(RegisterShopError());
        },
        (res) async {
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.mainLoginScreen,
                (route) => false,
          );
          isLoading = false;
          emit(RegisterRestaurantLoaded());
        },
      );
    }
  }
}
