import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svitlo/models/location_model.dart';
import 'dart:convert' as convert;

class LocationRepository {
  // const LocationRepository(this.locationName, this.locationGroup, this.locationIcon);

  void addLocation(String key, String locName, int locGroup, String locIcon) async {
    final prefs = await SharedPreferences.getInstance();


    if (prefs.getStringList('locations') != null) {
      final listOfItems = prefs.getStringList('locations');
      listOfItems?.addAll(['{"key":"$key","location_name":"$locName","location_group":$locGroup,"location_icon":"$locIcon"}']);

      prefs.setStringList('locations', listOfItems!);
    } else {
      prefs.setStringList('locations', ['{"key":"$key","location_name":"$locName","location_group":$locGroup,"location_icon":"$locIcon"}']);
    }

    print(prefs.getStringList("locations"));
  }

  void deleteLocation(String key) async {
    final prefs = await SharedPreferences.getInstance();

    var listOfItems = prefs.getStringList('locations');
    var locations = List<LocationModel>.of(
        listOfItems!.map<LocationModel>((element) {
          final json = convert.jsonDecode(element) as Map<String, dynamic>;

          return LocationModel(
              key: json['key'],
              locationName: json['location_name'],
              locationGroup: json['location_group'],
              locationIcon: json['location_icon']
          );
        })
    );

    locations.removeWhere((element) => element.key == key);

    final resultList = List.of(
      locations.map((e) {
        final json = convert.jsonEncode(e);

        return json;

      })
    );

    prefs.remove('locations');
    if (resultList.length > 0) {
      prefs.setStringList('locations', resultList);
    }

  }

  void test() async {
    final prefs = await SharedPreferences.getInstance();

    final listOfItems = prefs.getStringList("locations");

    print(listOfItems![1]);
  }

  void deleteAllLocations() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('locations');
  }
  //
  Future<List<LocationModel>> getLocations() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final listOfItems = prefs.getStringList('locations');
      
      final locations = List<LocationModel>.of(
        listOfItems!.map<LocationModel>((element) {
          final json = convert.jsonDecode(element) as Map<String, dynamic>;

          return LocationModel(
            key: json['key'],
            locationName: json['location_name'],
            locationGroup: json['location_group'],
            locationIcon: json['location_icon']
          );
        })
      );

      return locations;
    } catch (e) {
      return [LocationModel.withError(404)];
    }
  }
}