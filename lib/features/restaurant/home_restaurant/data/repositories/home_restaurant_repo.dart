import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:trainee_restaurantapp/features/restaurant/add_plate/data/models/categories_model.dart';

import '../../../../../core/dioHelper/dio_helper.dart';
import '../../../../../core/net/api_url.dart';
import '../models/dish_model.dart';
import '../models/recent_dishes_model.dart';

class HomeRestaurantRepo {
  Future<Either<String, DishModel>> getAllDishMostOrderedHome() async {
    final response = await DioHelper.get(
      APIUrls.API_GetAll_Dish_MostOrdered,
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

  Future<Either<String, RecentDishesModel>> getRecentOrderedDishes() async {
    final response = await DioHelper.get(
      APIUrls.API_GetNewOrderedDishes_Dish,
      query: {
        'MaxResultCount' : 10,
      }
    );
    try {
      if (response.data['success'] == true) {
        return Right(RecentDishesModel.fromJson(response.data));
      } else {
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }
}
