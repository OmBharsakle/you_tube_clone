import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_tube_clone/view/home/home_page.dart';
import 'package:you_tube_clone/view/video/video_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      getPages: [
        GetPage(name: "/", page: () => const HomePage(),),
        GetPage(name: "/video", page: () => const VideoPage(),),
      ],
    );
  }
}
