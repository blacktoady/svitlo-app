
import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:svitlo/screens/add_location/select_group.dart';
import 'package:svitlo/screens/add_location/select_name.dart';
import 'package:svitlo/screens/main_screen.dart';
import 'package:svitlo/screens/menu_about_screen.dart';
import 'package:svitlo/screens/menu_screen.dart';


void main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final routerDelegate = BeamerDelegate(
      locationBuilder: RoutesLocationBuilder(
        routes: {
          '/': (context, state, data) => const MainScreen(),
          '/menu': (context, state, data) => const MenuScreen(),
          '/menu/about': (context, state, data) => AboutUs(),
          '/add_location': (context, state, data) => const SelectGroup(),
          '/add_location/:groupId': (context, state, data) {
            final groupId = state.pathParameters['groupId']!;

            return BeamPage(child: SelectName(groupId: groupId,));
          }

        }
      )
  );
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //   debugShowCheckedModeBanner: false,
    //   routeInformationParser: BeamerParser(),
    //   routerDelegate: routerDelegate
    // );
    return MaterialApp(
      // home: MainScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/menu': (context) => const MenuScreen(),
        '/menu/about': (context) => AboutUs(),
        '/add_location': (context) => const SelectGroup(),
      },
    );
  }
}

