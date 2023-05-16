import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:trainee_restaurantapp/features/trainer/add_course/data/repositories/add_course_repo.dart';
import 'package:trainee_restaurantapp/features/trainer/trainee/data/models/update_trainee_progress_model.dart';
import 'package:trainee_restaurantapp/features/trainer/trainee/data/repositories/trainee_repo.dart';
import '../../../../../core/ui/toast.dart';
import '../../../home_trainer/presentation/home_trainer_controller/home_trainer_cubit.dart';

part 'update_trainee_progress_state.dart';

class UpdateTraineeProgressCubit extends Cubit<UpdateTraineeProgressState> {
  UpdateTraineeProgressCubit() : super(UpdateTraineeProgressInitial());

  static UpdateTraineeProgressCubit of(context) => BlocProvider.of(context);

  final _updateTraineeProgress = UpdateTraineeProgressRepo();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode weightFocusNode = FocusNode();
  FocusNode fatPercentageFocusNode = FocusNode();
  FocusNode completedHoursFocusNode = FocusNode();
  FocusNode absenceCountFocusNode = FocusNode();


  final weightController = TextEditingController();
  final fatPercentageController = TextEditingController();
  final completedHoursController = TextEditingController();
  final absenceCountController = TextEditingController();


  Future updateTraineeProgress(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      UpdateTraineeProgressModel model = UpdateTraineeProgressModel(
        courseId: HomeTrainerCubit.of(context).trainee!.courseId!,
        traineeId: HomeTrainerCubit.of(context).trainee!.traineeId!,
        absenceCount: int.parse(absenceCountController.text),
        completedHours: int.parse(completedHoursController.text),
        weight: int.parse(weightController.text),
        fatPercentage: int.parse(fatPercentageController.text),
      );
      unFocus(context);
      emit(UpdateTraineeProgressLoading());
      final res = await _updateTraineeProgress.updateTraineeProgress(model);
      res.fold(
        (err) {
          Toast.show(err);
          emit(UpdateTraineeProgressError());
        },
        (res) async {
          Navigator.pop(context);
          emit(UpdateTraineeProgressLoaded());
        },
      );
    }
  }

  unFocus(context) {
    if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
  }

}
