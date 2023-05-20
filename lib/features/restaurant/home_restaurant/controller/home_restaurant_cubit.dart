import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/ui/toast.dart';
import '../data/models/dish_model.dart';
import '../data/models/recent_dishes_model.dart';
import '../data/repositories/home_restaurant_repo.dart';

part 'home_restaurant_state.dart';

class HomeRestaurantCubit extends Cubit<HomeRestaurantState> {
  HomeRestaurantCubit() : super(HomeRestaurantInitial());

  static HomeRestaurantCubit of(context) => BlocProvider.of(context);

  final HomeRestaurantRepo homeRestaurantRepo = HomeRestaurantRepo();

  List<Items> listOfDishs = [];
  List<RecentDishes> listOfRecentDishes = [];

  Future getAllDishMostOrderedHome() async {
    emit(GetAllDishMostOrderedHomeLoading());
    final res = await homeRestaurantRepo.getAllDishMostOrderedHome();
    print(res);
    res.fold(
      (err) {
        Toast.show(err);
      },
      (res) {
        listOfDishs.addAll(res.result!.items ?? []);
        emit(GetAllDishMostOrderedHomeLoaded());
      },
    );
  }

  Future getRecentOrderedDishes() async {
    emit(GetRecentOrderedDishesLoading());
    final res = await homeRestaurantRepo.getRecentOrderedDishes();
    res.fold(
          (err) {
        Toast.show(err);
      },
          (res) {
            listOfRecentDishes.addAll(res.result??[]);
        emit(GetRecentOrderedDishesLoaded());
      },
    );
  }
}
