part of 'data_cubit.dart';

abstract class DataState extends Equatable {}

class InitialState extends DataState {
  @override
  List<Object> get props => [];
}

class LoadingState extends DataState {
  @override
  List<Object> get props => [];
}

class LocationState extends DataState {
  LocationState(this.locationModel);

  final List<LocationModel> locationModel;

  @override
  List<Object> get props => [locationModel];
}

class WithListState extends DataState {
  WithListState(this.locationModel);

  final List<LocationModel> locationModel;

  @override
  List<Object> get props => [locationModel];
}

class WithoutListState extends DataState {

  @override
  List<Object> get props => [];
}

class ErrorState extends DataState {
  @override
  List<Object> get props => [];
}

// class DataInitial extends DataState {
//
// }
