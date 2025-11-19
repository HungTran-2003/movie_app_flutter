import 'package:flutter/material.dart';
import 'package:movie_app/common/app_text_styles.dart';
import 'package:movie_app/models/entities/movie/movie_entity.dart';
import 'package:movie_app/provider/movies_bookmark.dart';
import 'package:movie_app/ui/pages/home/widgets/movie_widget.dart';
import 'package:movie_app/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:movie_app/ui/widgets/loading/app_loading_indicator.dart';
import 'package:provider/provider.dart';

class BookmarkMoviesPage extends StatefulWidget {
  const BookmarkMoviesPage({super.key});

  @override
  State<BookmarkMoviesPage> createState() => _BookmarkMoviesPageState();
}

class _BookmarkMoviesPageState extends State<BookmarkMoviesPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    final provider = context.read<BookMarkProvider>();
    provider.loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookMarkProvider>();

    return Scaffold(
      appBar: AppBarWidget(
        title: "Bookmark Movies",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: _buildBodyPages(provider.bookmarks, provider.isLoading),
    );
  }

  Widget _buildBodyPages(List<MovieEntity> movies, bool isLoading) {
    if (movies.isEmpty && isLoading) {
      return AppCircularProgressIndicator();
    }
    if (movies.isEmpty && isLoading == false) {
      return Center(
        child: Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No data yet", style: AppTextStyle.whitePoppinsS18Regular),

            ElevatedButton(onPressed: () {}, child: Text("Tải lại")),
          ],
        ),
      );
    }
    return ListView(
      controller: _scrollController,
      children: [
        ...movies.map((movie) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              bottom: 24.0,
            ),
            child: MovieWidget(
              movie: movie,
              onPressed: () {
                Navigator.pushNamed(context, '/detail', arguments: movie);
              },
            ),
          );
        }),
        // if (isLoading && movies.isNotEmpty) AppCircularProgressIndicator(),
      ],
    );
  }

  void _onScroll() {}
}
