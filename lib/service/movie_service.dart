
import 'dart:convert';

import 'package:http/http.dart' as http;

 class MovieService {
  int _page = 1;

  static final MovieService _instance = MovieService._internal();

  MovieService._internal();

  factory MovieService() {
    return _instance;
  }

  Future<String> fetchPopularMovies() async {
    String json;
    const apiKey = '478908aed938fe4f6fb095c7e99043a3'; // 🔑 thay bằng key thật
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=$_page');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        const encoder = JsonEncoder.withIndent('  ');
        json = encoder.convert(data);
        _page++;
        print(_page);
      } else {
        json = 'Lỗi: ${response.statusCode}';
      }
    } catch (e) {
      json = 'Lỗi kết nối: $e';
    }
    return json;
  }
}