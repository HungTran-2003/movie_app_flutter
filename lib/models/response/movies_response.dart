import 'package:movie_app/models/movie.dart';

class MoviesResponse {
  final int page;
  final int totalPages;
  final int totalResults;
  final List<Movie> results;

  MoviesResponse(this.page, this.totalPages, this.totalResults, this.results);

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    return MoviesResponse(
      json['page'] as int,
      json['total_pages'] as int,
      json['total_results'] as int,
      (json['results'] as List<dynamic>)
          .map((item) => Movie.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
