import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:trainee_restaurantapp/features/shop/my_products/data/repositories/my_products_repo.dart';

import '../../../../core/models/order_model.dart';
import '../../../../core/models/review_model.dart';
import '../../../../core/ui/toast.dart';
import '../../home_shop/data/models/product_model.dart';

part 'my_products_state.dart';

class MyProductsCubit extends Cubit<MyProductsState> {
  MyProductsCubit() : super(MyProductsInitial());

  static MyProductsCubit of(context) => BlocProvider.of(context);

  final MyProductsRepo myProductRepo = MyProductsRepo();

  List<Items> listOfDishs = [];
  List<ReviewModel> listOfReviews = [];
  List<OrderModel> listOfOrders = [];

  Items? item;

  Future getAllProduct() async {
    emit(GetAllProductLoading());
    final res = await myProductRepo.getAllProduct();
    res.fold(
          (err) {
        Toast.show(err);
      },
          (res) {
        listOfDishs.addAll(res.result!.items ?? []);
        emit(GetAllProductLoaded());
      },
    );
  }

  Future getProductDetails(int productId) async {
    emit(GetProductDetailsLoading());
    final res = await myProductRepo.getProductDetails(productId);
    res.fold(
          (err) {
        Toast.show(err);
      },
          (res) {
        item = res;
        emit(GetProductDetailsLoaded());
      },
    );
  }

  Future getProductReviews(int productId) async {
    emit(GetProductReviewsLoading());
    final res = await myProductRepo.getProductReviews(productId);
    res.fold(
          (err) {
        Toast.show(err);
      },
          (res) {
        listOfReviews.addAll(res);
        emit(GetProductReviewsLoaded());
      },
    );
  }

  Future getProductOrders(int productId) async {
    emit(GetProductOrdersLoading());
    final res = await myProductRepo.getProductOrders(productId);
    res.fold(
          (err) {
        Toast.show(err);
      },
          (res) {
        listOfOrders.addAll(res);
        emit(GetProductOrdersLoaded());
      },
    );
  }
}
