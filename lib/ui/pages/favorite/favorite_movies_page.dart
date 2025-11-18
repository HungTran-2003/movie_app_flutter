import 'package:flutter/material.dart';
import 'package:movie_app/common/app_text_styles.dart';
import 'package:movie_app/models/entities/movie/movie_entity.dart';
import 'package:movie_app/service/movie_service.dart';
import 'package:movie_app/ui/pages/home/widgets/movie_widget.dart';
import 'package:movie_app/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:movie_app/ui/widgets/loading/app_loading_indicator.dart';

class FavoriteMoviesPage extends StatefulWidget {
  const FavoriteMoviesPage({super.key});

  @override
  State<FavoriteMoviesPage> createState() => _FavoriteMoviesPageState();
}

class _FavoriteMoviesPageState extends State<FavoriteMoviesPage> {
  final List<MovieEntity> _movies = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadMovie();
  }

  void _loadMovie() async {
    final response = await MovieService.instance.fetchFavoriteMovies();
    setState(() {
      _movies.addAll(response);
      _isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Favorite Movies",
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      body: _buildBodyPages(),
    );
  }

  Widget _buildBodyPages() {
    if(_movies.isEmpty && _isLoading) {
      return AppCircularProgressIndicator();
    }
    if(_movies.isEmpty && _isLoading == false){
      return Center(
          child: Column(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No data yet", style: AppTextStyle.whitePoppinsS18Regular,),

              ElevatedButton(onPressed: (){

              }, child: Text("Tải lại"))
            ],
          )
      );
    }
    return ListView(
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
    );
  }

  void _onScroll() {

  }
}
