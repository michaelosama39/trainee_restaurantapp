import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainee_restaurantapp/features/trainer/home_trainer/data/repositories/home_trainer_repo.dart';

import '../../../../../core/models/course_model.dart';
import '../../../../../core/models/review_model.dart';
import '../../../../../core/ui/toast.dart';
import '../../data/repositories/courses_repo.dart';
part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesInitial());

  static CoursesCubit of(context) => BlocProvider.of(context);

  final _coursesRepo = CoursesRepo();

  CourseModel? courseModel;

  Future getCourses(BuildContext context,{bool? isActive , bool? isFinished}) async {
    emit(GetCoursesLoading());
    final res = await _coursesRepo.getCourses(isActive: isActive,isFinished: isFinished);
    res.fold(
      (err) {
        print(err);
        Toast.show(err);
        emit(GetCoursesError());
      },
      (res) {
        emit(GetCoursesLoaded(
          res
        ));
      },
    );
  }

  Future getCourseReviews(BuildContext context,int courseId) async {
    emit(GetCourseReviewsLoading());
    final res = await _coursesRepo.getCourseReviews(courseId);
    res.fold(
          (err) {
        print(err);
        Toast.show(err);
        emit(GetCourseReviewsError());
      },
          (res) {
        emit(GetCourseReviewsLoaded(
            res
        ));
      },
    );
  }

  Future getCourse(BuildContext context,int courseId) async {
    emit(GetCourseLoading());
    final res = await _coursesRepo.getCourse(courseId);
    res.fold(
          (err) {
        print(err);
        Toast.show(err);
        emit(GetCourseError());
      },
          (res) {
            courseModel = res;
        emit(GetCourseLoaded());
      },
    );
  }

}
