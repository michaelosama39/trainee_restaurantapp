part of 'trainer_profile_cubit.dart';

@immutable
abstract class TrainerProfileState {}

class TrainerProfileInitial extends TrainerProfileState {}

class GetTrainerProfileLoaded extends TrainerProfileState {}
class GetTrainerProfileLoading extends TrainerProfileState {}
class GetTrainerProfileError extends TrainerProfileState {}

class GetTrainerReviewsLoaded extends TrainerProfileState {
  final List<ReviewModel> reviews;

  GetTrainerReviewsLoaded(this.reviews);
}
class GetTrainerReviewsLoading extends TrainerProfileState {}
class GetTrainerReviewsError extends TrainerProfileState {}

