import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svitlo/ui_kit/app_bar.dart';

import '../ui_kit/text_style.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20.0,
          ),
          onPressed: () {
            Navigator.pop(context);
            // Beamer.of(context).beamBack();
          },
        ),
        title: Text("Головне меню",
          style: p,
        ),
      ),
      body: Center(
        child: Text("menu",
          style: p,
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

}