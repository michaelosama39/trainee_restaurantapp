import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../core/ui/toast.dart';
import '../../../navigator_home/view/navigator_home_view.dart';
import '../data/models/categories_model.dart';
import '../data/repositories/add_plate_repo.dart';

part 'add_plate_state.dart';

class AddPlateCubit extends Cubit<AddPlateState> {
  AddPlateCubit() : super(AddPlateInitial());

  static AddPlateCubit of(context) => BlocProvider.of(context);

  final AddPlateRepo addPlateRepo = AddPlateRepo();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode nameArPlate = FocusNode();
  FocusNode nameEnPlate = FocusNode();
  FocusNode comPlate = FocusNode();
  FocusNode pricePlate = FocusNode();
  FocusNode comArPlate = FocusNode();
  FocusNode comEnPlate = FocusNode();

  TextEditingController nameArPlateController = TextEditingController();
  TextEditingController nameEnPlateController = TextEditingController();
  TextEditingController pricePlateController = TextEditingController();
  TextEditingController componentsEnPlateController = TextEditingController();
  TextEditingController componentsArPlateController = TextEditingController();

  List<Items> listOfCates = [];

  Items? dropdownValueCate;
  File? file;

  Future getCategories() async {
    emit(GetCategoryLoading());
    final res = await addPlateRepo.getCategories();
    res.fold(
      (err) {
        Toast.show(err);
      },
      (res) {
        listOfCates.addAll(res.result!.items ?? []);
        emit(GetCategoryLoaded());
      },
    );
  }

  Future createDish(BuildContext context) async {
    if (formKey.currentState!.validate() || file != null) {
      emit(AddPlateLoading());
      final res = await addPlateRepo.createDish(
        arName: nameArPlateController.text,
        enName: nameEnPlateController.text,
        price: double.parse(pricePlateController.text),
        categoryId: dropdownValueCate == null ? 0 : dropdownValueCate!.id ?? 0,
        enComponents: componentsEnPlateController.text,
        arComponents: componentsArPlateController.text,
        image: file!,
      );
      res.fold(
        (err) {
          Toast.show(err);
          emit(AddPlateError());
        },
        (res) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => NavigatorScreen(homeType: 3)),
              (route) => false);
          emit(AddPlateLoaded());
        },
      );
    }else{
      Toast.show('استكمل البيانات');
    }
  }

  Future<File?> getImage() async {
    ImagePicker picker = ImagePicker();
    var result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      return File(result.path);
    }
  }
}
