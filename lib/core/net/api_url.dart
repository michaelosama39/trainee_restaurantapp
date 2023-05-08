/// API
class APIUrls {
  /// Domain url
  static const BASE_URL = "http://192.163.208.89:8888/api/";
  static const BASE_JSON_PLACEHOLDER = "https://jsonplaceholder.typicode.com/";

  /// Urls
  static const API_REGISTER = "/services/app/Account/Register";
  static const API_LOGIN = "/TokenAuth/Authenticate";
  static const API_FORGOT_PASSWORD = "/services/app/Account/ForgotPassword";
  static const API_CREATE_NEW_PASSWORD =
      "/services/app/Account/ConfirmForgotPassword";
  static const API_CHANGE_PASSWORD = "/services/app/User/ChangePassword";
  static const API_VERIFY_ACCOUNT = "/services/app/Account/VerifyAccount";
  static const API_SEND_VC = "/services/app/Account/ResendCode";
  static const API_GET_ALL_CATEGORIES = "services/app/Category/GetAll";
  static const API_GET_ALL_RESTAURANTS = "services/app/Restaurant/GetAll";
  static const API_GET_ALL_COACHES = "services/app/Trainer/GetAll";
  static const API_GET_ALL_SHOPS = "services/app/Shop/GetAll";
  static const API_GET_INDEX = "services/app/Index/GetAllLite";
  static const API_GET_STORIES = "services/app/Story/GetAll";
  static const API_GET_STORY = "services/app/Story/Get";
}
