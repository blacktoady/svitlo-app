import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:svitlo/models/single_location_model.dart';
import 'package:svitlo/repository/single_location_repository.dart';

// part 'single_location_state.dart';

@CopyWith(skipFields: true)
class SingleLocationState extends Equatable {
  final SingleLocationModel? model;
  final SingleLocationSchedule schedule;
  final Color iconColor;
  final String? timeToManipulation;
  final int? manipulationType;
  final String error;

  const SingleLocationState({
    this.model,
    this.schedule = SingleLocationSchedule.init,
    this.iconColor = Colors.white24,
    this.timeToManipulation,
    this.manipulationType,
    this.error = ''
  });

  SingleLocationState copyWith({
    SingleLocationModel? model,
    SingleLocationSchedule? schedule,
    Color? iconColor,
    String? timeToManipulation,
    int? manipulationType,
    String? error = ''
  }) {
    return SingleLocationState(
      model: model ?? this.model,
      schedule: schedule ?? this.schedule,
      iconColor: iconColor ?? this.iconColor,
      timeToManipulation: timeToManipulation ?? this.timeToManipulation,
      manipulationType: manipulationType ?? this.manipulationType,
      error: error ?? this.error
    );
  }

  @override
  List<Object?> get props => [schedule, error, model, iconColor, timeToManipulation, manipulationType];
}

enum SingleLocationSchedule {init, loading, loaded, error}


class SingleLocationCubit extends Cubit<SingleLocationState> {
  SingleLocationCubit(this.repository, this.groupId) : super(const SingleLocationState()) {
    getSchedule();
  }

  final SingleLocationRepository repository;
  final String groupId;

  void getSchedule() async {
    try {
      emit(state.copyWith(schedule: SingleLocationSchedule.loading, iconColor: Colors.white24));

      final scheduleData = await repository.fetchData(groupId);

      int dayNum = DateTime.now().weekday - 1;

      scheduleData.schedule![dayNum].shutdown?.forEach((element) {
        int minutesToManipulation;
        int hoursToManipulation;
        int timeNow = DateTime.now().hour;
        int timeNowMinutes = DateTime.now().minute;
        RegExp exp = RegExp(r'(\d{2}):(\d{2})-(\d{2}):(\d{2})');
        RegExpMatch? match = exp.firstMatch(element.range.toString());

        String? startHour = match?.group(1);
        String? startMinute = match?.group(2);
        String? endHour = match?.group(3);
        String? endMinute = match?.group(4);
        int startInt = int.parse(startHour.toString());
        int endInt = int.parse(endHour.toString());
        int startMinuteInt = int.parse(startMinute.toString());
        int endMinuteInt = int.parse(endMinute.toString());




        if (timeNow >= startInt && (timeNow < endInt || endInt == 0) && element.shutdownType! > 0) {


          emit(state.copyWith(iconColor: Colors.orangeAccent));
        }

        if (timeNow >= startInt && (timeNow < endInt || endInt == 0)) {

          int manipulationType;

          if (endMinuteInt == 0) {
            minutesToManipulation = 60 - timeNowMinutes;
          } else {
            minutesToManipulation = endMinuteInt - timeNowMinutes;
          }

          if (endInt == 0) {
            hoursToManipulation = 23 - timeNow;
          } else {
            hoursToManipulation = endInt - timeNow - 1;
          }

          if (element.shutdownType == 0) {
            manipulationType = 0;
          } else if (element.shutdownType == 1) {
            manipulationType = 1;
          } else {
            manipulationType = 2;
          }
          emit(state.copyWith(timeToManipulation: "$hoursToManipulation:$minutesToManipulation", manipulationType: manipulationType));
        }
      });

      emit(state.copyWith(schedule: SingleLocationSchedule.loaded, model: scheduleData));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
