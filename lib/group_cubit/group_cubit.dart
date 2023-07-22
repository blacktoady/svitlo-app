import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:svitlo/models/icon_model.dart';
import 'package:svitlo/repository/location_repository.dart';

import '../models/location_model.dart';
import '../repository/group_repository.dart';

// part 'group_state.dart';

class GroupCubitState extends Equatable {
  final List<LocationModel> locations;
  final List<IconModel> icons;
  // final List<String> icons;
  final GroupAddLocation addLocation;
  final SelectIcon selectIcon;
  final String selectedIcon;
  final String error;

  const GroupCubitState({
    this.locations = const [],
    // this.icons = const ['home', 'gym', 'work', 'car'],
    this.icons = const [],
    this.addLocation = GroupAddLocation.init,
    this.selectIcon = SelectIcon.init,
    this.selectedIcon = 'home',
    this.error = ''
  });

  GroupCubitState copyWith({
    List<LocationModel>? locations,
    List<IconModel>? icons,
    GroupAddLocation? addLocation,
    SelectIcon? selectIcon,
    String? selectedIcon,
    String? error,
  }) {
    return GroupCubitState(
      locations: locations ?? this.locations,
      icons: icons ?? this.icons,
      addLocation: addLocation ?? this.addLocation,
      selectIcon: selectIcon ?? this.selectIcon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      error: error ?? this.error
    );
}

  @override
  List<Object?> get props => [locations, icons, addLocation, selectIcon, selectedIcon, error];


}

enum GroupAddLocation {init, adding, added, novalidate, error}
enum SelectIcon {init, select, selected, error}

class GroupCubit extends Cubit<GroupCubitState> {
  GroupCubit(this.locationRepository) : super(const GroupCubitState()) {
    createScreen();
  }

  final LocationRepository locationRepository;

  List<IconModel> iconsList = [
    IconModel(iconName: 'home', iconData: Icons.home, selected: true),
    IconModel(iconName: 'gym', iconData: Icons.fitness_center, selected: false),
    IconModel(iconName: 'work', iconData: Icons.work, selected: false),
    IconModel(iconName: 'car', iconData: Icons.directions_car, selected: false),
  ];

  void refreshIcon(int index) {
    emit(state.copyWith(selectIcon: SelectIcon.select));
    for (var element in iconsList) {
      element.selected = false;
    }

    iconsList[index].selected = true;

    emit(state.copyWith(icons: iconsList, selectIcon: SelectIcon.selected, selectedIcon: iconsList[index].iconName));

  }

  void createScreen() async {

    try {
      emit(state.copyWith(selectIcon: SelectIcon.select));

      // var icons = await groupRepository.refreshIcon('home', iconsList);
      var locations = await locationRepository.getLocations();

      emit(state.copyWith(icons: iconsList, locations: locations, selectIcon: SelectIcon.selected));

    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
    // emit(state.copyWith(locations: ));
  }

  void addLocation(String locationName, int groupId, String iconNames) async {
    final String locationKey = UniqueKey().hashCode.toString();

    try {
      emit(state.copyWith(addLocation: GroupAddLocation.adding));

      if (locationName.length < 3) {
        emit(state.copyWith(addLocation: GroupAddLocation.novalidate));
      } else {
        locationRepository.addLocation(locationKey ,locationName, groupId, state.selectedIcon);
      }

    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }


}
