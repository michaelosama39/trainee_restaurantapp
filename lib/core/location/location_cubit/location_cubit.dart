import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/location_model.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());


  onLocationUpdated(LocationModel model){
    emit(LocationUpdated(model, state.changed));
  }

}
