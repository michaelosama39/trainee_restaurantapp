part of 'home_shop_cubit.dart';

@immutable
abstract class HomeShopState {}

class HomeShopInitial extends HomeShopState {}

class GetAllProductMostOrderedHomeLoaded extends HomeShopState {}
class GetAllProductMostOrderedHomeLoading extends HomeShopState {}

class GetRecentOrderedDishesLoaded extends HomeShopState {}
class GetRecentOrderedDishesLoading extends HomeShopState {}
