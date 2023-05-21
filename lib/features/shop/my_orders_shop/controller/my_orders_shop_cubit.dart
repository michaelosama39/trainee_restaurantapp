import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/ui/toast.dart';
import '../../../../core/models/order_model.dart';
import '../data/repositories/my_orders_shop_repo.dart';

part 'my_orders_shop_state.dart';

class MyOrdersShopCubit extends Cubit<MyOrdersShopState> {
  MyOrdersShopCubit() : super(MyOrdersShopInitial());

  static MyOrdersShopCubit of(context) => BlocProvider.of(context);

  final MyOrdersShopRepo myOrdersShopRepo = MyOrdersShopRepo();

  List<OrderModel> listOfOrders = [];

  Future getMyOrders(int statusId) async {
    listOfOrders.clear();
    emit(GetMyOrdersLoading());
    final res = await myOrdersShopRepo.getMyOrders(statusId);
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

  Future changeStatus(
      BuildContext context, int orderId, int targetStatus) async {
    emit(ChangeStatusLoading());
    final res = await myOrdersShopRepo.changeStatus(orderId, targetStatus);
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
