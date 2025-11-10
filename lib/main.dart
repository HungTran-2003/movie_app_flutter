import 'package:flutter/material.dart';
import 'package:movie_app/common/app_colors.dart';
import 'package:movie_app/ui/pages/home/home_page.dart';
import 'package:movie_app/ui/pages/Screen2.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "hello",
      initialRoute: "/",
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/screen2': (BuildContext context) => Screen2(),
      },
      theme: ThemeData(scaffoldBackgroundColor: AppColors.primary),
    );
  }
}
