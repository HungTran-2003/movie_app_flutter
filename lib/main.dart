import 'package:flutter/material.dart';
import 'package:movie_app/common/app_colors.dart';
import 'package:movie_app/models/entities/movie/movie_entity.dart';
import 'package:movie_app/ui/pages/favorite/favorite_movies_page.dart';
import 'package:movie_app/ui/pages/home/home_page.dart';
import 'package:movie_app/ui/pages/detail/movie_detail_page.dart';

import 'database/app_share_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharePreferences.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "hello",
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case "/":
            return MaterialPageRoute(builder: (_) => HomePage());
          case "/detail":
            final MovieEntity movie = settings.arguments as MovieEntity;
            return MaterialPageRoute(
              builder: (_) => MovieDetailPage(movieId: movie.id ?? -1),
            );
          case "/favorite":
            return MaterialPageRoute(builder: (_) => FavoriteMoviesPage());
        }
        return null;
      },
      theme: ThemeData(scaffoldBackgroundColor: AppColors.primary),
    );
  }
}
