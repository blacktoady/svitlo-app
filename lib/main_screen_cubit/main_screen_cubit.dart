import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/location_model.dart';
import '../repository/location_repository.dart';

part 'main_screen_state.dart';

@CopyWith(skipFields: true)
class MainScreenState extends Equatable {
  final List<LocationModel> locations;
  final MainScreenGetLocations getLocations;
  final MainScreenUpdateLocations updateLocations;
  final MainScreenWithLocations withLocations;
  final MainScreenNoLocations noLocations;
  final String error;

  const MainScreenState({
    this.locations = const [],
    this.error = '',
    this.getLocations = MainScreenGetLocations.init,
    this.updateLocations = MainScreenUpdateLocations.init,
    this.withLocations = MainScreenWithLocations.init,
    this.noLocations = MainScreenNoLocations.init
  });

  MainScreenState copyWith({
    List<LocationModel>? locations,
    MainScreenGetLocations? getLocations,
    MainScreenUpdateLocations? updateLocations,
    MainScreenWithLocations? withLocations,
    MainScreenNoLocations? noLocations,
    String? error = ''
  }) {
    return MainScreenState(
        locations: locations ?? this.locations,
        error: error ?? this.error,
        getLocations: getLocations ?? this.getLocations,
        updateLocations: updateLocations ?? this.updateLocations,
        withLocations: withLocations ?? this.withLocations,
        noLocations: noLocations ?? this.noLocations
    );
  }

  @override
  List<Object?> get props => [getLocations, updateLocations, error, noLocations, withLocations];
}

enum MainScreenGetLocations {init, loading, loaded, error}
enum MainScreenUpdateLocations {init, loading, loaded, error}
enum MainScreenWithLocations {init, loading, loaded, error}
enum MainScreenNoLocations {init, loading, loaded, error}


class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit(this.repository) : super(const MainScreenState()) {
    getAllLocations();
  }

  final LocationRepository repository;

  void getAllLocations() async {

    try {
      // emit(state.copyWith(getLocations: MainScreenGetLocations.loading));

      // emit(state.copyWith(withLocations: MainScreenWithLocations.loading));
      var locations = await repository.getLocations();

      if (locations.first.locationName == null) {
        emit(state.copyWith(noLocations: MainScreenNoLocations.loaded, locations: locations));

      } else {
        emit(state.copyWith(withLocations: MainScreenWithLocations.loaded, locations: locations));
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }

    // try {
    // } catch (e) {
    //   emit(state.copyWith(error: e.toString()));
    // }
  }
}
