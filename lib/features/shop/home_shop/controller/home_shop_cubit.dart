import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/ui/toast.dart';
import '../../../restaurant/home_restaurant/data/models/recent_dishes_model.dart';
import '../data/models/product_model.dart';
import '../data/repositories/home_shop_repo.dart';

part 'home_shop_state.dart';

class HomeShopCubit extends Cubit<HomeShopState> {
  HomeShopCubit() : super(HomeShopInitial());

  static HomeShopCubit of(context) => BlocProvider.of(context);

  final HomeShopRepo homeShopRepo = HomeShopRepo();

  List<Items> listOfProduct = [];

  Future getAllProductMostOrderedHome() async {
    emit(GetAllProductMostOrderedHomeLoading());
    final res = await homeShopRepo.getAllProductMostOrderedHome();
    res.fold(
          (err) {
        Toast.show(err);
      },
          (res) {
            listOfProduct.addAll(res.result!.items ?? []);
        emit(GetAllProductMostOrderedHomeLoaded());
      },
    );
  }
}
