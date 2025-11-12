
import 'package:flutter/material.dart';
import 'package:movie_app/common/app_text_styles.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/response/error_response.dart';
import 'package:movie_app/models/response/movies_response.dart';
import 'package:movie_app/service/movie_service.dart';
import 'package:movie_app/ui/pages/home/widgets/movie_widget.dart';
import 'package:movie_app/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:movie_app/ui/widgets/loading/app_loading_indicator.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _StateScreen1();
}

class _StateScreen1 extends State<HomePage> with AutomaticKeepAliveClientMixin {

  final List<Movie> _movies = [];
  String _error = "";

  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();


  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    loadMovie();

  }

  void loadMovie() async {
    setState(() {
      _isLoading = true;
    });
    final response = await MovieService.instance.fetchPopularMovies();
    
    if (response is MoviesResponse) {
      setState(() {
        _movies.addAll(response.results);
        _isLoading = false;
      });
    } else if (response is ErrorResponse) {
      setState(() {
        _error = response.statusMessage;
        _isLoading = false;
      });
    } else {
      setState(() {
        _error = response as String;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBarWidget(title: "Movies"),
      body: _buildBodyPages()
    );
  }
  
  Widget _buildBodyPages(){
    if (_movies.isEmpty && _error == "" && _isLoading == false) {
      return Center(
        child: Text("No Data Yet", style: AppTextStyle.whitePoppinsS18Regular,),
      );
    }
    if (_error != "" && _movies.isEmpty) {
      return Center(
        child: Text(_error, style: AppTextStyle.whitePoppinsS18Regular,),
      );
    }
    if (_movies.isEmpty && _error == "" && _isLoading) {
      return Center(
        child: AppCircularProgressIndicator(),
      );
    }
    return RefreshIndicator(
      onRefresh: _refreshMovies,
      child: ListView(
        controller: _scrollController,
        children:[
          ..._movies.map((movie) {
            return Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
              child: MovieWidget(
                movie: movie,
                onPressed: () {
                  Navigator.pushNamed(context, '/detail', arguments: movie);
                },
              ),
            );
          }),
          if(_isLoading && _movies.isNotEmpty)
            AppCircularProgressIndicator()
        ]
      ),
    );
  }

  void _onScroll(){
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if(currentScroll - maxScroll >= 120){
      if(_isLoading == false) {
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

