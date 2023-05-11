import 'package:dartz/dartz.dart';
import 'package:trainee_restaurantapp/core/models/course_model.dart';
import 'package:trainee_restaurantapp/core/models/user_model.dart';
import 'package:trainee_restaurantapp/core/net/api_url.dart';
import '../../../../../core/dioHelper/dio_helper.dart';

class CoursesRepo {
  Future<Either<String, List<CourseModel>>> getCourses({bool? isActive,bool? isFinished}) async {

    final response = await DioHelper.get(
      APIUrls.API_GET_COURSES,
      query:{
        "IsActive" :isActive,
        "IsFinished" : isFinished
      }

    );


    try {
      if (response.data['success'] == true) {

        List<CourseModel> courses = [];
       for(int i = 0; i < response.data['result']["items"].length; i++ ){
         courses.add(CourseModel.fromJson(response.data['result']["items"][i]));
       }
        return Right(courses);
      } else {
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserModel>> getNewTrainees() async {

    final response = await DioHelper.get(
      APIUrls.API_GET_NEW_TRAINEES,

    );
    try {
      if (response.data['success'] == true) {
        return Right(UserModel.fromJson(response.data));
      } else {
        return Left(response.data['error']['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
