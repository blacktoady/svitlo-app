import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:svitlo/screens/add_location/select_name.dart';

import '../../ui_kit/text_style.dart';

List groups = ['Група 1', "Група 2", "Група 3"];

class SelectGroup extends StatelessWidget {
  const SelectGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text("Виберіть групу",
          style: p,
        ),
        actions: <Widget>[
          IconButton(
            alignment: Alignment.centerRight,
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: groups.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    color: Colors.white12,
                    border: Border.symmetric(horizontal: BorderSide())
                  ),
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelectName(groupId: '${index + 1}')));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(groups[index], style: p,),
                        const Icon(Icons.navigate_next_rounded, size: 20.0, color: Colors.white24,)
                      ],
                    ),
                  ),
                );
              }
            )
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }


}