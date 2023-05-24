import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/ui/toast.dart';
import '../data/repositories/payment_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  static PaymentCubit of(context) => BlocProvider.of(context);

  final paymentRepo = PaymentRepo();

  Future createPayment(BuildContext context, int userId, num amount) async {
    emit(CreatePaymentLoading());
    final res = await paymentRepo.createPayment(userId, amount);
    res.fold(
      (err) {
        Toast.show(err);
        emit(CreatePaymentError());
      },
      (res) async {
        Toast.show('تم الاستراك بنجاح');
        emit(CreatePaymentLoaded());
      },
    );
  }
}
