import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:svitlo/main_screen_cubit/main_screen_cubit.dart';
import 'package:svitlo/models/icon_model.dart';
import 'package:svitlo/models/location_model.dart';
import 'package:svitlo/models/single_location_model.dart';
import 'package:svitlo/repository/single_location_repository.dart';
import 'package:svitlo/single_location_cubit/single_location_cubit.dart';
import 'package:svitlo/tools/tools.dart';

import '../repository/location_repository.dart';
import '../ui_kit/text_style.dart';

class SingleLocation extends StatelessWidget {
  final LocationModel locObject;

  SingleLocation({Key? key, required this.locObject}) : super(key: key);

  final MainScreenCubit cubit = MainScreenCubit(LocationRepository());
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20.0,
          ),
          onPressed: () {
            // Beamer.of(context).beamBack();
            Navigator.pop(context);
          },
        ),

      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: BlocProvider(
          create: (_) => SingleLocationCubit(SingleLocationRepository(), locObject.locationGroup.toString()),
          child: BlocBuilder<SingleLocationCubit, SingleLocationState>(
            builder: (context, state) {
              if (state.schedule == SingleLocationSchedule.loading) {
                return _loading();
              } else if (state.schedule == SingleLocationSchedule.loaded) {
                return SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text("icon ${locObject.locationIcon}", style: p,),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: state.iconColor,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Icon(materialIcons[locObject.locationIcon], size: 50.0, color: Colors.white,)
                          ),
                          const Gap(15.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(locObject.locationName.toString(), style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 38.0,
                                color: Colors.white
                              ),),
                              const Gap(10.0),
                              Container(
                                  padding: EdgeInsets.all(7.5),
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Text("Група ${locObject.locationGroup}", style: const TextStyle(
                                      color: Colors.white38,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.0,
                                      height: 1.2
                                  ),)
                              ),
                              if (kDebugMode) (
                                debugText("location id: ${locObject.key}")
                              )
                            ],
                          ),
                        ],
                      ),
                      const Gap(15.0),
                      _scheduleTable(state.model!.schedule!),
                      const Gap(15.0),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: const [
                              Icon(Icons.notifications, size: 32.0, color: Colors.white38,),
                              Gap(10.0),
                              Text("Сповіщення за графіком", style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                              ),)
                            ],
                          ),
                        ),
                      ),
                      const Gap(15.0),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: GestureDetector(
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => CupertinoAlertDialog(
                              title: const Text('Видалити'),
                              content: const Text('Ви впевнені, що хочете видалити локацію'),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                  child: const Text('Ні'),
                                ),
                                CupertinoDialogAction(
                                  isDestructiveAction: true,
                                  onPressed: () {
                                    cubit.repository.deleteLocation(locObject.key.toString());
                                    Navigator.pushReplacementNamed(context, '/');
                                  },
                                  child: const Text('Так'),
                                ),
                              ],
                            ),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.delete, size: 32.0, color: Colors.white38,),
                              Gap(10.0),
                              Text("Видалити локацію", style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                              ),)
                            ],
                          ),
                        ),
                      ),
                      debugText(state.timeToManipulation.toString()),
                      debugText(state.manipulationType.toString()),
                    ],
                  ),
                );
              } else {
                return const Text("something went wrong!!", style: p,);
              }

            },
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  List<Widget> _days(List<Schedule> dataList) {
    List<Widget> widgets = [];
    
    dataList.forEach((element) {
      widgets.add(
        Text(element.dayOfWeek.toString(), style: p,)
      );
    });
    
    return widgets;
  }

  Widget _scheduleTable(List<Schedule> dataList) {

    List<Widget> tabs = [];
    List<Widget> tabViews = [];

    var timeNow = DateTime.now().hour;

    // print(timeNow);

    var timeNowMinutes = DateTime.now().minute;

    for (int i = 0; i < dataList.length; i++) {
      List<Widget> shutdownsList = [];




      dataList[i].shutdown?.forEach((element) {

        RegExp exp = RegExp(r'(\d{2}):(\d{2})-(\d{2}):(\d{2})');
        RegExpMatch? match = exp.firstMatch(element.range.toString());

        // int startHour = int.parse(match!.group(2).toString());
        // int endHour = int.parse(match.group(4).toString());

        String? startHour = match?.group(1);
        String? endHour = match?.group(3);
        int startInt = int.parse(startHour.toString());
        int endInt = int.parse(endHour.toString());

        BoxDecoration decorator = BoxDecoration();



        if (timeNow >= startInt && (timeNow < endInt || endInt == 0) && i == DateTime.now().weekday - 1) {
          decorator = BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(15.0)
          );
        }

        shutdownsList.add(
          Container(
            decoration: decorator,
            padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 12.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (element.shutdownType == 0) (
                    const Icon(Icons.flash_off, size: 20.0, color: Colors.white38,)
                ),
                if (element.shutdownType == 1) (
                    const Icon(Icons.error, size: 20.0, color: Colors.white38,)
                ),
                if (element.shutdownType == 2) (
                    const Icon(null, size: 20.0, color: Colors.white38,)
                ),
                if (element.shutdownType == 0) (
                    Text(element.range.toString(), style: p_schedule,)
                ) else (
                    Text(element.range.toString(), style: p_schedule_on,)
                ),
                Text('${element.quantity}г', style: p_schedule,)
              ],
            ),
          )

        );
      });


      if (i == DateTime.now().weekday - 1) {
        tabs.add(
            Tab(
                iconMargin: const EdgeInsets.all(0.0),
                child: Container(
                  width: 45.0,
                  height: 45.0,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white24,
                      border: Border.all(color: Colors.orangeAccent, width: 1.0)
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      dataList[i].dayOfWeek.toString(),
                      // style: const TextStyle(
                      //   // fontSize: 13.0,
                      //   color: Colors.orange,
                      //   // fontWeight: FontWeight.w400
                      // ),
                    ),
                  ),
                )
            )
        );
      } else {
        tabs.add(
            Tab(
              // text: dataList[i].dayOfWeek.toString(),
                iconMargin: const EdgeInsets.all(0.0),
                child: Container(
                  width: 45.0,
                  height: 45.0,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white24,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      dataList[i].dayOfWeek.toString(),
                      // style: const TextStyle(
                      //     // fontSize: 12.0,
                      //     color: Colors.white,
                      //     // fontWeight: FontWeight.w400
                      // )
                    ),
                  ),
                )
            )
        );
      }

      tabViews.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          height: shutdownsList.length * 20.0,
          child: Column(
            children: shutdownsList,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: const BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
      child: Column(
        children: [
          DefaultTabController(
            initialIndex: DateTime.now().weekday - 1,
            length: dataList.length,
            // animationDuration: Duration.zero,
            child: Column(
              children: [
                TabBar(
                  unselectedLabelColor: Colors.orangeAccent,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 0,
                  indicatorPadding: EdgeInsets.zero,
                  indicator: BoxDecoration(
                    shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.orange),
                  labelColor: Colors.white,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w700
                  ),
                  labelPadding: const EdgeInsets.all(0),
                    tabs: tabs
                ),
                const Gap(15.0),
                Container(
                  height: (tabViews.length)  * 21.0,
                  child: TabBarView(
                    children: tabViews,
                  ),
                ),
                const Gap(10.0),
                Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.white38,
                  child: const Text(''),
                ),
                const Gap(10.0),
                Column(
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.flash_off, size: 20.0, color: Colors.white38,),
                        Gap(15.0),
                        Text('Відключення світла', style: p_schedule,)
                      ],
                    ),
                    const Gap(10.0),
                    Row(
                      children: const [
                        Icon(Icons.error, size: 20.0, color: Colors.white38,),
                        Gap(15.0),
                        Text('Можливі відключення світла', style: p_schedule,)
                      ],
                    )
                  ],
                )

              ],
            ),
          ),
        ],
      ),
    );

  }
  
  Widget _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}