import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:trainee_restaurantapp/features/shop/add_product/data/repositories/add_product_repo.dart';

import '../../../../core/ui/toast.dart';
import '../../../../core/models/categories_model.dart';
import '../view/success_product_add.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());

  static AddProductCubit of(context) => BlocProvider.of(context);

  final AddProductRepo addProductRepo = AddProductRepo();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode nameArProduct = FocusNode();
  FocusNode nameEnProduct = FocusNode();
  FocusNode comPlate = FocusNode();
  FocusNode pricePlate = FocusNode();
  FocusNode comArPlate = FocusNode();
  FocusNode comEnPlate = FocusNode();

  TextEditingController nameArProductController = TextEditingController();
  TextEditingController nameEnProductController = TextEditingController();
  TextEditingController priceProductController = TextEditingController();
  TextEditingController componentsEnProductController = TextEditingController();
  TextEditingController componentsArProductController = TextEditingController();

  List<Items> listOfCates = [];

  Items? dropdownValueCate;
  File? file;
  String? img;

  Future uploadImage(BuildContext context, File file) async {
    emit(UploadImageLoading());
    final res = await addProductRepo.uploadImage(file);
    print(res);
    print("?????????");
    res.fold(
          (err) {
        Toast.show(err);
        emit(AddProductInitial());
      },
          (res) async {
        img = res;
        emit(UploadImageLoaded());
      },
    );
  }

  Future getCategories() async {
    emit(GetCategoryLoading());
    final res = await addProductRepo.getCategories();
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

  Future createProducr(BuildContext context) async {
    if (formKey.currentState!.validate() && file != null) {
      emit(AddProductLoading());
      final res = await addProductRepo.createProducr(
        arName: nameArProductController.text,
        enName: nameEnProductController.text,
        price: int.parse(priceProductController.text),
        categoryId: dropdownValueCate == null ? 0 : dropdownValueCate!.id ?? 0,
        enComponents: componentsEnProductController.text,
        arComponents: componentsArProductController.text,
        image: img!,
      );
      res.fold(
            (err) {
          Toast.show(err);
          emit(AddProductError());
        },
            (res) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const SuccessProductAdd()));
          emit(AddProductLoaded());
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
