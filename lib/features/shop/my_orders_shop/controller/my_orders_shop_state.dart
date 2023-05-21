part of 'my_orders_shop_cubit.dart';

@immutable
abstract class MyOrdersShopState {}

class MyOrdersShopInitial extends MyOrdersShopState {}

class GetMyOrdersLoaded extends MyOrdersShopState {}

class GetMyOrdersLoading extends MyOrdersShopState {}


class GetMyOrdersError extends MyOrdersShopState {}

class ChangeStatusLoaded extends MyOrdersShopState {}

class ChangeStatusLoading extends MyOrdersShopState {}
