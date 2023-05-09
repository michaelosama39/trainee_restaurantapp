import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/appStorage/app_storage.dart';
import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/navigation/route_generator.dart';
import '../../../../core/ui/toast.dart';
import '../../data/repositories/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit of(context) => BlocProvider.of(context);

  final authRepo = AuthRepo();

  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String countryCode = AppConstants.DEFAULT_COUNTRY_CODE;
  bool isLoading = false;

  // disposeData(){
  //   formKeyLogin.currentState!.dispose();
  //   phoneController.clear();
  //   passwordController.clear();
  //   countryCode = AppConstants.DEFAULT_COUNTRY_CODE;
  //   isLoading = false;
  // }

  Future login(BuildContext context , int type) async {
    if(formKeyLogin.currentState!.validate()){
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
          AppStorage.cacheUserInfo(res);
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.navigatorScreen, (route) => false,
              arguments: type);
          isLoading = false;
          emit(LoginLoaded());
        },
      );
    }
  }
}
