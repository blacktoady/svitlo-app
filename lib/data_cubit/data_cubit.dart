import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:svitlo/models/location_model.dart';
import 'package:svitlo/repository/location_repository.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit({required this.repository}) : super(InitialState()) {
    getAllLocations();
  }

  final LocationRepository repository;

  void getAllLocations() async {
    print("cubit");

    try {
      emit(LoadingState());

      print("after loading");

      // repository.test();
      // repository.addLocation("home", 3, "test");
      // repository.deleteAllLocations();
      var locations = await repository.getLocations();


      if (locations.first.locationName == null) {
        // locations = await repository.getLocations();
        print("emit without");
        emit(WithoutListState());
      } else {
        // final stateLoc = await repository.getLocations();
        print("emit with");
        emit(WithListState(locations));
      }
      print(locations.first.error);

      // emit(LocationState(locations));
    } catch (e) {
      emit(ErrorState());
    }
  }

}
