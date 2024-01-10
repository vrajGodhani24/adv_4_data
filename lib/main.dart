import 'package:adv_4_database/module/views/homepage/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: <GetPage>[
        GetPage(name: '/', page: () => const HomePage()),
      ],
    ),
  );
}
