
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/app_text_styles.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/response/error_response.dart';
import 'package:movie_app/models/response/movies_response.dart';
import 'package:movie_app/service/movie_service.dart';
import 'package:movie_app/ui/pages/home/widgets/movie_widget.dart';
import 'package:movie_app/ui/widgets/app_bar/app_bar_widget.dart';

class HomePage extends StatefulWidget{

  @override
  State<HomePage> createState() => _StateScreen1();

}

class _StateScreen1 extends State<HomePage> with AutomaticKeepAliveClientMixin {

  List<Movie> _movies = [];
  String _error = "";

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    loadMovie();

  }

  void loadMovie() async {
    final response = await MovieService().fetchPopularMovies();
    
    if (response is MoviesResponse) {
      setState(() {
        _movies = response.results;
      });
    } else if (response is ErrorResponse) {
      setState(() {
        _error = response.statusMessage;
      });
    } else {
      setState(() {
        _error = response as String;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBarWidget(title: "Movies"),

      body: _buildBodyPages()
    );
  }
  
  Widget _buildBodyPages(){
    if (_movies.isEmpty && _error == "") {
      return Center(
        child: Text("No Data Yet", style: AppTextStyle.whitePoppinsS18Regular,),
      );
    }
    if (_error != "" && _movies.isEmpty) {
      return Center(
        child: Text(_error, style: AppTextStyle.whitePoppinsS18Regular,),
      );
    }
    return GridView.count(
      crossAxisCount: 1,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      children: _movies.map((movie) {
        return Container(
          height: 120,
          child: MovieWidget(
            movie: movie,
            onPressed: () {
              print(movie.title);
            },
          ),
        );
      }).toList(),
    );

  }


}

