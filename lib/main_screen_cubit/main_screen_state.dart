part of 'main_screen_cubit.dart';

// @CopyWith(skipFields: true)
// class MainScreenState extends Equatable {
//   final List<LocationModel> locations;
//   final MainScreenGetLocations getLocations;
//   final MainScreenUpdateLocations updateLocations;
//   final MainScreenWithLocations withLocations;
//   final MainScreenNoLocations noLocations;
//   final String error;
//
//   const MainScreenState({
//     this.locations = const [],
//     this.error = '',
//     this.getLocations = MainScreenGetLocations.init,
//     this.updateLocations = MainScreenUpdateLocations.init,
//     this.withLocations = MainScreenWithLocations.init,
//     this.noLocations = MainScreenNoLocations.init
//   });
//
//   MainScreenState copyWith({
//     List<LocationModel>? locations,
//     MainScreenGetLocations? getLocations,
//     MainScreenUpdateLocations? updateLocations,
//     MainScreenWithLocations? withLocations,
//     MainScreenNoLocations? noLocations,
//     String? error = ''
//   }) {
//     return MainScreenState(
//       locations: locations ?? this.locations,
//       error: error ?? this.error,
//       getLocations: getLocations ?? this.getLocations,
//       updateLocations: updateLocations ?? this.updateLocations,
//       withLocations: withLocations ?? this.withLocations,
//       noLocations: noLocations ?? this.noLocations
//     );
//   }
//
//   @override
//   List<Object?> get props => [getLocations, updateLocations, error];
// }
//
// enum MainScreenGetLocations {init, loading, loaded, error}
// enum MainScreenUpdateLocations {init, loading, loaded, error}
// enum MainScreenWithLocations {init, loading, loaded, error}
// enum MainScreenNoLocations {init, loading, loaded, error}
//
