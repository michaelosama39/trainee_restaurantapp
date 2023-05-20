part of 'my_plates_cubit.dart';

@immutable
abstract class MyPlatesState {}

class MyPlatesInitial extends MyPlatesState {}
class GetAllDishLoaded extends MyPlatesState {}
class GetAllDishLoading extends MyPlatesState {}

class GetDishDetailsLoaded extends MyPlatesState {}
class GetDishDetailsLoading extends MyPlatesState {}

class GetDishReviewsLoaded extends MyPlatesState {}
class GetDishReviewsLoading extends MyPlatesState {}

class GetDishOrdersLoaded extends MyPlatesState {}
class GetDishOrdersLoading extends MyPlatesState {}
