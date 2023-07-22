import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svitlo/models/location_model.dart';
import 'package:svitlo/screens/add_location/select_group.dart';
import 'package:svitlo/screens/single_location.dart';
import 'package:svitlo/ui_kit/text_style.dart';

import '../models/icon_model.dart';

class AddLocationWidget extends StatelessWidget {

  const AddLocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(20.0),
      // color: Colors.white12,
      width: double.infinity,
      // padding: EdgeInsets.all(20.0),
      // color: Colors.white12,
      child: ElevatedButton(
        onPressed: () {
          // Beamer.of(context).beamToNamed('/add_location', routeState: 3);
          // Beamer.of(context).beamToNamed('/add_location');
          // Beamer.of(context).beamTo(SelectGroup(group: 3));
          Navigator.pushNamed(context, '/add_location');
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)
          ),
          textStyle: p,

        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              Container(
                width: 70.0,
                height: 70.0,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  color: Colors.white12
                ),
                child: Icon(Icons.add, color: Colors.white, size: 40.0,),
              ),
              Gap(15.0),
              Text(
                "Додайте першу локацію",
                style: p_card,
              )
            ],
          ),
        ),
      ),
      // decoration: BoxDecoration(
      //     color: Colors.white12,
      //     borderRadius: BorderRadius.circular(30.0)
      // ),
    )  ;
  }

}

class LocationCard extends StatelessWidget {

  LocationModel locObject;

  LocationCard({Key? key, required this.locObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SingleLocation(locObject: locObject,)));
      },
         child: Container(
           decoration: BoxDecoration(
               color: Colors.white12,
               borderRadius: BorderRadius.circular(15.0)
           ),
           margin: const EdgeInsets.only(bottom: 10.0),
           padding: const EdgeInsets.all(15.0),
           child: Row(
             children: [
               Icon(materialIcons[locObject.locationIcon.toString()], size: 50.0, color: Colors.white),
               const Gap(15.0),
               Column(
                 children: [
                   Text(locObject.locationName.toString(), style: p,)
                 ],

               )
             ],
           ),
         ),
    );

  }
}