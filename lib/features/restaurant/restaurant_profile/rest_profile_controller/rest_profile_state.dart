part of 'rest_profile_cubit.dart';

@immutable
abstract class RestProfileState {}

class RestProfileInitial extends RestProfileState {}

class GetRestProfileLoading extends RestProfileState {}

class GetRestProfileLoaded extends RestProfileState {}

class GetRestProfileError extends RestProfileState {}

class UpdateRestProfileLoading extends RestProfileState {}

class UpdateRestProfileLoaded extends RestProfileState {}

class UpdateRestProfileError extends RestProfileState {}

class GetImageState extends RestProfileState {}

class UploadImageLoading extends RestProfileState {}

class UploadImageLoaded extends RestProfileState {}