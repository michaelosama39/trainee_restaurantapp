part of 'home_restaurant_cubit.dart';

@immutable
abstract class HomeRestaurantState {}

class HomeRestaurantInitial extends HomeRestaurantState {}
class GetAllDishMostOrderedHomeLoaded extends HomeRestaurantState {}
class GetAllDishMostOrderedHomeLoading extends HomeRestaurantState {}

class GetRecentOrderedDishesLoaded extends HomeRestaurantState {}
class GetRecentOrderedDishesLoading extends HomeRestaurantState {}
