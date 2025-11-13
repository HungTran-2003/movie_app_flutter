import 'package:movie_app/models/entities/movie/genre_entity.dart';

class MovieEntity {
  int? id;
  String? title;
  String? posterPath;
  String? backdropPath;
  double? voteAverage;
  String? overview;
  String? releaseDate;
  int? duration;
  List<GenreEntity>? genres;

  MovieEntity({
    this.id,
    this.title,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.overview,
    this.releaseDate,
    this.duration,
    this.genres,
  });

  factory MovieEntity.fromJson(Map<String, dynamic> json) {
    final posterPath = json['poster_path'];
    final backdropPath = json['backdrop_path'];
    return MovieEntity(
      id: json['id'],
      title: json['title'],
      posterPath: 'https://image.tmdb.org/t/p/original${posterPath ?? ""}',
      backdropPath: 'https://image.tmdb.org/t/p/original${backdropPath ?? ""}',
      voteAverage: json['vote_average'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => GenreEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      duration: json['runtime'],
    );
  }
}
