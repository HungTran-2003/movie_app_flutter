import 'package:movie_app/models/entities/movie/movie_entity.dart';

class MoviesResponse {
  final int page;
  final int totalPages;
  final int totalResults;
  final List<MovieEntity> results;

  MoviesResponse(this.page, this.totalPages, this.totalResults, this.results);

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    return MoviesResponse(
      json['page'] as int,
      json['total_pages'] as int,
      json['total_results'] as int,
      (json['results'] as List<dynamic>)
          .map((item) => MovieEntity.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
