import 'package:flutter/material.dart';
import 'package:movie_app/common/app_dialogs.dart';
import 'package:movie_app/common/app_text_styles.dart';
import 'package:movie_app/configs/app_configs.dart';
import 'package:movie_app/models/entities/movie/movie_entity.dart';
import 'package:movie_app/models/response/error_response.dart';
import 'package:movie_app/service/movie_service.dart';
import 'package:movie_app/ui/pages/home/widgets/movie_widget.dart';
import 'package:movie_app/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:movie_app/ui/widgets/loading/app_loading_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _StateScreen1();
}

class _StateScreen1 extends State<HomePage> {
  final List<MovieEntity> _movies = [];

  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    loadMovie();
  }

  void loadMovie() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      final response = await MovieService.instance.fetchPopularMovies();
      setState(() {
        _movies.addAll(response.results);
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      if (e is ErrorResponse) {
        AppDialogs(context: context).showSimpleDialog(
          title: "Error: ${e.statusCode}",
          content: e.statusMessage,
        );
      } else {
        AppDialogs(
          context: context,
        ).showSimpleDialog(title: "Error System", content: e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Movies",
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/bookmark');
            },
            icon: Icon(Icons.favorite, color: Colors.white),
          ),
        ],
      ),
      body: _buildBodyPages(),
    );
  }

  Widget _buildBodyPages() {
    if (_movies.isEmpty && _isLoading == false) {
      return Center(
        child: Text("No Data Yet", style: AppTextStyle.whitePoppinsS18Regular),
      );
    }

    if (_movies.isEmpty && _isLoading) {
      return Center(child: AppCircularProgressIndicator());
    }
    return RefreshIndicator(
      onRefresh: _refreshMovies,
      child: ListView(
        controller: _scrollController,
        children: [
          ..._movies.map((movie) {
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
          if (_isLoading && _movies.isNotEmpty) AppCircularProgressIndicator(),
        ],
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll - maxScroll >= AppConfigs.scrollThreshold) {
      if (_isLoading == false) {
        loadMovie();
      }
    }
  }

  Future<void> _refreshMovies() async {
    _movies.clear();
    MovieService.instance.refreshData();
    loadMovie();
  }
}
