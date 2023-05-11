part of 'home_trainer_cubit.dart';

@immutable
abstract class HomeTrainerState {}

class AuthInitial extends HomeTrainerState {}

class GetMostWantedCoursesLoaded extends HomeTrainerState {
  final List<CourseModel> mostWantedCourse;
  GetMostWantedCoursesLoaded(this.mostWantedCourse);
}
class GetMostWantedCoursesLoading extends HomeTrainerState {}
class GetMostWantedCoursesError extends HomeTrainerState {}

class GetNewTraineesLoaded extends HomeTrainerState {}
class GetNewTraineesLoading extends HomeTrainerState {}
class GetNewTraineesError extends HomeTrainerState {}
