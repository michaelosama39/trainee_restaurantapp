import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainee_restaurantapp/features/trainer/subscription/data/models/subscription_model.dart';
import '../../../../../core/ui/toast.dart';
import '../../data/repositories/subscription_repo.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(SubscriptionInitial());

  static SubscriptionCubit of(context) => BlocProvider.of(context);

  final _subscriptionRepo = SubscriptionRepo();

  List<SubscriptionModel> subscriptions = [];

  Future getSubscriptions(BuildContext context) async {
    emit(GetSubscriptionsLoading());
    final res = await _subscriptionRepo.getSubscriptions();
    res.fold(
      (err) {
        print(err);
        Toast.show(err);
        emit(GetSubscriptionsError());
      },
      (res) {
        subscriptions = res;
        emit(GetSubscriptionsLoaded());
      },
    );
  }
}
