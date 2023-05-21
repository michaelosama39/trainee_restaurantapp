import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../../core/dioHelper/dio_helper.dart';
import '../../../../../core/models/review_model.dart';
import '../../../../../core/net/api_url.dart';
import '../../../home_restaurant/data/models/dish_model.dart';
import '../../../../../core/models/order_model.dart';

class MyPlatesRepo {
  Future<Either<String, DishModel>> getAllDishs() async {
    final response = await DioHelper.get(
      APIUrls.API_GetAll_Dish,
    );
    try {
      if (response.data['success'] == true) {
        return Right(DishModel.fromJson(response.data));
      } else {
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  Future<Either<String, Items>> getDishDetails(int dishId) async {
    final response = await DioHelper.get(APIUrls.API_Get_Dish_Details, query: {
      'Id': dishId,
    });
    try {
      if (response.data['success'] == true) {
        return Right(Items.fromJson(response.data['result']));
      } else {
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  Future<Either<String, List<ReviewModel>>> getDishReviews(int dishId) async {
    final response =
        await DioHelper.get(APIUrls.API_GET_TRAINER_REVIEWS, query: {
      "RefType": 3,
      "RefId": dishId,
    });
    try {
      if (response.data['success'] == true) {
        List<ReviewModel> reviews = [];
        for (int i = 0; i < response.data['result']["items"].length; i++) {
          reviews
              .add(ReviewModel.fromJson(response.data['result']["items"][i]));
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

  Future<Either<String, List<OrderModel>>> getDishOrders(int dishId) async {
    final response =
    await DioHelper.get(APIUrls.API_GetAll_Order, query: {
      "Status": 6,
      "DishId": dishId,
    });
    try {
      if (response.data['success'] == true) {
        List<OrderModel> reviews = [];
        for (int i = 0; i < response.data['result']["items"].length; i++) {
          reviews
              .add(OrderModel.fromJson(response.data['result']["items"][i]));
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
}
