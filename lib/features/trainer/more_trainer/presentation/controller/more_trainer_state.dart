part of 'more_trainer_cubit.dart';

@immutable
abstract class MoreTrainerState {}

class MoreTrainerInitial extends MoreTrainerState {}
class CreateReportLoading extends MoreTrainerState {}
class CreateReportLoaded extends MoreTrainerState {}
class CreateReportError extends MoreTrainerState {}
