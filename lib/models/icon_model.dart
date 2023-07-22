import 'package:flutter/material.dart';

class IconModel {
  String? iconName;
  IconData iconData;
  bool? selected;

  IconModel({required this.iconName, required this.iconData, required this.selected});

  // IconModel.withError(int e) {
  //   error = e;
  // }
}


final materialIcons = {
  'home': Icons.home,
  'gym': Icons.fitness_center,
  'work': Icons.work,
  'car': Icons.directions_car
};