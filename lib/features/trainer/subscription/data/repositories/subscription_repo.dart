import 'package:dartz/dartz.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:trainee_restaurantapp/core/models/user_model.dart';
import 'package:trainee_restaurantapp/core/net/api_url.dart';
import 'package:trainee_restaurantapp/features/trainer/subscription/data/models/subscription_model.dart';
import '../../../../../core/dioHelper/dio_helper.dart';
import '../../../../../core/models/review_model.dart';
import '../../../../../core/models/trainer_model.dart';

class SubscriptionRepo {

  Future<Either<String, List<SubscriptionModel>>> getSubscriptions() async {

    final response = await DioHelper.get(
      APIUrls.API_GET_SUBSCRIPTIONS,

    );
    try {
      if (response.data['success'] == true) {
        List<SubscriptionModel> subscriptions = [];
        for(int i = 0; i < response.data['result']["items"].length; i++ ){
          subscriptions.add(SubscriptionModel.fromJson(response.data['result']["items"][i]));
        }
        return Right(subscriptions);
      } else {
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

}
