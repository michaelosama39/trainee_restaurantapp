import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainee_restaurantapp/features/trainer/home_trainer/data/repositories/home_trainer_repo.dart';

import '../../../../../core/models/course_model.dart';
import '../../../../../core/ui/toast.dart';
part 'home_trainer_state.dart';

class HomeTrainerCubit extends Cubit<HomeTrainerState> {
  HomeTrainerCubit() : super(AuthInitial());

  static HomeTrainerCubit of(context) => BlocProvider.of(context);

  final homeTrainerRepo = HomeTrainerRepo();

  Future getMostWantedCourses(BuildContext context) async {
    emit(GetMostWantedCoursesLoading());
    final res = await homeTrainerRepo.getMostWantedCourses();
    res.fold(
      (err) {
        print(err);
        Toast.show(err);
        emit(GetMostWantedCoursesError());
      },
      (res) {
        emit(GetMostWantedCoursesLoaded(
          res
        ));
      },
    );
  }
  Future getNewTrainees(BuildContext context) async {
    emit(GetNewTraineesLoading());
    final res = await homeTrainerRepo.getNewTrainees();
    res.fold(
      (err) {
        print(err);
        Toast.show(err);
        emit(GetNewTraineesError());
      },
      (res) async {
        emit(GetNewTraineesLoaded());
      },
    );
  }
}
