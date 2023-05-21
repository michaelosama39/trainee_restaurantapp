import 'package:dartz/dartz.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:trainee_restaurantapp/core/net/api_url.dart';
import '../../../../../core/dioHelper/dio_helper.dart';
import '../../../../../core/models/shop_model.dart';
import '../models/update_shop_profile_model.dart';

class ShopProfileRepo {
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
