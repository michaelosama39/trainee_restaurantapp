import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:trainee_restaurantapp/features/restaurant/my_plates/data/repositories/my_plates_repo.dart';

import '../../../../core/models/review_model.dart';
import '../../../../core/ui/toast.dart';
import '../../home_restaurant/data/models/dish_model.dart';
import '../models/order_model.dart';

part 'my_plates_state.dart';

class MyPlatesCubit extends Cubit<MyPlatesState> {
  MyPlatesCubit() : super(MyPlatesInitial());

  static MyPlatesCubit of(context) => BlocProvider.of(context);

  final MyPlatesRepo myPlatesRepo = MyPlatesRepo();

  List<Items> listOfDishs = [];
  List<ReviewModel> listOfReviews = [];
  List<OrderModel> listOfOrders = [];

  Items? item;

  Future getAllDishs() async {
    emit(GetAllDishLoading());
    final res = await myPlatesRepo.getAllDishs();
    res.fold(
      (err) {
        Toast.show(err);
      },
      (res) {
        listOfDishs.addAll(res.result!.items ?? []);
        emit(GetAllDishLoaded());
      },
    );
  }

  Future getDishDetails(int dishId) async {
    emit(GetDishDetailsLoading());
    final res = await myPlatesRepo.getDishDetails(dishId);
    res.fold(
      (err) {
        Toast.show(err);
      },
      (res) {
        item = res;
        emit(GetDishDetailsLoaded());
      },
    );
  }

  Future getDishReviews(int dishId) async {
    emit(GetDishReviewsLoading());
    final res = await myPlatesRepo.getDishReviews(dishId);
    print(res);
    print('????????????');
    res.fold(
      (err) {
        Toast.show(err);
      },
      (res) {
        listOfReviews.addAll(res);
        emit(GetDishReviewsLoaded());
      },
    );
  }

  Future getDishOrders(int dishId) async {
    emit(GetDishOrdersLoading());
    final res = await myPlatesRepo.getDishOrders(dishId);
    res.fold(
          (err) {
        Toast.show(err);
      },
          (res) {
        listOfOrders.addAll(res);
        emit(GetDishOrdersLoaded());
      },
    );
  }
}
