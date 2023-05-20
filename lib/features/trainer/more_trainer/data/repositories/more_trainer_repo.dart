import 'package:dartz/dartz.dart';
import 'package:trainee_restaurantapp/core/models/user_model.dart';
import 'package:trainee_restaurantapp/core/net/api_url.dart';
import '../../../../../core/dioHelper/dio_helper.dart';

class MoreTrainerRepo {
  Future<Either<String, bool>> addFeedback(String subject,String desc) async {
    final response = await DioHelper.post(
      APIUrls.API_CREATE_REPORT,
      body: {
        "description": desc,
        "subject": subject
      },
    );
    print(">>>>>>>><<<<<<<${response.data}");
    try {
      if (response.data['success'] == true) {
        return const Right(true);
      } else {
        return Left(response.data['error']['details']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
