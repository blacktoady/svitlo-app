import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui_kit/text_style.dart';

class AboutUs extends StatelessWidget {
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
            Beamer.of(context).beamBack();
          },
        ),
        title: Text("Про нас",
          style: p,
        ),
      ),
      body: Center(
        child: Text("about",
          style: p,
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

}