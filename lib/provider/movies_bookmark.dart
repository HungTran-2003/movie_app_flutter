import 'package:flutter/cupertino.dart';
import 'package:movie_app/database/app_share_preferences.dart';
import 'package:movie_app/models/entities/movie/movie_entity.dart';
import 'package:movie_app/service/movie_service.dart';

class BookMarkProvider extends ChangeNotifier {
  static final _prefs = AppSharePreferences.instance;
  final List<int> _ids = [];

  List<MovieEntity> _bookmarks = [];

  List<MovieEntity> get bookmarks => _bookmarks;

  bool isLoading = true;

  BookMarkProvider() {
    _ids.addAll(_prefs.getIds());
  }

  Future<void> loadBookmarks() async {
    if (_ids.isEmpty) {
      isLoading = false;
      notifyListeners();
    }
    final movies = (await Future.wait(
      _ids.map((id) async {
        try {
          return await MovieService.instance.fetchDetailMovie(id);
        } catch (e) {
          print('Error fetching id $id: $e');
          return null;
        }
      }),
    )).whereType<MovieEntity>().toList();
    _bookmarks = movies;
    isLoading = false;
    notifyListeners();
  }

  void removeBookmark(int movieId) {
    _bookmarks.removeWhere((item) => item.id == movieId);
    _ids.remove(movieId);
    _prefs.saveIds(_ids);
    notifyListeners();
  }

  bool isBookmarked(int movieId) {
    return _bookmarks.any((item) => item.id == movieId);
  }

  void addBookmark(MovieEntity movie) {
    _bookmarks.add(movie);
    _ids.add(movie.id!);
    _prefs.saveIds(_ids);
    notifyListeners();
  }
}
