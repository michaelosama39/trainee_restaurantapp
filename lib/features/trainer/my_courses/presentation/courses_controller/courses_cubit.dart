import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainee_restaurantapp/features/trainer/home_trainer/data/repositories/home_trainer_repo.dart';

import '../../../../../core/models/course_model.dart';
import '../../../../../core/ui/toast.dart';
import '../../data/repositories/courses_repo.dart';
part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(AuthInitial());

  static CoursesCubit of(context) => BlocProvider.of(context);

  final coursesRepo = CoursesRepo();

  Future getCourses(BuildContext context,{bool? isActive , bool? isFinished}) async {
    emit(GetCoursesLoading());
    final res = await coursesRepo.getCourses(isActive: isActive,isFinished: isFinished);
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

}
