import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movie_app/configs/app_configs.dart';
import 'package:movie_app/database/app_share_preferences.dart';
import 'package:movie_app/models/entities/movie/movie_entity.dart';
import 'package:movie_app/models/response/error_response.dart';
import 'package:movie_app/models/response/movies_response.dart';

class MovieService {
  static const apiKey = MovieAPIConfig.apiKey;
  static const baseUrl = AppConfigs.baseUrl;

  int _page = 1;

  static final MovieService _instance = MovieService._internal();
  MovieService._internal();
  static MovieService get instance => _instance;


  Future<MoviesResponse> fetchPopularMovies() async {
    final url = Uri.parse(
      '$baseUrl/movie/popular?api_key=$apiKey&language=en-US&page=$_page',
    );
    final response = await http.get(url);
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    log(jsonData.toString());
    if (response.statusCode == 200) {
      _page += 1;
      return MoviesResponse.fromJson(jsonData);
    } else {
      throw ErrorResponse.fromJson(jsonData);
    }
  }

  Future<MovieEntity> fetchDetailMovie(int movieId) async {
    final url = Uri.parse(
      '$baseUrl/movie/$movieId?api_key=$apiKey&language=en-US',
    );
    final response = await http.get(url);
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    log(jsonData.toString());
    if (response.statusCode == 200) {
      return MovieEntity.fromJson(jsonData);
    } else {
      throw ErrorResponse.fromJson(jsonData);
    }
  }

  void refreshData() {
    _page = 1;
  }

  Future<List<MovieEntity>> fetchFavoriteMovies() async {
    final ids = AppSharePreferences.instance.getIds();
    final movies = (await Future.wait(
      ids.map((id) async {
        try {
          return await fetchDetailMovie(id);
        } catch (e) {
          print('Error fetching id $id: $e');
          return null;
        }
      }),
    )).whereType<MovieEntity>().toList();


    return movies;
  }
}
