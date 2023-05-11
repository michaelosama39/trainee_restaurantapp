part of 'trainer_profile_cubit.dart';

@immutable
abstract class TrainerProfileState {}

class AuthInitial extends TrainerProfileState {}

class GetTrainerProfileLoaded extends TrainerProfileState {}
class GetTrainerProfileLoading extends TrainerProfileState {}
class GetTrainerProfileError extends TrainerProfileState {}

