part of 'my_products_cubit.dart';

@immutable
abstract class MyProductsState {}

class MyProductsInitial extends MyProductsState {}

class GetAllProductLoaded extends MyProductsState {}
class GetAllProductLoading extends MyProductsState {}

class GetProductDetailsLoaded extends MyProductsState {}
class GetProductDetailsLoading extends MyProductsState {}

class GetProductReviewsLoaded extends MyProductsState {}
class GetProductReviewsLoading extends MyProductsState {}

class GetProductOrdersLoaded extends MyProductsState {}
class GetProductOrdersLoading extends MyProductsState {}
