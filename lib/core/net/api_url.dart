/// API
class APIUrls {
  /// Domain url
  static const BASE_URL = "https://api.yacotch.online/api";
  static const BASE_JSON_PLACEHOLDER = "https://jsonplaceholder.typicode.com/";

  /// Urls
  static const API_LOGIN = "/TokenAuth/Authenticate";
  static const API_REGISTER_TRAINER = "/services/app/Account/RegisterTrainer";
  static const API_REGISTER_REST = "/services/app/Account/RegisterRestaurant";
  static const API_REGISTER_SHOP = "/services/app/Account/RegisterShop";
  static const API_FORGETPASSWORD = "/services/app/Account/ForgotPassword";
  static const API_VERIFY_ACCOUNT = "/services/app/Account/VerifyAccount";
  static const API_VERIFY_RESEND_CODE = "/services/app/Account/ResendCode";
  static const API_VERIFY_FORGETPASSWORD = "/services/app/Account/ConfirmForgotPassword";
  static const API_GET_COURSES = "/services/app/Course/GetAll";
  static const API_GET_NEW_TRAINEES = "/services/app/Trainee/GetNewTrainees";
  static const API_GET_TRAINER_PROFILE = "/services/app/Trainer/Get";
  static const API_COURSE_CREATE = "/services/app/Course/Create";

}
