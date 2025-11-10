
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/response/error_response.dart';
import 'package:movie_app/models/response/movies_response.dart';

 class MovieService {
  int _page = 1;

  static final MovieService _instance = MovieService._internal();

  MovieService._internal();

  factory MovieService() {
    return _instance;
  }

  Future<Object> fetchPopularMovies() async {
    const apiKey = '478908aed938fe4f6fb095c7e99043a3';
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=$_page');
    try {
      final response = await http.get(url);
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      print(jsonData.toString());
      if (response.statusCode == 200) {
        return MoviesResponse.fromJson(jsonData);
      } else {
        return ErrorResponse.fromJson(jsonData);
      }
    } catch (e) {
      return 'Lỗi kết nối: $e';
    }
  }
}