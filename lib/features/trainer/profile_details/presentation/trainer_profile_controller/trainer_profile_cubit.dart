import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainee_restaurantapp/core/models/trainer_model.dart';
import 'package:trainee_restaurantapp/features/trainer/profile_details/data/models/update_trainer_profile_model.dart';
import '../../../../../core/models/review_model.dart';
import '../../../../../core/ui/toast.dart';
import '../../../../navigator_home/view/navigator_home_view.dart';
import '../../data/repositories/trainer_profile_repo.dart';

part 'trainer_profile_state.dart';

class TrainerProfileCubit extends Cubit<TrainerProfileState> {
  TrainerProfileCubit() : super(TrainerProfileInitial());

  static TrainerProfileCubit of(context) => BlocProvider.of(context);

  final trainerProfileRepo = TrainerProfileRepo();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController hourRateController = TextEditingController();
  TextEditingController coachSpecializationController = TextEditingController();

  String imageUrl = '';
  String cvUrl = '';
  String experienceFiles = '';
  String? imageNetwork;
  File? file;

  TrainerModel? trainerModel;

  Future updateTrainerProfile(BuildContext context) async {
    UpdateTrainerProfileModel updateTrainerProfileModel =
        UpdateTrainerProfileModel(
      id: trainerModel!.id,
      specializationId: 1,
      phoneNumber: phoneController.text,
      // hourPrice: int.parse(hourRateController.text),
      idNumber: idNumberController.text,
      name: nameController.text,
    );

    emit(UpdateTranierProfileLoading());
    final res = await trainerProfileRepo
        .updateTrainerProfile(updateTrainerProfileModel);
    res.fold(
      (err) {
        Toast.show(err);
        emit(UpdateTranierProfileError());
      },
      (res) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => NavigatorScreen(homeType: 1)),
            (route) => false);
        emit(UpdateTranierProfileLoaded());
      },
    );
  }

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

  Future getTrainerReviews(BuildContext context) async {
    emit(GetTrainerReviewsLoading());
    final res = await trainerProfileRepo.getTrainerReviews();
    res.fold(
      (err) {
        print(err);
        Toast.show(err);
        emit(GetTrainerReviewsError());
      },
      (res) {
        emit(GetTrainerReviewsLoaded(res));
      },
    );
  }
}
