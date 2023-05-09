import 'package:dartz/dartz.dart';
import 'package:trainee_restaurantapp/core/models/user_model.dart';
import 'package:trainee_restaurantapp/core/net/api_url.dart';
import '../../../../core/dioHelper/dio_helper.dart';

class AuthRepo {
  Future<Either<String, UserModel>> login(
      String phone, String password, int type) async {
    print(phone);
    print(password);
    print(type);
    final response = await DioHelper.post(
      APIUrls.API_LOGIN,
      body: {
        "userNameOrEmailAddress": phone,
        "password": password,
        "rememberClient": true,
        "type": type,
      },
    );
    try {
      if (response.data['success'] == true) {
        print("Success login");
        return Right(UserModel.fromJson(response.data));
      } else {
        return Left(response.data['error']['details']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
