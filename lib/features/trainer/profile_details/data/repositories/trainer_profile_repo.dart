import 'package:dartz/dartz.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:trainee_restaurantapp/core/net/api_url.dart';
import '../../../../../core/dioHelper/dio_helper.dart';
import '../../../../../core/models/review_model.dart';
import '../../../../../core/models/trainer_model.dart';

class TrainerProfileRepo {
  Future<Either<String, TrainerModel>> getTrainerProfile() async {
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

}
