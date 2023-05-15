import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:trainee_restaurantapp/features/trainer/add_course/data/repositories/add_course_repo.dart';
import '../../../../../core/ui/toast.dart';
import '../../data/models/add_course_model.dart';
import 'package:file_picker/file_picker.dart';

import '../screen/success_course_add.dart';

part 'add_course_state.dart';

class AddCourseCubit extends Cubit<AddCourseState> {
  AddCourseCubit() : super(AddCourseInitial());

  static AddCourseCubit of(context) => BlocProvider.of(context);

  final addCourseRepo = AddCourseRepo();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode arNameFocusNode = FocusNode();
  FocusNode enNameFocusNode = FocusNode();
  FocusNode feeFocusNode = FocusNode();
  FocusNode discountPercentageFocusNode = FocusNode();
  FocusNode trainingHoursCountFocusNode = FocusNode();
  FocusNode arDescriptionFocusNode = FocusNode();
  FocusNode enDescriptionFocusNode = FocusNode();

  final arNameController = TextEditingController();
  final enNameController = TextEditingController();
  final feeController = TextEditingController();
  final discountPercentageController = TextEditingController();
  final trainingHoursCountController = TextEditingController();
  final arDescriptionController = TextEditingController();
  final enDescriptionController = TextEditingController();

  File? file;

  Future addCourse(BuildContext context) async {
    if (formKey.currentState!.validate() && file!.path != '') {
      AddCourseModel addCourseModel = AddCourseModel(
        arName: arNameController.text,
        enName: enNameController.text,
        imageUrl: file!,
        fee: num.parse(feeController.text),
        hasDiscount:
            discountPercentageController.text.isNotEmpty ? true : false,
        discountPercentage: num.parse(discountPercentageController.text),
        trainerId: AppStorage.getUserId,
        categoryId: 3,
        trainingHoursCount: int.parse(trainingHoursCountController.text),
        arDescription: arDescriptionController.text,
        enDescription: enDescriptionController.text,
      );
      unFocus(context);
      emit(AddCourseLoading());
      final res = await addCourseRepo.addCourse(addCourseModel);
      res.fold(
        (err) {
          Toast.show(err);
          emit(AddCourseError());
        },
        (res) async {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SuccessCourseAdd()));
          emit(AddCourseLoaded());
        },
      );
    }
  }

  unFocus(context) {
    if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
  }

  Future<File?> getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    }
    return null;
  }
}
