part of 'add_course_cubit.dart';

@immutable
abstract class AddCourseState {}

class AddCourseInitial extends AddCourseState {}
class AddCourseLoading extends AddCourseState {}
class AddCourseLoaded extends AddCourseState {}
class AddCourseError extends AddCourseState {}
class UploadSignUpFileState extends AddCourseState {}

class UploadImageLoading extends AddCourseState {}
class UploadImageLoaded extends AddCourseState {}

class GetCategoryLoading extends AddCourseState {}
class GetCategoryLoaded extends AddCourseState {}