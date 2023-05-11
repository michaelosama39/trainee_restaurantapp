import 'package:dartz/dartz.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:trainee_restaurantapp/core/models/user_model.dart';
import 'package:trainee_restaurantapp/core/net/api_url.dart';
import '../../../../../core/dioHelper/dio_helper.dart';
import '../../../../../core/models/trainer_model.dart';

class TrainerProfileRepo {
  Future<Either<String, TrainerModel>> getTrainerProfile() async {

    final response = await DioHelper.get(
      APIUrls.API_GET_TRAINER_PROFILE,
      query: {
        "id" : AppStorage.getUserId
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

}
