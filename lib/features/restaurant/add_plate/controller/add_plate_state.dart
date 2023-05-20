part of 'add_plate_cubit.dart';

@immutable
abstract class AddPlateState {}

class AddPlateInitial extends AddPlateState {}
class AddPlateLoading extends AddPlateState {}
class AddPlateLoaded extends AddPlateState {}
class AddPlateError extends AddPlateState {}

class GetCategoryLoading extends AddPlateState {}
class GetCategoryLoaded extends AddPlateState {}

class UploadSignUpFileState extends AddPlateState {}
