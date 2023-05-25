import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainee_restaurantapp/features/trainer/my_orders/data/models/booking_request_model.dart';
import '../../../../../core/ui/toast.dart';
import '../../data/repositories/booking_request_repo.dart';

part 'booking_request_state.dart';

class BookingRequestCubit extends Cubit<BookingRequestState> {
  BookingRequestCubit() : super(BookingRequestInitial());

  static BookingRequestCubit of(context) => BlocProvider.of(context);

  final _bookingRequestRepo = BookingRequestRepo();

  List<BookingRequestModel> bookingRequests = [];

  Future getBookingRequests(BuildContext context, int status) async {
    emit(GetBookingRequestsLoading());
    final res = await _bookingRequestRepo.getBookingRequests(status);
    res.fold(
      (err) {
        print(err);
        Toast.show(err);
        emit(GetBookingRequestsError());
      },
      (res) {
        bookingRequests = res;
        emit(GetBookingRequestsLoaded());
      },
    );
  }

  Future approveBookingRequest(
      BuildContext context, int bookingRequestId) async {
    emit(ApproveBookingRequestLoading());
    final res =
        await _bookingRequestRepo.approveBookingRequest(bookingRequestId);
    res.fold(
      (err) {
        print(err);
        Toast.show(err);
        emit(ApproveBookingRequestError());
      },
      (res) {
        getBookingRequests(context, 0);
        emit(ApproveBookingRequestLoaded());
      },
    );
  }

  Future rejectBookingRequest(
      BuildContext context, int bookingRequestId) async {
    emit(RejectBookingRequestLoading());
    final res =
        await _bookingRequestRepo.rejectBookingRequest(bookingRequestId);
    res.fold(
      (err) {
        print(err);
        Toast.show(err);
        emit(RejectBookingRequestError());
      },
      (res) {
        getBookingRequests(context, 0);
        emit(RejectBookingRequestLoaded());
      },
    );
  }
}
