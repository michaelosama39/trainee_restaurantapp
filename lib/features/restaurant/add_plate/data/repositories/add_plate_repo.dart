import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:trainee_restaurantapp/core/models/categories_model.dart';

import '../../../../../core/dioHelper/dio_helper.dart';
import '../../../../../core/net/api_url.dart';

class AddPlateRepo {
  Future<Either<String, String>> uploadImage(File file) async {
    FormData formData = FormData.fromMap({"file": await MultipartFile.fromFile(file.path,
        filename: file.path
            .split('/')
            .last , contentType: MediaType("image", "jpeg"))});
    final response = await DioHelper.post(
      APIUrls.API_Upload_Image,
      formData: formData,
    );
    try {
      if (response.data['success'] == true) {
        print("Success uploadImage");
        return Right(response.data['result']['url']);
      } else {
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, CategoriesModel>> getCategories() async {
    final response = await DioHelper.get(
      APIUrls.API_GetAll_Category,
    );
    try {
      if (response.data['success'] == true) {
        return Right(CategoriesModel.fromJson(response.data));
      } else {
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> createDish(
      {required String arName,
      required String enName,
      required int price,
      required int categoryId,
      required String enComponents,
      required String arComponents,
      required String image}) async {
    final response = await DioHelper.post(
      APIUrls.API_Create_Dish,
      body: {
        'arName': arName,
        'enName': enName,
        'price': price,
        'restaurantId': AppStorage.getUserInfo!.result!.restaurantId,
        'categoryId': categoryId,
        'enComponents': enComponents,
        'arComponents': arComponents,
        'image': image,
      },
    );
    try {
      if (response.data['success'] == true) {
        return const Right(true);
      } else {
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }
}
