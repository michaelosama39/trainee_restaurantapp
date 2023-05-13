import 'package:dartz/dartz.dart';
import 'package:trainee_restaurantapp/core/models/user_model.dart';
import 'package:trainee_restaurantapp/core/net/api_url.dart';
import '../../../../../core/dioHelper/dio_helper.dart';
import '../models/add_course_model.dart';

class AddCourseRepo {
  Future<Either<String, bool>> addCourse(AddCourseModel addCourseModel) async {
    final response = await DioHelper.post(
      APIUrls.API_COURSE_CREATE,
      body: await addCourseModel.toJson(),
    );
    print(">>>>>>>><<<<<<<${response.data}");
    try {
      if (response.data['success'] == true) {
        print("Success addCourse");
        return const Right(true);
      } else {
        return Left(response.data['error']['details']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
