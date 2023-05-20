import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import '../../../../../core/ui/toast.dart';
import '../../data/repositories/more_trainer_repo.dart';
part 'more_trainer_state.dart';

class MoreTrainerCubit extends Cubit<MoreTrainerState> {
  MoreTrainerCubit() : super(MoreTrainerInitial());

  static MoreTrainerCubit of(context) => BlocProvider.of(context);

  final moreTrainerRepo = MoreTrainerRepo();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode subjectFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();


  final subjectController = TextEditingController();
  final descController = TextEditingController();


  Future addFeedback(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      unFocus(context);
      emit(CreateReportLoading());
      final res = await moreTrainerRepo.addFeedback(subjectController.text,descController.text);
      res.fold(
        (err) {
          Toast.show(err);
          emit(CreateReportError());
        },
        (res) async {
       Navigator.pop(context);
          emit(CreateReportLoaded());
        },
      );
    }
  }

  unFocus(context) {
    if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
  }

}
