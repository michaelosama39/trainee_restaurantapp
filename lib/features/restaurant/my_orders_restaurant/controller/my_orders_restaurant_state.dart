part of 'my_orders_restaurant_cubit.dart';

@immutable
abstract class MyOrdersRestaurantState {}

class MyOrdersRestaurantInitial extends MyOrdersRestaurantState {}

class GetMyOrdersLoaded extends MyOrdersRestaurantState {}

class GetMyOrdersLoading extends MyOrdersRestaurantState {}


class GetMyOrdersError extends MyOrdersRestaurantState {}

class ChangeStatusLoaded extends MyOrdersRestaurantState {}

class ChangeStatusLoading extends MyOrdersRestaurantState {}
