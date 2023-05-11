part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoaded extends AuthState {}
class LoginLoading extends AuthState {}
class LoginError extends AuthState {}

class RegisterTrainerLoaded extends AuthState {}
class RegisterTrainerLoading extends AuthState {}
class RegisterTrainerError extends AuthState {}

class RegisterRestaurantLoaded extends AuthState {}
class RegisterRestaurantLoading extends AuthState {}
class RegisterRestaurantError extends AuthState {}

class VerifyAccountLoaded extends AuthState {}
class VerifyAccountLoading extends AuthState {}
class VerifyAccountError extends AuthState {}

class ResendCodeLoaded extends AuthState {}
class ResendCodeLoading extends AuthState {}
class ResendCodeError extends AuthState {}

class ForgetPasswordLoaded extends AuthState {}
class ForgetPasswordLoading extends AuthState {}
class ForgetPasswordError extends AuthState {}

class ForgetPasswordVerifyLoaded extends AuthState {}
class ForgetPasswordVerifyLoading extends AuthState {}
class ForgetPasswordVerifyError extends AuthState {}

class PasswordSecureState extends AuthState {}
class UploadSignUpFileState extends AuthState {}
