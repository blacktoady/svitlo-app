import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Widget debugText(String data) {
  return Row(
    children: [
      const Text('debug data:', style: TextStyle(color: Colors.green),),
      const Gap(5.0),
      Text(data, style: const TextStyle(color: Colors.lightGreen))
    ],
  );
}