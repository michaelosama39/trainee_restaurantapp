part of 'subscription_cubit.dart';

@immutable
abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}
class GetSubscriptionsLoading extends SubscriptionState {}
class GetSubscriptionsLoaded extends SubscriptionState {}
class GetSubscriptionsError extends SubscriptionState {}


