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
  static const API_GET_TRAINER_REVIEWS = "/services/app/Review/GetAll";
  static const API_GET_COURSE = "/services/app/Course/Get";
  static const API_GET_TRAINEE = "/services/app/Trainee/GetTraineeProgressInCourse";

  //rest
  static const API_GET_REST_PROFILE = "/services/app/Restaurant/Get";
  static const API_UPDATE_REST_PROFILE = "/services/app/Restaurant/Update";


  static const API_Create_Dish = "/services/app/Dish/Create";
  static const API_GetAll_Category = "/services/app/Category/GetAll";
  static const API_GetAll_Dish_MostOrdered = "/services/app/Dish/GetAll?Sorting=MostOrdered&MaxResultCount=10";
  static const API_GetAll_Dish = "/services/app/Dish/GetAll";
  static const API_Get_Dish_Details = "/services/app/Dish/Get";
  static const API_GetAll_New_Ordered = "/services/app/Dish/GetNewOrderedDishes?MaxResultCount=10";
  static const API_GetAll_Order = "/services/app/Order/GetAll";
  static const API_GetNewOrderedDishes_Dish = "/services/app/Dish/GetNewOrderedDishes";
}
