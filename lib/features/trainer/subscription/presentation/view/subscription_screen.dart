import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:trainee_restaurantapp/features/Acount/presentation/controller/auth_cubit.dart';
import 'package:trainee_restaurantapp/features/payment/view/payment_view.dart';
import 'package:trainee_restaurantapp/features/trainer/subscription/data/models/subscription_model.dart';
import 'package:trainee_restaurantapp/features/trainer/subscription/presentation/controller/subscription_cubit.dart';
import 'package:trainee_restaurantapp/generated/l10n.dart';

import '../../../../../core/ui/loader.dart';
import '../../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../navigator_home/view/navigator_home_view.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({Key? key, required this.typeUser})
      : super(key: key);

  final int typeUser;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
          appBar: const TransparentAppBar(
            title: "باقات الاشتراك",
          ),
          body: BlocProvider(
            create: (context) => SubscriptionCubit()..getSubscriptions(context),
            child: BlocBuilder<SubscriptionCubit, SubscriptionState>(
              builder: (context, state) {
                if (state is GetSubscriptionsLoading) {
                  return const Loader();
                } else {
                  return ListView.separated(
                      itemCount:
                          SubscriptionCubit.of(context).subscriptions.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SubscriptionItem(
                              typeUser: typeUser,
                              subscriptionModel: SubscriptionCubit.of(context)
                                  .subscriptions[index]),
                        );
                      });
                }
              },
            ),
          )),
    );
  }
}

class SubscriptionItem extends StatelessWidget {
  final SubscriptionModel subscriptionModel;

  const SubscriptionItem(
      {Key? key, required this.subscriptionModel, required this.typeUser})
      : super(key: key);

  final int typeUser;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff1235e2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subscriptionModel.name ?? "",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Row(
              children: [
                Text("${subscriptionModel.fee ?? 0}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: 10,
                ),
                Text(Translation.of(context).saudi_riyal,
                    style: const TextStyle(color: Colors.black, fontSize: 14)),
              ],
            ),
            const Text("كل سنة",
                style: TextStyle(color: Colors.black, fontSize: 14)),
            Align(
              alignment: Alignment.bottomLeft,
              child: InkWell(
                onTap: () {
                  if (subscriptionModel.fee == 0.0) {
                    AuthCubit.of(context).assignSubscriptionToUser(
                        context, subscriptionModel.id!, typeUser);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => NavigatorScreen(
                            homeType: typeUser,
                          ),
                        ),
                        (route) => false);
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PaymentView(
                            amount: subscriptionModel.fee ?? 0.0,
                            userId: AppStorage.getUserId,
                            typeUser: typeUser,
                            subscriptionId: subscriptionModel.id!),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  color: const Color(0xff1235e2),
                  child: const Text(
                    "اشتراك",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
