part of 'shop_profile_cubit.dart';

@immutable
abstract class ShopProfileState {}

class ShopProfileInitial extends ShopProfileState {}

class GetShopProfileLoading extends ShopProfileState {}

class GetShopProfileLoaded extends ShopProfileState {}

class GetShopProfileError extends ShopProfileState {}

class UpdateShopProfileLoading extends ShopProfileState {}

class UpdateShopProfileLoaded extends ShopProfileState {}

class UpdateShopProfileError extends ShopProfileState {}

class GetImageState extends ShopProfileState {}

class UploadImageLoading extends ShopProfileState {}

class UploadImageLoaded extends ShopProfileState {}