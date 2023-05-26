import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:trainee_restaurantapp/core/net/api_url.dart';
import '../../../../../core/dioHelper/dio_helper.dart';
import '../models/add_course_model.dart';

class AddCourseRepo {
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

  Future<Either<String, bool>> addCourse(AddCourseModel addCourseModel) async {
    final response = await DioHelper.post(
      APIUrls.API_COURSE_CREATE,
      body: await addCourseModel.toJson(),
    );
    print(">>>>>>>><<<<<<<${response.data}");
    try {
      if (response.data['success'] == true) {
        print("Success addCourse");
        return const Right(true);
      } else {
        return Left(response.data['error']['details']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
