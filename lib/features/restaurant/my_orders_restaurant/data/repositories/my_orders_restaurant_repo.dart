import 'package:dartz/dartz.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';

import '../../../../../core/dioHelper/dio_helper.dart';
import '../../../../../core/net/api_url.dart';
import '../../../../../core/models/order_model.dart';

class MyOrdersRestaurantRepo{
  Future<Either<String, List<OrderModel>>> getMyOrders(int statusId) async {
    final response =
    await DioHelper.get(APIUrls.API_GetAll_Order, query: {
      "Status": statusId,
      "RestaurantId": AppStorage.getUserInfo!.result!.restaurantId!,
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

  Future<Either<String, bool>> changeStatus(int orderId , int targetStatus) async {
    final response =
    await DioHelper.post(APIUrls.API_ChangeStatus_Order, body: {
      "orderId": orderId,
      "targetStatus": targetStatus,
    });
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