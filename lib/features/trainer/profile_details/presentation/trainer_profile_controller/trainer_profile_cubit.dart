import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainee_restaurantapp/core/models/trainer_model.dart';
import 'package:trainee_restaurantapp/features/trainer/home_trainer/data/repositories/home_trainer_repo.dart';

import '../../../../../core/ui/toast.dart';
import '../../data/repositories/trainer_profile_repo.dart';
part 'trainer_profile_state.dart';

class TrainerProfileCubit extends Cubit<TrainerProfileState> {
  TrainerProfileCubit() : super(AuthInitial());

  static TrainerProfileCubit of(context) => BlocProvider.of(context);

  final trainerProfileRepo = TrainerProfileRepo();

  TrainerModel? trainerModel;

  Future getTrainerProfile(BuildContext context) async {
    emit(GetTrainerProfileLoading());
    final res = await trainerProfileRepo.getTrainerProfile();
    res.fold(
      (err) {
        print(err);
        Toast.show(err);
        emit(GetTrainerProfileError());
      },
      (res) {
        print(res.id);
        trainerModel = res;
        emit(GetTrainerProfileLoaded());
      },
    );
  }

}
