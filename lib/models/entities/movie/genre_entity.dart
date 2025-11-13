class GenreEntity {
  final int id;
  final String name;

  GenreEntity({required this.id, required this.name});

  factory GenreEntity.fromJson(Map<String, dynamic> json) {
    return GenreEntity(id: json['id'], name: json['name']);
  }
}
