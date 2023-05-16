import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainee_restaurantapp/features/trainer/home_trainer/data/repositories/home_trainer_repo.dart';

import '../../../../../core/models/course_model.dart';
import '../../../../../core/models/new_trainee_model.dart';
import '../../../../../core/models/trainee_in_progress_model.dart';
import '../../../../../core/ui/toast.dart';
part 'home_trainer_state.dart';

class HomeTrainerCubit extends Cubit<HomeTrainerState> {
  HomeTrainerCubit() : super(HomeTrainerInitial());

  static HomeTrainerCubit of(context) => BlocProvider.of(context);

  final homeTrainerRepo = HomeTrainerRepo();

  List<CourseModel>?  topCourses = [];
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
        topCourses = res;
        emit(GetMostWantedCoursesLoaded(

        ));
      },
    );
  }

  List<NewTraineeModel>?  newTrainees = [];
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
        newTrainees = res;
        emit(GetNewTraineesLoaded());
      },
    );
  }

  TraineeInProgressModel? trainee;
  Future getTrainee(int courseId , int traineeId) async {
    emit(GetTraineeLoading());
    final res = await homeTrainerRepo.getTrainee(traineeId, courseId);
    res.fold(
      (err) {
        print(err);
        Toast.show(err);
        emit(GetTraineeError());
      },
      (res) async {
        trainee = res;
        emit(GetTraineeLoaded());
      },
    );
  }
}
