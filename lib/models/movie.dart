class Movie {
  int? id;
  String? title;
  String? posterPath;
  String? backdropPath;
  double? voteAverage;
  String? overview;
  String? releaseDate;
  int? duration;
  List<int>? genres;

  Movie({
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

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: json['vote_average'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      genres: json['genres'],
      duration: json['runtime']
    );
  }
}
