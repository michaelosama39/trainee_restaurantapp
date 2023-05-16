part of 'update_trainee_progress_cubit.dart';

@immutable
abstract class UpdateTraineeProgressState {}

class UpdateTraineeProgressInitial extends UpdateTraineeProgressState {}
class UpdateTraineeProgressLoading extends UpdateTraineeProgressState {}
class UpdateTraineeProgressLoaded extends UpdateTraineeProgressState {}
class UpdateTraineeProgressError extends UpdateTraineeProgressState {}

