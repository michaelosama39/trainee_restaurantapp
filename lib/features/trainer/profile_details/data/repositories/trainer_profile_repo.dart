import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:trainee_restaurantapp/core/net/api_url.dart';
import 'package:trainee_restaurantapp/features/trainer/profile_details/data/models/update_trainer_profile_model.dart';
import '../../../../../core/dioHelper/dio_helper.dart';
import '../../../../../core/models/review_model.dart';
import '../../../../../core/models/trainer_model.dart';

class TrainerProfileRepo {
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

  Future<Either<String, TrainerModel>> getTrainerProfile() async {
    print(AppStorage.getUserInfo!.result!.userId);
    print(">>>>>>>>>>>>>>?");
    final response = await DioHelper.get(
      APIUrls.API_GET_TRAINER_PROFILE,
      query: {
        "id" : AppStorage.getUserInfo!.result!.userId
      }
    );
    try {
      if (response.data['success'] == true) {
        return Right(TrainerModel.fromJson(response.data["result"]));
      } else {
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  Future<Either<String, List<ReviewModel>>> getTrainerReviews() async {
    final response = await DioHelper.get(
      APIUrls.API_GET_TRAINER_REVIEWS,
      query: {
        "RefType" : "1",
        "RefId" : AppStorage.getUserInfo!.result!.userId
      }
    );
    try {
      if (response.data['success'] == true) {
        List<ReviewModel> reviews = [];
        for(int i = 0; i < response.data['result']["items"].length; i++ ){
          reviews.add(ReviewModel.fromJson(response.data['result']["items"][i]));
        }
        return Right(reviews);
      } else {
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> updateTrainerProfile(
      UpdateTrainerProfileModel updateTrainerProfileModel) async {
    final response = await DioHelper.put(
      APIUrls.API_UPDATE_TRAINER_PROFILE,
      body: await updateTrainerProfileModel.toJson(),
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
