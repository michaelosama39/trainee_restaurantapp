import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:trainee_restaurantapp/features/restaurant/my_orders_restaurant/data/repositories/my_orders_restaurant_repo.dart';

import '../../../../core/ui/toast.dart';
import '../../../../core/models/order_model.dart';

part 'my_orders_restaurant_state.dart';

class MyOrdersRestaurantCubit extends Cubit<MyOrdersRestaurantState> {
  MyOrdersRestaurantCubit() : super(MyOrdersRestaurantInitial());

  static MyOrdersRestaurantCubit of(context) => BlocProvider.of(context);

  final MyOrdersRestaurantRepo myOrdersRestaurantRepo =
      MyOrdersRestaurantRepo();

  List<OrderModel> listOfOrders = [];

  Future getMyOrders(int statusId) async {
    listOfOrders.clear();
    emit(GetMyOrdersLoading());
    final res = await myOrdersRestaurantRepo.getMyOrders(statusId);
    res.fold(
      (err) {
        Toast.show(err);
      },
      (res) {
        listOfOrders.addAll(res);
        emit(GetMyOrdersLoaded());
      },
    );
  }

  Future changeStatus(BuildContext context ,int orderId, int targetStatus) async {
    emit(ChangeStatusLoading());
    final res =
        await myOrdersRestaurantRepo.changeStatus(orderId, targetStatus);
    res.fold(
      (err) {
        Toast.show(err);
      },
      (res) {
        Toast.show('تم');
        Navigator.of(context).pop();
        emit(ChangeStatusLoaded());
      },
    );
  }
}
