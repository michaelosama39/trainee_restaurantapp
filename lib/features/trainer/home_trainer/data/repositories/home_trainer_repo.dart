import 'package:dartz/dartz.dart';
import 'package:trainee_restaurantapp/core/models/course_model.dart';
import 'package:trainee_restaurantapp/core/models/trainee_in_progress_model.dart';
import 'package:trainee_restaurantapp/core/models/user_model.dart';
import 'package:trainee_restaurantapp/core/net/api_url.dart';
import '../../../../../core/dioHelper/dio_helper.dart';
import '../../../../../core/models/new_trainee_model.dart';

class HomeTrainerRepo {
  Future<Either<String, List<CourseModel>>> getMostWantedCourses() async {

    final response = await DioHelper.get(
      APIUrls.API_GET_COURSES,
      query:{
        "Sorting" : "bookingRequestsCount"
      }

    );
    try {
      if (response.data['success'] == true) {

        List<CourseModel> mostWantedCourses = [];
       for(int i = 0; i < response.data['result']["items"].length; i++ ){
         mostWantedCourses.add(CourseModel.fromJson(response.data['result']["items"][i]));
       }
        return Right(mostWantedCourses);
      } else {
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String,List<NewTraineeModel>>> getNewTrainees() async {

    final response = await DioHelper.get(
      APIUrls.API_GET_NEW_TRAINEES,

    );
    try {
      if (response.data['success'] == true) {

        List<NewTraineeModel> newTrainees = [];
        for(int i = 0; i < response.data['result'].length; i++ ){
          newTrainees.add(NewTraineeModel.fromJson(response.data['result'][i]));
        }
        return Right(newTrainees);
      } else {
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String,TraineeInProgressModel>> getTrainee(int traineeId) async {

    final response = await DioHelper.get(
      APIUrls.API_GET_TRAINEE,);
    try {
      if (response.data['success'] == true) {

        return Right(TraineeInProgressModel.fromJson(response.data["result"]));
      } else {
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
