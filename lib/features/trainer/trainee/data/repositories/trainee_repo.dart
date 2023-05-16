import 'package:dartz/dartz.dart';
import 'package:trainee_restaurantapp/core/models/course_model.dart';
import 'package:trainee_restaurantapp/core/models/trainee_in_progress_model.dart';
import 'package:trainee_restaurantapp/core/models/user_model.dart';
import 'package:trainee_restaurantapp/core/net/api_url.dart';
import 'package:trainee_restaurantapp/features/trainer/trainee/data/models/update_trainee_progress_model.dart';
import '../../../../../core/dioHelper/dio_helper.dart';
import '../../../../../core/models/new_trainee_model.dart';

class UpdateTraineeProgressRepo {
  Future<Either<String, bool>> updateTraineeProgress(UpdateTraineeProgressModel updateTraineeProgressModel) async {
    final response = await DioHelper.post(
      APIUrls.API_UPDATE_TRAINEE_PROGRESS,
      body:  updateTraineeProgressModel.toJson(),
    );
    print(">>>>>>>><<<<<<<${response.data}");
    try {
      if (response.data['success'] == true) {
        print("Success update");
        return const Right(true);
      } else {
        return Left(response.data['error']['details']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
