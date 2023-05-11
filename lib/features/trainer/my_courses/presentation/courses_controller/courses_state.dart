part of 'courses_cubit.dart';

@immutable
abstract class CoursesState {}

class AuthInitial extends CoursesState {}

class GetCoursesLoaded extends CoursesState {
  final List<CourseModel> courses;
  GetCoursesLoaded(this.courses);
}
class GetCoursesLoading extends CoursesState {}
class GetCoursesError extends CoursesState {}

