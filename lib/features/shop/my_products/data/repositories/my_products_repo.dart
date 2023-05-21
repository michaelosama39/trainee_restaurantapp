import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:trainee_restaurantapp/features/shop/home_shop/data/models/product_model.dart';

import '../../../../../core/dioHelper/dio_helper.dart';
import '../../../../../core/models/order_model.dart';
import '../../../../../core/models/review_model.dart';
import '../../../../../core/net/api_url.dart';

class MyProductsRepo {
  Future<Either<String, ProductModel>> getAllProduct() async {
    final response = await DioHelper.get(
      APIUrls.API_GetAll_Product,
    );
    try {
      if (response.data['success'] == true) {
        return Right(ProductModel.fromJson(response.data));
      } else {
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  Future<Either<String, Items>> getProductDetails(int dishId) async {
    final response = await DioHelper.get(APIUrls.API_Get_Product_Details, query: {
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

  Future<Either<String, List<ReviewModel>>> getProductReviews(int productId) async {
    final response =
        await DioHelper.get(APIUrls.API_GET_TRAINER_REVIEWS, query: {
      "RefType": 3,
      "RefId": productId,
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

  Future<Either<String, List<OrderModel>>> getProductOrders(int productId) async {
    final response =
    await DioHelper.get(APIUrls.API_GetAll_Order, query: {
      "Status": 6,
      "ProductId": productId,
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
