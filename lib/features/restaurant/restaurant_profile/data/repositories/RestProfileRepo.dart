import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:trainee_restaurantapp/core/models/user_model.dart';
import 'package:trainee_restaurantapp/core/net/api_url.dart';
import 'package:trainee_restaurantapp/features/restaurant/restaurant_profile/data/models/restaurants_model.dart';
import 'package:trainee_restaurantapp/features/restaurant/restaurant_profile/data/models/update_rest_profile_model.dart';
import '../../../../../core/dioHelper/dio_helper.dart';
import '../../../../../core/models/trainer_model.dart';

class RestProfileRepo {
  Future<Either<String, String>> uploadImage(File file) async {
    FormData formData = FormData.fromMap({"file": await MultipartFile.fromFile(file.path,
        filename: file.path
            .split('/')
            .last)});
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

  Future<Either<String, bool>> updateRestProfile(
      UpdateRestProfileModel updateRestProfileModel) async {
    final response = await DioHelper.put(
      APIUrls.API_UPDATE_REST_PROFILE,
      body: await updateRestProfileModel.toJson(),
    );
    print(response.statusCode);
    print(response.data);
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

  Future<Either<String, RestaurantsModel>> getRestProfile() async {
    print(AppStorage.getUserInfo!.result!.userId);
    print('///////////////////');
    final response = await DioHelper.get(APIUrls.API_GET_REST_PROFILE,
        query: {"id": AppStorage.getUserInfo!.result!.restaurantId});
    try {
      if (response.data['success'] == true) {
        return Right(RestaurantsModel.fromJson(response.data["result"]));
      } else {
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }
}
