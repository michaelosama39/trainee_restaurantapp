import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:trainee_restaurantapp/core/net/api_url.dart';
import '../../../../../core/dioHelper/dio_helper.dart';
import '../../../../../core/models/shop_model.dart';
import '../models/update_shop_profile_model.dart';

class ShopProfileRepo {
  Future<Either<String, String>> uploadImage(File file) async {
    FormData formData = FormData.fromMap({"file": await MultipartFile.fromFile(file.path,
        filename: file.path
            .split('/')
            .last  , contentType: MediaType("image", "jpeg"))});
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

  Future<Either<String, bool>> updateShopProfile(
      UpdateShopProfileModel updateShopProfileModel) async {
    final response = await DioHelper.put(
      APIUrls.API_UPDATE_SHOP_PROFILE,
      body: await updateShopProfileModel.toJson(),
    );
    try {
      if (response.data['success'] == true) {
        return const Right(true);
      } else {
        print(response.data);
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  Future<Either<String, ShopModel>> getShopProfile() async {
    final response = await DioHelper.get(APIUrls.API_GET_SHOP_PROFILE,
        query: {"id": AppStorage.getUserInfo!.result!.shopId});
    try {
      if (response.data['success'] == true) {
        return Right(ShopModel.fromJson(response.data["result"]));
      } else {
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }
}
