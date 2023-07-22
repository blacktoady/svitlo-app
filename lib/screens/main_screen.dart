import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:svitlo/data_bloc/data_bloc.dart';
import 'package:svitlo/data_cubit/data_cubit.dart';
import 'package:svitlo/main_screen_cubit/main_screen_cubit.dart';
import 'package:svitlo/repository/location_repository.dart';
import 'package:svitlo/tools/tools.dart';
import 'package:svitlo/ui_kit/app_bar.dart';
import 'package:svitlo/ui_kit/cards.dart';

import '../tools/url_launcher.dart';
import '../ui_kit/text_style.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {

  // final DataCubit cubit = DataCubit(repository: LocationRepository());

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => MainScreenCubit(LocationRepository()),
      child: BlocBuilder<MainScreenCubit, MainScreenState>(
        builder: (context, state) {

          // state.locations.forEach((element) {
          //   print('${element.locationName} ${element.locationGroup}');
          // });

          // print(state.locations.first.locationName);

          if (state.withLocations == MainScreenWithLocations.loaded) {

            return _mainScreenContentWithList(context, state.locations);
          }
          else if (state.noLocations == MainScreenNoLocations.loaded) {
            return _mainScreenContentWithoutList(context);
          }
          else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
            // return _mainScreenContentWithoutList(context);
          }
        },
      ),
    );

  }


  Widget _mainScreenContentWithoutList(context) {
    final Uri telegramUrl = Uri.parse("https://t.me/lyc_an");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        leading: leading,
        leadingWidth: MediaQuery
            .of(context)
            .size
            .width * 0.4,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.telegram_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            tooltip: "Our Telegram Bot",
            onPressed: () => launchLink(telegramUrl),
          ),
          IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            tooltip: "menu",
            onPressed: () {
              Navigator.pushNamed(context, '/menu');
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: const [
            AddLocationWidget(),
          ],
        ),
      ),
      backgroundColor: Colors.black26,
    );
  }

  Widget _mainScreenContentWithList(context, List model) {
    final Uri telegramUrl = Uri.parse("https://t.me/lyc_an");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        leading: leading,
        leadingWidth: MediaQuery
            .of(context)
            .size
            .width * 0.4,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.telegram_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            tooltip: "Our Telegram Bot",
            onPressed: () => launchLink(telegramUrl),
          ),
          IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            tooltip: "menu",
            onPressed: () {
              Navigator.pushNamed(context, '/menu');
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: model.length,
                itemBuilder: (context, index) =>
                    LocationCard(locObject: model[index]),
              ),
              if (kDebugMode) (
                  GestureDetector(
                    onTap: () {
                      MainScreenCubit cubit = MainScreenCubit(LocationRepository());

                      cubit.repository.deleteAllLocations();
                      Navigator.pushReplacementNamed(context, "/");
                    },
                    child: Container(
                        color: Colors.white30,
                        padding: const EdgeInsets.all(10.0),
                        child: debugText('delete all locations')
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_location');
        },
        backgroundColor: Colors.white12,
        child: const Icon(Icons.add, color: Colors.white, size: 30.0,),
      ),
      backgroundColor: Colors.black26,
    );
  }
}